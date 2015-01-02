package org.fuin.dsl.ddd.gen.base

import javax.validation.constraints.NotNull
import org.fuin.objects4j.common.Nullable

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

/**
 * Creates the source code for a JavaDoc <code>@throws</code> line.
 */
class SrcJavaDocException {

	val String name;

	val String doc;

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param name Parameter name.
	 * @param doc Text for the comment.
	 */
	new(@NotNull String name, @Nullable String doc) {
		this.name = name
		this.doc = doc.text
	}

	override toString() {
		''' * @throws «name» «doc»'''
	}

}
