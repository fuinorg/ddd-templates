package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for a JAXB attribute annotation.
 */
class SrcXmlAttributeOrElement implements CodeSnippet {

	val CodeSnippet codeSnippet

	new(CodeSnippetContext ctx, Variable variable) {
		if (variable.type instanceof ValueObject) {
			val ValueObject vo = (variable.type as ValueObject);
			if (vo.base != null) {
				codeSnippet = new SrcXmlAttribute(ctx, variable)
				return
			}
		} else if (variable.type instanceof AbstractEntityId) {
			val AbstractEntityId id = (variable.type as AbstractEntityId);
			if (id.base != null) {
				codeSnippet = new SrcXmlAttribute(ctx, variable)
				return
			}
		}
		codeSnippet = new SrcXmlElement(ctx, variable)
	}

	override toString() {
		codeSnippet.toString
	}

}
