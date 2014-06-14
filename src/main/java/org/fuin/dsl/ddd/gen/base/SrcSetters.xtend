package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for one or more setters.
 */
class SrcSetters implements CodeSnippet {

	val CodeSnippetContext ctx
	val String visibility
	val List<Variable> variables

	new(CodeSnippetContext ctx, String visibility, List<Variable> variables) {
		this.ctx = ctx
		this.visibility = visibility
		this.variables = variables
	}

	override toString() {
		'''	
			«FOR variable : variables»
				«new SrcSetter(ctx, visibility, variable)»
				
			«ENDFOR»
		'''
	}

}
