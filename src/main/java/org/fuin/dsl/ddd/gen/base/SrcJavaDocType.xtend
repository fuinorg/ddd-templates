package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.srcgen4j.core.emf.CodeSnippet

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

/**
 * Creates the source code for a type (class, interface) JavaDoc.
 */
class SrcJavaDocType implements CodeSnippet {

	val String text

	/**
	 * Constructor with doc.
	 * 
	 * @param doc Doc including comment characters.
	 */
	new(String doc) {
		this.text = doc.text
	}

	/**
	 * Constructor with constructor.
	 * 
	 * @param method Constructor with doc.
	 */
	new(Constructor constructor) {
		this(constructor.doc)
	}

	/**
	 * Constructor with method.
	 * 
	 * @param method Method with doc.
	 */
	new(Method method) {
		this(method.doc)
	}

	/**
	 * Constructor with internal type.
	 * 
	 * @param internalType Type with doc.
	 */
	new(InternalType internalType) {
		this(internalType.doc)
	}

	/**
	 * Constructor with event.
	 * 
	 * @param event Event with doc.
	 */
	new(Event event) {
		this(event.doc)
	}

	override toString() {
		'''
			/**
			 * «text»
			 */
		'''
	}

}
