package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for assigning parameters to instance variables.
 */
class SrcParamsAssignment implements CodeSnippet {

	val CodeSnippetContext ctx;
	val List<Variable> vars

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param vars Variables.
	 */
	new(CodeSnippetContext ctx, List<Variable> vars) {
		this.ctx = ctx
		this.vars = vars
		ctx.requiresImport("org.fuin.objects4j.common.Contract")
	}

	override toString() {
		'''	
			«FOR v : vars»	
				«IF v.nullable == null»
					Contract.requireArgNotNull("«v.name»", «v.name»);
				«ENDIF»
			«ENDFOR»
			
			«FOR v : vars»	
				«new SrcParamAssignment(ctx, v)»
			«ENDFOR»
		'''
	}

}
