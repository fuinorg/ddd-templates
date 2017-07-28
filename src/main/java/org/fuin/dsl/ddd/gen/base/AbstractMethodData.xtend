package org.fuin.dsl.ddd.gen.base

import java.util.Collections
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter

/**
 * Data required to create a method or method. 
 */
abstract class AbstractMethodData {

	String doc
	String modifiers
	String name
	List<String> annotations;
	List<Exception> exceptions

	/**
	 * Constructor without annotations.
	 * 
	 * @param ctx Documentation for the method.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param name Name of the method.
	 * @param exceptions Exceptions for the method.
	 */
	new(String doc, String modifiers, String name, List<Exception> exceptions) {
		this.doc = doc
		this.annotations = null
		this.modifiers = modifiers
		this.name = name
		this.exceptions = exceptions
	}
	
	/**
	 * Constructor with all data.
	 * 
	 * @param ctx Documentation for the method.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param name Name of the method.
	 * @param exceptions Exceptions for the method.
	 */
	new(String doc, List<String> annotations, String modifiers, String name, List<Exception> exceptions) {
		this.doc = doc
		this.annotations = annotations
		this.modifiers = modifiers
		this.name = name
		this.exceptions = exceptions
	}

	/**
	 * Returns the documentation.
	 * 
	 * @return Documentation.
	 */
	public final def getDoc() {
		doc
	}

	/**
	 * Returns a list of method annotations
	 * 
	 * @return Immutable list of annotations.
	 */
	public final def getAnnotations() {
		if (annotations === null) {
			return null
		}
		Collections.unmodifiableList(annotations)
	}

	/**
	 * Returns the modifiers.
	 * 
	 * @return Modifiers.
	 */
	public final def getModifiers() {
		modifiers
	}

	/**
	 * Returns name method.
	 * 
	 * @return Name.
	 */
	public final def getName() {
		name
	}

	/**
	 * Returns the exceptions.
	 * 
	 * @return Immutable list of exceptions.
	 */
	public final def getExceptions() {
		if (exceptions === null) {
			return null
		}
		Collections.unmodifiableList(exceptions)
	}

	/**
	 * Returns the parameters.
	 * 
	 * @return Immutable list of parameters.
	 */
	public abstract def List<Parameter> getParameters();

	
}
