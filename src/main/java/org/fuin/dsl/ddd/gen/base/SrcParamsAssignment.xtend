package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for assigning parameters to instance parameters.
 */
class SrcParamsAssignment implements CodeSnippet {

	val CodeSnippetContext ctx;
	val List<Parameter> vars

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param vars Parameters.
	 */
	new(CodeSnippetContext ctx, List<Parameter> vars) {
		this.ctx = ctx
		this.vars = vars
		if ((vars != null) && vars.atLeastOneVarIsNotNullable) {
			ctx.requiresImport("org.fuin.objects4j.common.Contract")		
		}
	}

	private def static boolean atLeastOneVarIsNotNullable(List<Parameter> vars) {
		for (v : vars) {
			if (v.nullable == null) {
				return true
			}
		}
		return false
	}

	override toString() {
		if ((vars == null) || (vars.size == 0)) {
			return ""
		}
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
