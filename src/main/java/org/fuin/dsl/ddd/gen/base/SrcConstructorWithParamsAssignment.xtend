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
	val GenerateOptions options
	val ConstructorData constructorData

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param typeName Name of the type the constructor belongs to.
	 * @param constructor Constructor to create the source for.
	 */
	new(CodeSnippetContext ctx, String modifiers, String typeName, GenerateOptions options, Constructor constructor) {
		this(ctx, options, new ConstructorData(modifiers, typeName, constructor))
	}

	/**
	 * Constructor with variables and exceptions.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param constructorData Constructor.
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, ConstructorData constructorData) {
		this.ctx = ctx
		this.options = options
		this.constructorData = constructorData
	}

	override toString() {
		'''	
			«new SrcJavaDocMethod(ctx, constructorData.doc, null, constructorData.parameters, constructorData.exceptions)»
			«new SrcConstructorSignature(ctx, options, constructorData)» {
				«new SrcParamsSuperCall(ctx, constructorData.superCallParameters)»
				«new SrcParamsAssignment(ctx, constructorData.assignmentParameters)»
			}
		'''
	}

}
