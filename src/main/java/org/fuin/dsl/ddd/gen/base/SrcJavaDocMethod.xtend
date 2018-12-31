package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddConstructorExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddMethodExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*

/**
 * Creates source code for the JavaDoc of a constructor or method.
 */
class SrcJavaDocMethod implements CodeSnippet {

	val String doc
	val ReturnType returnType
	val List<Parameter> parameters
	val List<Exception> exceptions

	/**
	 * Constructor with constructor.
	 * 
	 * @param ctx Context.
	 * @param constructor Constructor.
	 */
	new(CodeSnippetContext ctx, Constructor constructor) {
		this(ctx, constructor.doc, null, constructor.parameters, constructor.allExceptions)
	}

	/**
	 * Constructor with method.
	 * 
	 * @param ctx Context.
	 * @param method method.
	 */
	new(CodeSnippetContext ctx, Method method) {
		this(ctx, method.doc, method.returnType, method.allParameters, method.allExceptions)
	}

	/**
	 * Constructor with constructor data.
	 * 
	 * @param ctx Context.
	 * @param method Method data.
	 */
	new(CodeSnippetContext ctx, ConstructorData constructor) {
		this(ctx, constructor.doc, null, constructor.parameters, constructor.exceptions)
	}

	/**
	 * Constructor with method data.
	 * 
	 * @param ctx Context.
	 * @param method Method data.
	 */
	new(CodeSnippetContext ctx, MethodData method) {
		this(ctx, method.doc, method.returnType, method.parameters, method.exceptions)
	}

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param ctx Context.
	 * @param doc Original doc.
	 * @param returnType Return type.
	 * @param parameters Parameters.
	 * @param exceptions Exceptions.
	 */
	new(CodeSnippetContext ctx, String doc, ReturnType returnType, List<Parameter> parameters, List<Exception> exceptions) {
		this.doc = doc
		this.returnType = returnType
		this.parameters = parameters
		this.exceptions = exceptions
	}

	def sp() {
		" "
	}

	override toString() {
		if (doc === null) {
			return ""
		}
		'''
			/**
			 * «doc.text»
			«new SrcJavaDocParams(parameters)»
			«new SrcJavaDocReturn(returnType)»
			«new SrcJavaDocExceptions(exceptions)»
			 */
		'''
	}

}
