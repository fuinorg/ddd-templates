package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.Collections
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter

import static extension org.fuin.dsl.ddd.extensions.DddConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*

/**
 * Data required to create a constructor. 
 */
class ConstructorData extends AbstractMethodData {

	val List<ConstructorParameter> parameters

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
	 * @param passToSuper Defines if all parameters should be passed to the super call
	 */
	new(String modifiers, String typeName, Constructor constructor, boolean passToSuper) {
		super(constructor.doc, modifiers, typeName, constructor.allExceptions)
		this.parameters = new ArrayList<ConstructorParameter>()
		if (constructor.parameters != null) {
			this.parameters.addAll(constructor.asWrappedParameters(passToSuper))		
		}
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
	new(String doc, String modifiers, String typeName, List<ConstructorParameter> parameters, List<Exception> exceptions) {
		super(doc, modifiers, typeName, exceptions)
		this.parameters = new ArrayList<ConstructorParameter>()
		if (parameters != null) {
			this.parameters.addAll(parameters)		
		}
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
	new(String doc, List<String> annotations, String modifiers, String typeName, List<ConstructorParameter> parameters,
		List<Exception> exceptions) {
		super(doc, annotations, modifiers, typeName, exceptions)
		this.parameters = new ArrayList<ConstructorParameter>()
		if (parameters != null) {
			this.parameters.addAll(parameters)
		}
	}

	/**
	 * Returns all parameters to pass into the super call.
	 * 
	 * @return List of parameters.
	 */
	def List<Parameter> getSuperCallParameters() {
		if (parameters == null) {
			return null;
		}
		val List<Parameter> list = new ArrayList<Parameter>()
		for (param : parameters) {
			if (param.isPassToSuper) {
				list.add(param.delegate)
			}
		}
		return list
	}
	
	/**
	 * Returns all parameters to assign to an instance parameter.
	 * 
	 * @return List of parameters.
	 */
	def List<Parameter> getAssignmentParameters() {
		if (parameters == null) {
			return null;
		}
		val List<Parameter> list = new ArrayList<Parameter>()
		for (param : parameters) {
			if (!param.isPassToSuper) {
				list.add(param.delegate)
			}
		}
		return list
	}
	
	/**
	 * Inserts a new parameter at the first position.
	 * 
	 * @param parameter Parameter to add.
	 */
	public final def prepend(ConstructorParameter parameter) {
		parameters.add(0, parameter)
	}

	/**
	 * Appends a new parameter at the last position.
	 * 
	 * @param parameter Parameter to add.
	 */
	public final def append(ConstructorParameter parameter) {
		parameters.add(parameter)
	}

	
	override def List<Parameter> getParameters() {
		return Collections.unmodifiableList(parameters.asParameters)
	}

	/**
	 * Creates a new parameter list from the wrapped parameters.
	 * 
	 * @param parameters List of wrapped parameters.
	 * 
	 * @return Parameter list
	 */
	private def static List<Parameter> asParameters(List<ConstructorParameter> parameters) {
		if (parameters == null) {
			return null
		}
		val List<Parameter> list = new ArrayList<Parameter>()
		for (v : parameters) {
			list.add(v.delegate)
		}
		return list
	}
	
}
