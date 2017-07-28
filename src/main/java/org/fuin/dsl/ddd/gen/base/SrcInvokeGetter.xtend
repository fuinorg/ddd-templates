package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for calling a single getter.<br>
 * Examples: <code>getX()</code> or <code>y.getX()</code>
 */
class SrcInvokeGetter implements CodeSnippet {

	val String objName
	val Variable variable

	new(CodeSnippetContext ctx, String objName, Variable variable) {
		this.objName = objName
		this.variable = variable
	}

	override toString() {
		if (objName === null) {
			'''get«variable.name.toFirstUpper»()'''
		} else {
			'''«objName».get«variable.name.toFirstUpper»()'''
		}
	}

}
