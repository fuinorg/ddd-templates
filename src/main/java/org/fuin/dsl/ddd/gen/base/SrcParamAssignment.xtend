package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for assigning a parameter to an instance parameter.
 */
class SrcParamAssignment implements CodeSnippet {

	val Parameter parameter

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param parameter Parameter.
	 */
	new(CodeSnippetContext ctx, Parameter parameter) {
		this.parameter = parameter
	}

	override toString() {
		'''this.«parameter.name» = «parameter.name»;'''
	}

}
