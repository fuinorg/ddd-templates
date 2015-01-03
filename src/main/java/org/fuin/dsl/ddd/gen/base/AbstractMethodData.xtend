package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import java.util.Collections
import java.util.ArrayList

/**
 * Data required to create a method or method. 
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
	 * @param ctx Documentation for the method.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param name Name of the method.
	 * @param variables Variables for the method.
	 * @param exceptions Exceptions for the method.
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
	 * @param ctx Documentation for the method.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param name Name of the method.
	 * @param variables Variables for the method.
	 * @param exceptions Exceptions for the method.
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
	 * @return Immutable list of annotations.
	 */
	def getAnnotations() {
		if (annotations == null) {
			return null
		}
		Collections.unmodifiableList(annotations)
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
	 * @return Immutable list of variables.
	 */
	def getVariables() {
		if (variables == null) {
			return null
		}
		Collections.unmodifiableList(variables)
	}

	/**
	 * Returns the exceptions.
	 * 
	 * @return Immutable list of exceptions.
	 */
	def getExceptions() {
		if (exceptions == null) {
			return null
		}
		Collections.unmodifiableList(exceptions)
	}

	/**
	 * Inserts a new variable at the first position.
	 * 
	 * @param variable Variable to add.
	 */
	protected def prependVariable(Variable variable) {
		if (variables == null) {
			variables = new ArrayList<Variable>()
		}
		variables.add(0, variable)
	}

	/**
	 * Appends a new variable at the last position.
	 * 
	 * @param variable Variable to add.
	 */
	protected def appendVariable(Variable variable) {
		if (variables == null) {
			variables = new ArrayList<Variable>()
		}
		variables.add(variable)
	}
	
}
