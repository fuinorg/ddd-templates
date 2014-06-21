package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for the JavaDoc of a constructor or method.
 */
class SrcMethodJavaDoc implements CodeSnippet {

	val CodeSnippetContext ctx
	val String doc
	val ReturnType returnType
	val List<Variable> variables
	val List<Exception> exceptions

	/**
	 * Constructor with constructor.
	 * 
	 * @param ctx Context.
	 * @param constructor Constructor.
	 */
	new(CodeSnippetContext ctx, Constructor constructor) {
		this(ctx, constructor.doc, null, constructor.variables, constructor.allExceptions)
	}

	/**
	 * Constructor with method.
	 * 
	 * @param ctx Context.
	 * @param method method.
	 */
	new(CodeSnippetContext ctx, Method method) {
		this(ctx, method.doc, null/* TODO ReturnType */, method.allVariables, method.allExceptions)
	}

	/**
	 * Constructor with constructor data.
	 * 
	 * @param ctx Context.
	 * @param method Method data.
	 */
	new(CodeSnippetContext ctx, ConstructorData constructor) {
		this(ctx, constructor.doc, null, constructor.variables, constructor.exceptions)
	}

	/**
	 * Constructor with method data.
	 * 
	 * @param ctx Context.
	 * @param method Method data.
	 */
	new(CodeSnippetContext ctx, MethodData method) {
		this(ctx, method.doc, method.returnType, method.variables, method.exceptions)
	}

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param ctx Context.
	 * @param doc Original doc.
	 * @param returnType Return type.
	 * @param variables Variables.
	 * @param exceptions Exceptions.
	 */
	new(CodeSnippetContext ctx, String doc, ReturnType returnType, List<Variable> variables, List<Exception> exceptions) {
		this.ctx = ctx
		this.doc = doc
		this.returnType = returnType
		this.variables = variables
		this.exceptions = exceptions
	}

	def sp() {
		" "
	}

	override toString() {
		if (doc == null) {
			return ""
		}
		'''
			/**
			 * «doc.text»
			 *
			«FOR v : variables.nullSafe»
				«sp»* @param «v.name» «v.superDoc»
			«ENDFOR»
			 *
			«FOR exception : exceptions.nullSafe»
				«sp»* @throws «exception.name» «exception.doc.text»
			«ENDFOR»
			«IF returnType != null»
				«sp»* @return «returnType.doc.text»
			«ENDIF»
			 */
		'''
	}

}
