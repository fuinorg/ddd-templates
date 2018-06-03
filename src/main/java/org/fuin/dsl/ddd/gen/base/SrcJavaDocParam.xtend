package org.fuin.dsl.ddd.gen.base

import javax.validation.constraints.NotNull
import javax.annotation.Nullable

/**
 * Creates the source code for a JavaDoc <code>@param</code> line.
 */
class SrcJavaDocParam {

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
		this.doc = doc
	}

	override toString() {
		''' * @param «name» «doc»'''
	}

}
