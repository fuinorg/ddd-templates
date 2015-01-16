package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Creates source code for a single constructor signature.
 */
class SrcConstructorSignature implements CodeSnippet {

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
	 * @param constructorData Constructor data.
	 */
	new(CodeSnippetContext ctx, ConstructorData constructorData) {
		this.ctx = ctx
		this.constructorData = constructorData
	}

	override toString() {
		'''
		«FOR annotation : constructorData.annotations.nullSafe»
		«annotation»
		«ENDFOR»
		«constructorData.modifiers» «constructorData.name»(«new SrcParamsDecl(ctx, constructorData.parameters)»)«new SrcThrowsExceptions(
			ctx, constructorData.exceptions)»'''
	}

}
