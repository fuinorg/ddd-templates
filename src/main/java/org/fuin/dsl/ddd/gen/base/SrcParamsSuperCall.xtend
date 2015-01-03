package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for passing parameters to super call.
 */
class SrcParamsSuperCall implements CodeSnippet {

	val List<Variable> variables

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param variables Variables.
	 */
	new(CodeSnippetContext ctx, List<Variable> variables) {
		this.variables = variables
	}

	override toString() {
		if (variables == null) {
			'''super();'''
		} else {
			'''super(«FOR v : variables SEPARATOR ", "»«v.name»«ENDFOR»);'''		
		}
	}

}
