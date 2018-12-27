package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddMethodExtensions.*

/**
 * Creates source code for a single method.
 */
class SrcMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val GenerateOptions options
	val MethodData method

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// ToDo Implement!".
	 * @param options Options to use.
	 * @param method Method to create the source for.
	 */
	new(CodeSnippetContext ctx, List<String> annotations, String modifiers, boolean makeAbstract, GenerateOptions options, Method method) {
		this(ctx, options,
			new MethodData(method.doc, annotations, modifiers, makeAbstract, method.returnType,
				method.name, method.parameters, method.allExceptions))
	}

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
	 * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// ToDo Implement!".
	 * @param options Options to use.
	 * @param method Method to create the source for.
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, MethodData method) {
		this.ctx = ctx
		this.options = options
		this.method = method
	}

	override toString() {
		if (method.makeAbstract) {
			'''	
				«new SrcJavaDocMethod(ctx, method)»
				«new SrcMethodSignature(ctx, options, method)»;
			'''
		} else {
			'''	
				«new SrcJavaDocMethod(ctx, method)»
				«new SrcMethodSignature(ctx, options, method)» {
					// TODO Implement!
					«IF method.returnType !== null»return null;«ENDIF»
				}
			'''
		}
	}

}
