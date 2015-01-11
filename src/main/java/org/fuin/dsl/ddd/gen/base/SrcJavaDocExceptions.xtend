package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.objects4j.common.Nullable

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Creates the source code for a JavaDoc <code>@throws</code> lines.
 */
class SrcJavaDocExceptions {

	val List<Exception> exceptions

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param exceptions List of exceptions.
	 */
	new(@Nullable List<Exception> exceptions) {
		this.exceptions = exceptions
	}

	override toString() {
		if (exceptions.nullSafe.size == 0) {
			''''''
		} else {
			'''
				«sp»*
				«FOR ex : exceptions»
					«new SrcJavaDocException(ex.name, ex.doc)»
				«ENDFOR»
			'''
		}
	}

	def sp() {
		" "
	}

}
