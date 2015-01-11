package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddTypeExtensions.*

/**
 * Creates source code for a JAXB attribute annotation.
 */
class SrcXmlAttributeOrElement implements CodeSnippet {

	val CodeSnippet codeSnippet

	new(CodeSnippetContext ctx, Variable variable) {
		if ((variable.type.base != null) && (variable.type.base.element == null)) {
			codeSnippet = new SrcXmlAttribute(ctx, variable)			
		} else {
			codeSnippet = new SrcXmlElement(ctx, variable)
		}
	}

	override toString() {
		codeSnippet.toString
	}

}
