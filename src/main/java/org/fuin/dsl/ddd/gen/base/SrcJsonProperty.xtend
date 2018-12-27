package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*

/**
 * Creates source code for a JSONB element annotation.
 */
class SrcJsonProperty implements CodeSnippet {

	val CodeSnippetContext ctx
	val Variable variable

	new(CodeSnippetContext ctx, Variable variable) {
		this.ctx = ctx
		this.variable = variable

		ctx.requiresImport("javax.json.bind.annotation.JsonbProperty")
	}

	override toString() {
		'''@JsonbProperty("«variable.name.toXmlName»")'''
	}

}
