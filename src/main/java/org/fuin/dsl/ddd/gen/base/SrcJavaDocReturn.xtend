package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType
import org.fuin.objects4j.common.Nullable

import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*

/**
 * Creates the source code for a JavaDoc <code>@return</code> line.
 */
class SrcJavaDocReturn {

	val String doc;

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param doc Text for the comment.
	 */
	new(@Nullable String doc) {
		if (doc == null) {
			this.doc = null
		} else {
			this.doc = doc.text
		}
	}

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param doc Text for the comment.
	 */
	new(@Nullable ReturnType returnType) {
		if (returnType == null) {
			this.doc = null
		} else {
			this.doc = returnType.doc.text		
		}
	}

	override toString() {
		if (doc == null) {
			''''''
		} else {
			'''
				«sp»*
				«sp»* @return «doc»
			'''		
		}
	}

	def sp() {
		" "
	}

}
