package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single setter.
 */
class SrcSetter implements CodeSnippet {

	val CodeSnippetContext ctx
	val String visibility
	val Variable variable

	new(CodeSnippetContext ctx, String visibility, Variable variable) {
		this.ctx = ctx
		this.visibility = visibility
		this.variable = variable
		if (variable.nullable == null) {
			ctx.requiresImport("javax.validation.constraints.NotNull")
			ctx.requiresImport("org.fuin.objects4j.common.Contract")		
		}
		if (variable.multiplicity != null) {
			ctx.requiresImport("java.util.List")
		}
		ctx.requiresReference(variable.type.uniqueName)
	}

	override toString() {
		'''	
			/**
			 * Sets: «variable.doc.text»
			 *
			 * @param «variable.name» Value to set.
			 */
			«visibility» void set«variable.name.toFirstUpper»(«IF variable.nullable == null»@NotNull «ENDIF»final «variable.
				type(ctx)» «variable.name») {
				«IF variable.nullable == null»
					Contract.requireArgNotNull("«variable.name»", «variable.name»);
				«ENDIF»
				this.«variable.name» = «variable.name»;
			}
		'''
	}

}
