package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.cqrs.cqrsDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single getter.
 */
class SrcGetter implements CodeSnippet {

    val CodeSnippetContext ctx
    val String modifiers
    val Variable variable

    new(CodeSnippetContext ctx, GenerateOptions options, String modifiers, Variable variable) {
        this.ctx = ctx
        this.modifiers = modifiers
        this.variable = variable
        
        if (variable.nullable === null) {
            ctx.requiresImport("jakarta.validation.constraints.NotNull")        
        } else {
            ctx.requiresImport("jakarta.annotation.Nullable")        
        }
        addRequiredReferences(variable, ctx)
    }

    override toString() {
        '''    
            /**
             * Returns: «variable.superDoc.text»
             *
             * @return Current value.
             */
            «IF variable.nullable === null»@NotNull«ELSE»@Nullable«ENDIF»
            «modifiers» «variable.type(ctx)» get«variable.name.toFirstUpper»() {
                return «variable.name»;
            }
        '''
    }

}
