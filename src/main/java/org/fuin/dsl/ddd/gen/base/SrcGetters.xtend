package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import org.fuin.dsl.cqrs.cqrsDsl.Variable
import java.util.ArrayList

/**
 * Creates source code for one or more getters.
 */
class SrcGetters implements CodeSnippet {

    val CodeSnippetContext ctx
    val GenerateOptions options
    val String modifiers
    val List<? extends Variable> variables

    new(CodeSnippetContext ctx, GenerateOptions options, String modifiers, List<? extends Variable> variables) {
        this.ctx = ctx
        this.options = options
        this.modifiers = modifiers
        this.variables = new ArrayList<Variable>(variables)
        for (Variable attribute : variables) {
            ctx.requiresReference(attribute.type.uniqueName)
        }
    }

    override toString() {
        '''    
            «FOR v : variables»
                «new SrcGetter(ctx, options, modifiers, v).toString»
                
            «ENDFOR»            
        '''
    }

}
