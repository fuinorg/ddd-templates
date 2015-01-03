package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*

/**
 * Data required to create a method. 
 */
class MethodData extends AbstractMethodData {

	val boolean makeAbstract

	val ReturnType returnType

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
		this.returnType = method.returnType 
	}

	/**
	 * Method without annotations.
	 * 
	 * @param doc Documentation.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract Abstract method?
	 * @param returnType Return type.
	 * @param methodName Name of the method.
	 * @param variables Variables for the method.
	 * @param exceptions Exceptions for the method.
	 */
	new(String doc, String modifiers, boolean makeAbstract, ReturnType returnType, String methodName, List<Variable> variables, List<Exception> exceptions) {
		super(doc, null, modifiers, methodName, variables, exceptions)
		this.makeAbstract = makeAbstract
		this.returnType = returnType
	}

	/**
	 * Method with all data.
	 * 
	 * @param doc Documentation.
	 * @param annotations Annotations.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract Abstract method?
	 * @param returnType Return type.
	 * @param methodName Name of the method.
	 * @param variables Variables for the method.
	 * @param exceptions Exceptions for the method.
	 */
	new(String doc, List<String> annotations, String modifiers, boolean makeAbstract, ReturnType returnType, String methodName, List<Variable> variables, List<Exception> exceptions) {
		super(doc, annotations, modifiers, methodName, variables, exceptions)
		this.makeAbstract = makeAbstract
		this.returnType = returnType
	}
	
	/**
	 * Returns if the method is abstract.
	 * 
	 * @return TRUE if the method is abstract.
	 */
	def isMakeAbstract() {
		makeAbstract
	}

	/**
	 * Returns the result type of a method.
	 * 
	 * @return Type returned by a method.
	 */
	def getReturnType() {
		returnType
	}

	/**
	 * Inserts a new variable at the first position.
	 * 
	 * @param variable Variable to add.
	 */
	def prepend(Variable variable) {
		prependVariable(variable)
	}
	
	/**
	 * Appends a new variable at the last position.
	 * 
	 * @param variable Variable to add.
	 */
	def append(Variable variable) {
		appendVariable(variable)
	}

}
