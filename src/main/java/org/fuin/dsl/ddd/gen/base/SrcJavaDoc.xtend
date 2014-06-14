package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.srcgen4j.core.emf.CodeSnippet

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

/**
 * Creates the JavaDoc source code.
 */
class SrcJavaDoc implements CodeSnippet {

	val String text

	new(InternalType internalType) {
		this.text = internalType.doc.text
	}

	override toString() {
		'''
			/**
			 * «text»
			 */
		'''
	}

}
