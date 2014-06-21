package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

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
		super(constructor.doc, modifiers, typeName, constructor.variables, constructor.allExceptions)
	}

	/**
	 * Constructor without annotations.
	 * 
	 * @param doc Documentation.
	 * @param annotations Annotations.
	 * @param modifiers Modifiers.
	 * @param typeName Name of the type the constructor belongs to.
	 * @param variables Variables for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, String modifiers, String typeName, List<Variable> variables,
		List<Exception> exceptions) {
		super(doc, modifiers, typeName, variables, exceptions)
	}
	
	/**
	 * Constructor with all data.
	 * 
	 * @param doc Documentation.
	 * @param annotations Annotations.
	 * @param modifiers Modifiers.
	 * @param typeName Name of the type the constructor belongs to.
	 * @param variables Variables for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(String doc, List<String> annotations, String modifiers, String typeName, List<Variable> variables,
		List<Exception> exceptions) {
		super(doc, annotations, modifiers, typeName, variables, exceptions)
	}

}
