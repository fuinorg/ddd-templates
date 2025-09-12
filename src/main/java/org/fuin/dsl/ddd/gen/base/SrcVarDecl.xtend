package org.fuin.dsl.ddd.gen.base

import jakarta.validation.constraints.NotNull
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import jakarta.annotation.Nullable
import org.fuin.dsl.cqrs.cqrsDsl.Variable

/**
 * Creates source code for a single attribute declaration.
 */
class SrcVarDecl implements CodeSnippet {

    val CodeSnippetContext ctx
    val String modifiers
    val GenerateOptions options
    val Variable variable

    /**
     * Constructor with all mandatory data.
     * 
     * @param ctx Context.
     * @param modifiers Modifiers for the attribute.
     * @param options Options to use.
     * @param variable Attribute or Parameter.
     */
    new(CodeSnippetContext ctx, String modifiers, GenerateOptions options, Variable variable) {
        this.ctx = ctx
        this.modifiers = modifiers
        this.options = options
        this.variable = variable

        if (variable.nullable === null) {
            ctx.requiresImport(NotNull.name)
        } else {
            ctx.requiresImport(Nullable.name)
        }
        addRequiredReferences(variable, ctx)
    }

    override toString() {
        '''
            «validationAnnotations»
            «xmlAnnotations»
            «jsonAnnotations»
            «new SrcMetaAnnotations(ctx, variable.overriddenMeta, null, variable.name)»
            «modifiers» «variable.type(ctx)» «variable.name»;
        '''
    }

    private def validationAnnotations() {
        '''
            «FOR cc : variable.constraints SEPARATOR ' '»
                «new SrcValidationAnnotation(ctx, cc)»
            «ENDFOR»
            «IF variable.nullable === null»
                @NotNull
            «ELSE»
                @Nullable
            «ENDIF»
        '''
    }

    private def xmlAnnotations() {
        '''
            «IF options.jaxb»
                «new SrcXmlAttributeOrElement(ctx, variable, options.jaxbElements)»
            «ENDIF»
        '''
    }

    private def jsonAnnotations() {
        '''
            «IF options.jsonb»
                «new SrcJsonProperty(ctx, variable)»
            «ENDIF»
        '''
    }

}
