package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Creates source code for a single method.
 */
class SrcMethodSignature implements CodeSnippet {

	val CodeSnippetContext ctx
	val MethodData methodData
	val String returnType

	/**
	 * Constructor with method.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// TODO Implement!".
	 * @param method Method to create the source for.
	 */
	new(CodeSnippetContext ctx, String modifiers, boolean makeAbstract, Method method) {
		this(ctx, new MethodData(modifiers, makeAbstract, method));
	}

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param methodData data.
	 */
	new(CodeSnippetContext ctx, MethodData methodData) {
		this.ctx = ctx
		this.methodData = methodData
		if (methodData.returnType === null) {
			this.returnType = "void"
		} else {
			this.returnType = methodData.returnType.type.name
			ctx.requiresReference(methodData.returnType.type.uniqueName)		
		}	
	}

	override toString() {
		'''
			«FOR annotation : methodData.annotations.nullSafe»
				«annotation»
			«ENDFOR»
			«methodData.modifiers» «IF methodData.makeAbstract»abstract «ENDIF»«returnType» «methodData.name»(«new SrcParamsDecl(ctx,
				methodData.parameters)»)«new SrcThrowsExceptions(ctx, methodData.exceptions)»'''
	}

}
