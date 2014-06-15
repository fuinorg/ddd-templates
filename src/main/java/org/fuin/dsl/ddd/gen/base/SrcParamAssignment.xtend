package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for assigning a parameter to an instance variable.
 */
class SrcParamAssignment implements CodeSnippet {

	val Variable variable

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param variable Variable.
	 */
	new(CodeSnippetContext ctx, Variable variable) {
		this.variable = variable
	}

	override toString() {
		'''this.«variable.name» = «variable.name»;'''
	}

}
