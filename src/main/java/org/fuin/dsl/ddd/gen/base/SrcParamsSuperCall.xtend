package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for passing parameters to super call.
 */
class SrcParamsSuperCall implements CodeSnippet {

	val List<Parameter> parameters

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param parameters Parameters.
	 */
	new(CodeSnippetContext ctx, List<Parameter> parameters) {
		this.parameters = parameters
	}

	override toString() {
		if (parameters === null) {
			'''super();'''
		} else {
			'''super(«FOR v : parameters SEPARATOR ", "»«v.name»«ENDFOR»);'''		
		}
	}

}
