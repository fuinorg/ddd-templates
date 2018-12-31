package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single getter.
 */
class SrcGetter implements CodeSnippet {

	val CodeSnippetContext ctx
	val String modifiers
	val Variable variable

	new(CodeSnippetContext ctx, GenerateOptions options, String modifiers, Variable variable) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.variable = variable
		
		if (variable.nullable === null) {
			ctx.requiresImport("javax.validation.constraints.NotNull")		
		} else {
			ctx.requiresImport("javax.annotation.Nullable")		
		}
		addRequiredReferences(variable, ctx)
	}

	override toString() {
		'''	
			/**
			 * Returns: «variable.superDoc.text»
			 *
			 * @return Current value.
			 */
			«IF variable.nullable === null»@NotNull«ELSE»@Nullable«ENDIF»
			«modifiers» «variable.type(ctx)» get«variable.name.toFirstUpper»() {
				return «variable.name»;
			}
		'''
	}

}
