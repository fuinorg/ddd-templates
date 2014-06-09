package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import org.fuin.srcgen4j.core.emf.CodeSnippet

/**
 * Creates source code for a single getter.
 */
class SrcGetter implements CodeSnippet {

	val CodeSnippetContext ctx
	val String visibility
	val Variable variable

	new(CodeSnippetContext ctx, String visibility, Variable variable) {
		this.ctx = ctx
		this.visibility = visibility
		this.variable = variable
		
		if (variable.nullable == null) {
			ctx.requiresImport("org.fuin.objects4j.common.NeverNull")		
		}
		if (variable.multiplicity != null) {
			ctx.requiresImport("java.util.List")
		}
		
		ctx.requiresReference(variable.type.uniqueName)
	}

	override toString() {
		'''	
			/**
			 * Returns: «variable.superDoc.text»
			 *
			 * @return Current value.
			 */
			 «IF variable.nullable == null»@NeverNull«ENDIF»
			«visibility» «variable.type(ctx)» get«variable.name.toFirstUpper»() {
				return «variable.name»;
			}
		'''
	}

}
