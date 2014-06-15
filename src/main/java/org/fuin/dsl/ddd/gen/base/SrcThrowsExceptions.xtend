package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*

/**
 * Creates source code for "throws" clause.
 */
class SrcThrowsExceptions implements CodeSnippet {

	val CodeSnippetContext ctx
	val List<Exception> exceptions

	new(CodeSnippetContext ctx, List<Exception> exceptions) {
		this.ctx = ctx
		this.exceptions = exceptions
		if (exceptions != null) {
			for (Exception exception : exceptions) {
				ctx.requiresReference(exception.uniqueName)
			}
		}
	}

	override toString() {
		if ((exceptions == null) || (exceptions.size == 0)) {
			return ""
		}
		''' throws «FOR ex : exceptions SEPARATOR ', '»«ex.name»«ENDFOR»'''
	}

}
