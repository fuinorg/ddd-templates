package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

/**
 * Data required to create a constructor or method. 
 */
abstract class AbstractMethodData {

	String doc
	String modifiers
	String name
	List<String> annotations;
	List<Variable> variables
	List<Exception> exceptions

	/**
	 * Constructor without annotations.
	 * 
	 * @param ctx Documentation for the constructor.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param name Name of the method.
	 * @param variables Variables for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, String modifiers, String name, List<Variable> variables, List<Exception> exceptions) {
		this.doc = doc
		this.annotations = null
		this.modifiers = modifiers
		this.name = name
		this.variables = variables
		this.exceptions = exceptions
	}
	
	/**
	 * Constructor with all data.
	 * 
	 * @param ctx Documentation for the constructor.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param name Name of the method.
	 * @param variables Variables for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, List<String> annotations, String modifiers, String name, List<Variable> variables, List<Exception> exceptions) {
		this.doc = doc
		this.annotations = annotations
		this.modifiers = modifiers
		this.name = name
		this.variables = variables
		this.exceptions = exceptions
	}

	/**
	 * Returns the documentation.
	 * 
	 * @return Documentation.
	 */
	def getDoc() {
		doc
	}

	/**
	 * Returns a list of method annotations
	 * 
	 * @return Annotations.
	 */
	def getAnnotations() {
		annotations
	}

	/**
	 * Returns the modifiers.
	 * 
	 * @return Modifiers.
	 */
	def getModifiers() {
		modifiers
	}

	/**
	 * Returns name method.
	 * 
	 * @return Name.
	 */
	def getName() {
		name
	}

	/**
	 * Returns the variables.
	 * 
	 * @return Variables.
	 */
	def getVariables() {
		variables
	}

	/**
	 * Returns the exceptions.
	 * 
	 * @return Exceptions.
	 */
	def getExceptions() {
		exceptions
	}

}
