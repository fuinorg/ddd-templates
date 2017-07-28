package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for zero or more parameter declarations.
 */
class SrcParamsDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val List<Parameter> parameters

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param parameters Parameters.
	 */
	new(CodeSnippetContext ctx, List<Parameter> parameters) {
		this.ctx = ctx
		this.parameters = parameters
	}

	override toString() {
		if (parameters === null || parameters.size == 0) {
			return "";
		}
		'''«FOR parameter : parameters SEPARATOR ', '»«new SrcParamDecl(ctx, parameter)»«ENDFOR»'''
	}

}
