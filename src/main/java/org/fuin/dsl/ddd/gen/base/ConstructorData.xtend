package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

import static extension org.fuin.dsl.ddd.extensions.DddConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*

/**
 * Data required to create a constructor. 
 */
class ConstructorData extends AbstractMethodData {

	/**
	 * Constructor with constructor.
	 * 
	 * @param modifiers Modifiers.
	 * @param typeName Name of the type the constructor belongs to.
	 * @param constructor Constructor.
	 */
	new(String modifiers, String typeName, Constructor constructor) {
		this(modifiers , typeName, constructor, false)
	}

	/**
	 * Constructor with constructor.
	 * 
	 * @param modifiers Modifiers.
	 * @param typeName Name of the type the constructor belongs to.
	 * @param constructor Constructor.
	 * @param passToSuper Defines if all variables should be passed to the super call
	 */
	new(String modifiers, String typeName, Constructor constructor, boolean passToSuper) {
		super(constructor.doc, modifiers, typeName, constructor.parameters(passToSuper).asVariables, constructor.allExceptions)
	}
	
	/**
	 * Constructor without annotations.
	 * 
	 * @param doc Documentation.
	 * @param annotations Annotations.
	 * @param modifiers Modifiers.
	 * @param typeName Name of the type the constructor belongs to.
	 * @param parameters Parameters for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, String modifiers, String typeName, List<ConstructorParam> parameters, List<Exception> exceptions) {
		super(doc, modifiers, typeName, parameters.asVariables, exceptions)
	}

	/**
	 * Constructor with all data.
	 * 
	 * @param doc Documentation.
	 * @param annotations Annotations.
	 * @param modifiers Modifiers.
	 * @param typeName Name of the type the constructor belongs to.
	 * @param parameters Parameters for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, List<String> annotations, String modifiers, String typeName, List<ConstructorParam> parameters,
		List<Exception> exceptions) {
		super(doc, annotations, modifiers, typeName, parameters.asVariables, exceptions)
	}

	private static def List<Variable> asVariables(List<ConstructorParam> params) {

		// Dirty cast...
		((params as List<?>) as List<Variable>)
	}

	/**
	 * Returns the parameter list.
	 * 
	 * @return List of parameters. 
	 */
	def List<ConstructorParam> getParameters() {
		return (variables as List<?>) as List<ConstructorParam>
	}
	
	/**
	 * Returns all variables to pass into the super call.
	 * 
	 * @return List of variables.
	 */
	def List<Variable> getSuperCallVariables() {
		if (parameters == null) {
			return null;
		}
		val List<Variable> list = new ArrayList<Variable>()
		for (param : parameters) {
			if (param.isPassToSuper) {
				list.add(param)
			}
		}
		return list
	}
	
	/**
	 * Returns all variables to assign to an instance variable.
	 * 
	 * @return List of variables.
	 */
	def List<Variable> getAssignmentVariables() {
		if (parameters == null) {
			return null;
		}
		val List<Variable> list = new ArrayList<Variable>()
		for (param : parameters) {
			if (!param.isPassToSuper) {
				list.add(param)
			}
		}
		return list
	}
	
	/**
	 * Inserts a new parameter at the first position.
	 * 
	 * @param param Parameter to add.
	 */
	def prepend(ConstructorParam param) {
		prependVariable(param)
	}

	/**
	 * Appends a new parameter at the last position.
	 * 
	 * @param param Parameter to add.
	 */
	def append(ConstructorParam param) {
		appendVariable(param)
	}

}
