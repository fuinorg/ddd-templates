package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*

/**
 * Data required to create a constructor. 
 */
class ConstructorData {

	String doc
	String modifiers
	String typeName
	List<Variable> variables
	List<Exception> exceptions

	/**
	 * Constructor with constructor.
	 * 
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param typeName Name of the type the constructor belongs to.
	 * @param constructor Constructor.
	 */
	new(String modifiers, String typeName, Constructor constructor) {
		this(constructor.doc, modifiers, typeName, constructor.variables, constructor.allExceptions)
	}

	/**
	 * Constructor with all data.
	 * 
	 * @param ctx Documentation for the constructor.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param typeName Name of the type the constructor belongs to.
	 * @param variables Variables for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, String modifiers, String typeName, List<Variable> variables, List<Exception> exceptions) {
		this.doc = doc
		this.modifiers = modifiers
		this.typeName = typeName
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
	 * Returns the modifiers.
	 * 
	 * @return Modifiers.
	 */
	def getModifiers() {
		modifiers
	}

	/**
	 * Returns name of the type the constructor belongs to.
	 * 
	 * @return Type name.
	 */
	def getTypeName() {
		typeName
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
