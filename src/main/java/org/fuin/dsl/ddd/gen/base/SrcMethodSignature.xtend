package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*

/**
 * Creates source code for a single method.
 */
class SrcMethodSignature implements CodeSnippet {

	val CodeSnippetContext ctx
	val String modifiers
	val boolean makeAbstract
	val Method method

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// TODO Implement!".
	 * @param method Method to create the source for.
	 */
	new(CodeSnippetContext ctx, String modifiers, boolean makeAbstract, Method method) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.makeAbstract = makeAbstract
		this.method = method
	}

	override toString() {
		'''«modifiers» «IF makeAbstract»abstract «ENDIF»void «method.name»(«new SrcParamsDecl(ctx, method.allVariables)»)«new SrcThrowsExceptions(ctx, method.allExceptions)»'''
	}

}
