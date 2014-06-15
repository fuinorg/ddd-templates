package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for zero or more parameter declarations.
 */
class SrcParamsDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val List<Variable> variables

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param variables Variables.
	 */
	new(CodeSnippetContext ctx, List<Variable> variables) {
		this.ctx = ctx
		this.variables = variables
	}

	override toString() {
		if (variables == null || variables.size == 0) {
			return "";
		}
		'''«FOR variable : variables SEPARATOR ', '»«new SrcParamDecl(ctx, variable)»«ENDFOR»'''
	}

}
