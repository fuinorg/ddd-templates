package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for a single constructor. In the constructor the 
 * parameters will be assigned to variables with the same name.
 */
class SrcConstructorWithParamsAssignment implements CodeSnippet {

	val CodeSnippetContext ctx
	val ConstructorData constructorData

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param typeName Name of the type the constructor belongs to.
	 * @param constructor Constructor to create the source for.
	 */
	new(CodeSnippetContext ctx, String modifiers, String typeName, Constructor constructor) {
		this(ctx, new ConstructorData(modifiers, typeName, constructor))
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
	new(CodeSnippetContext ctx, ConstructorData constructorData) {
		this.ctx = ctx
		this.constructorData = constructorData
	}

	override toString() {
		'''	
			«new SrcJavaDocMethod(ctx, constructorData.doc, null, constructorData.variables, constructorData.exceptions)»
			«new SrcConstructorSignature(ctx, constructorData)» {
				«new SrcParamsSuperCall(ctx, constructorData.superCallVariables)»
				«new SrcParamsAssignment(ctx, constructorData.assignmentVariables)»
			}
		'''
	}

}
