package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Creates source code for invoking a constructor or a method.
 */
class SrcInvokeMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val String method
	val List<String> names

	/**
	 * Constructor with names.
	 * 
	 * @param ctx Context.
	 * @param method Name of the method to call.
	 * @param names List of names to use to invoke the super constructor.
	 */
	new(CodeSnippetContext ctx, String method, List<String> names) {
		this.ctx = ctx
		this.method = method
		this.names = names;
	}
	
	/**
	 * Constructor with names.
	 * 
	 * @param ctx Context.
	 * @param method Name of the method to call.
	 * @param names Names to use to invoke the super constructor.
	 */
	new(CodeSnippetContext ctx, String method, String...names) {
		this.ctx = ctx
		this.method = method
		this.names = new ArrayList()
		if (names !== null) {
			this.names.addAll(names)		
		}
	}

	override toString() {
		if (names.nullSafe.size == 0) {
			return '''«method»();''';
		} else {
			return '''«method»(«FOR name : names SEPARATOR ', '»«name»«ENDFOR»);''';
		}
	}

}
