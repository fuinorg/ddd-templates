package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.cqrs.cqrsDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single setter.
 */
class SrcBuilderSetter implements CodeSnippet {
	
    val CodeSnippetContext ctx
    val Variable variable

    new(CodeSnippetContext ctx, GenerateOptions options, Variable variable) {
        this.ctx = ctx
        this.variable = variable
        if (variable.nullable === null) {
            ctx.requiresImport("jakarta.validation.constraints.NotNull")
            ctx.requiresImport("org.fuin.objects4j.common.Contract")        
        } else {
            ctx.requiresImport("jakarta.annotation.Nullable")
        }
        addRequiredReferences(variable, ctx)
    }

    override toString() {
        '''    
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
            delegate.«variable.name» = «variable.name»;
            return this;
        }
        '''
    }
	
}