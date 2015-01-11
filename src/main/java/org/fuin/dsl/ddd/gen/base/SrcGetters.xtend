package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*

/**
 * Creates source code for one or more getters.
 */
class SrcGetters implements CodeSnippet {

	val CodeSnippetContext ctx
	val String modifiers
	val List<Variable> variables

	new(CodeSnippetContext ctx, String modifiers, List<Variable> variables) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.variables = variables
		for (Variable variable : variables) {
			ctx.requiresReference(variable.type.uniqueName)
		}
	}

	override toString() {
		'''	
			«FOR v : variables»
				«new SrcGetter(ctx, modifiers, v).toString»
				
			«ENDFOR»			
		'''
	}

}
