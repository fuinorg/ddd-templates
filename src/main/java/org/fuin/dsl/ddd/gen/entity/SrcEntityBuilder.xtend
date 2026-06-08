package org.fuin.dsl.ddd.gen.entity

import org.fuin.dsl.cqrs.cqrsDsl.Entity
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsAggregateExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsConstructorExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEntityExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates a builder snippet for an entity.
 *
 * As an entity requires its aggregate root and identifier at construction time (the root is final), the generated
 * builder collects the mandatory data and the attributes and creates the concrete instance via its real constructor.
 * Entities with a custom constructor are built by passing the constructor parameters and propagating its checked
 * exceptions; the remaining attributes are assigned through the protected setters of the abstract entity.
 */
class SrcEntityBuilder implements CodeSnippet {

	val CodeSnippetContext ctx
	val GenerateOptions options
    val Entity entity

    new(CodeSnippetContext ctx, GenerateOptions options, Entity entity) {
    	this.ctx = ctx
    	this.options = options
        this.entity = entity
        ctx.requiresImport("org.fuin.ddd4j.core.AbstractEntity")
        ctx.requiresReference(entity.idTypeNullsafe.uniqueName)
        ctx.requiresReference(entity.rootNullsafe.uniqueName)
        ctx.requiresReference(entity.rootNullsafe.idTypeNullsafe.uniqueName)
        for (attribute : entity.attributes) {
            if (attribute.nullable === null) {
                ctx.requiresImport("jakarta.validation.constraints.NotNull")
                ctx.requiresImport("org.fuin.objects4j.common.Contract")
            } else {
                ctx.requiresImport("jakarta.annotation.Nullable")
            }
            addRequiredReferences(attribute, ctx)
        }
    }

    override toString() {
        val variables = entity.attributes
        val constructor = if (entity.constructors === null || entity.constructors.size == 0) null else entity.constructors.head
        val ctorParams = if (constructor === null || constructor.parameters === null) #[] else constructor.parameters
        val ctorParamNames = ctorParams.map[name].toSet
        val exceptions = if (constructor === null) null else constructor.allExceptions
        val setterAttributes = variables.filter[!ctorParamNames.contains(name)]
        '''
        /**
         * Builds an instance of the outer class.
         */
        public static final class Builder extends AbstractEntity.Builder<«entity.rootNullsafe.idTypeNullsafe.name», «entity.rootNullsafe.name», «entity.idTypeNullsafe.name», «entity.name», Builder> {

            «new SrcVarsDecl(ctx, "private", options, variables)»
            private Builder() {
                super();
            }

            «FOR variable : variables»
            /**
             * Sets: «variable.superDoc.text»
             *
             * @param «variable.name» Value to set.
             * @return This builder.
             */
            public Builder «variable.name.toFirstLower»(«IF variable.nullable === null»@NotNull «ELSE»@Nullable «ENDIF»final «variable.type(ctx)» «variable.name») {
                «IF variable.nullable === null»
                Contract.requireArgNotNull("«variable.name»", «variable.name»);
                «ENDIF»
                this.«variable.name» = «variable.name»;
                return this;
            }

            «ENDFOR»
            /**
             * Creates the entity and clears the builder.
             *
             * @return New instance.
             */
            @Override
            public «entity.name» build()«new SrcThrowsExceptions(ctx, exceptions)» {
                ensureBuildableAbstractEntity();
                «FOR variable : variables»
                «IF variable.nullable === null»ensureNotNull("«variable.name»", «variable.name»);«ENDIF»
                «ENDFOR»

                final «entity.name» result = new «entity.name»(getRootAggregate(), getEntityId()«FOR param : ctorParams», «param.name»«ENDFOR»);
                «FOR variable : setterAttributes»
                result.set«variable.name.toFirstUpper»(«variable.name»);
                «ENDFOR»

                resetAbstractEntity();
                «FOR variable : variables»
                this.«variable.name» = null;
                «ENDFOR»
                return result;
            }

        }
        '''
    }

}
