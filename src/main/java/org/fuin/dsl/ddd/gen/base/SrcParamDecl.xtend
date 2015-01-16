package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddPreconditionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single parameter declaration.
 */
class SrcParamDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val Parameter parameter

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param parameter Parameter.
	 */
	new(CodeSnippetContext ctx, Parameter parameter) {
		this.ctx = ctx
		this.parameter = parameter
		if (parameter.nullable == null) {
			ctx.requiresImport("javax.validation.constraints.NotNull")
		}
		if (parameter.multiplicity != null) {
			ctx.requiresImport("java.util.List")
		}
		ctx.requiresReference(parameter.type.uniqueName)
	}

	override toString() {
		if (parameter.preconditions.nullSafe.size > 0) {
			'''«FOR cc : parameter.preconditions.nullSafe SEPARATOR ' '»«new SrcValidationAnnotation(ctx, cc)»«ENDFOR» «IF parameter.nullable == null»@NotNull «ENDIF»final «parameter.type(ctx)» «parameter.name»'''
		} else {
			'''«IF parameter.nullable == null»@NotNull «ENDIF»final «parameter.type(ctx)» «parameter.name»'''
		}
	}

}
