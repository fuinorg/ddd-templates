package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*

/**
 * Creates source code for a single constructor. In the constructor the 
 * parameters will be assigned to variables with the same name.
 */
class SrcConstructorWithParamsAssignment implements CodeSnippet {

	val CodeSnippetContext ctx
	val String doc
	val String modifiers
	val String typeName
	val List<Variable> variables
	val List<Exception> exceptions

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param typeName Name of the type the constructor belongs to.
	 * @param constructor Constructor to create the source for.
	 */
	new(CodeSnippetContext ctx, String modifiers, String typeName, Constructor constructor) {
		this(ctx, constructor.doc, modifiers, typeName, constructor.variables, constructor.allExceptions)
	}

	/**
	 * Constructor with variables and exceptions.
	 * 
	 * @param ctx Context.
	 * @param ctx Documentation for the constructor.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param typeName Name of the type the constructor belongs to.
	 * @param variables Variables for the constructor.
	 * @param exceptions Exceptions for the constructor.
	 */
	new(CodeSnippetContext ctx, String doc, String modifiers, String typeName, List<Variable> variables,
		List<Exception> exceptions) {
		this.ctx = ctx
		this.doc = doc
		this.modifiers = modifiers
		this.typeName = typeName
		this.variables = variables
		this.exceptions = exceptions
	}

	override toString() {
		'''	
			«new SrcMethodJavaDoc(ctx, doc, variables, exceptions)»
			«new SrcConstructorSignature(ctx, modifiers, typeName, variables, exceptions)» {
				super();
				«new SrcParamsAssignment(ctx, variables)»
			}
		'''
	}

}
