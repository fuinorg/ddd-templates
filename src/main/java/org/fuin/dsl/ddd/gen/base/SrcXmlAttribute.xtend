package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

/**
 * Creates source code for a JAXB attribute annotation.
 */
class SrcXmlAttribute implements CodeSnippet {

	val CodeSnippetContext ctx
	val Variable variable

	new(CodeSnippetContext ctx, Variable variable) {
		this.ctx = ctx
		this.variable = variable

		ctx.requiresImport("javax.xml.bind.annotation.XmlAttribute")
	}

	override toString() {
		'''@XmlAttribute(name = "«variable.name.toXmlName»")'''
	}

}
