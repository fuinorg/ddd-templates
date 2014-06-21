package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*

/**
 * Data required to create a method. 
 */
class MethodData extends AbstractMethodData {

	val boolean makeAbstract

	/**
	 * Method with method.
	 * 
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract Abstract method?
	 * @param method Method.
	 */
	new(String modifiers, boolean makeAbstract, Method method) {
		super(method.doc, modifiers, method.name, method.allVariables, method.allExceptions)
		this.makeAbstract = makeAbstract
	}

	/**
	 * Method without annotations.
	 * 
	 * @param doc Documentation.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract Abstract method?
	 * @param methodName Name of the method.
	 * @param variables Variables for the method.
	 * @param exceptions Exceptions for the method.
	 */
	new(String doc, String modifiers, boolean makeAbstract, String methodName, List<Variable> variables, List<Exception> exceptions) {
		super(doc, null, modifiers, methodName, variables, exceptions)
		this.makeAbstract = makeAbstract
	}

	/**
	 * Method with all data.
	 * 
	 * @param doc Documentation.
	 * @param annotations Annotations.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract Abstract method?
	 * @param methodName Name of the method.
	 * @param variables Variables for the method.
	 * @param exceptions Exceptions for the method.
	 */
	new(String doc, List<String> annotations, String modifiers, boolean makeAbstract, String methodName, List<Variable> variables, List<Exception> exceptions) {
		super(doc, annotations, modifiers, methodName, variables, exceptions)
		this.makeAbstract = makeAbstract
	}
	
	/**
	 * Returns if the method is abstract.
	 * 
	 * @return TRUE if the method is abstract.
	 */
	def isMakeAbstract() {
		makeAbstract
	}

}
