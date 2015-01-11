package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single parameter declaration.
 */
class SrcParamDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val Variable variable

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param variable Variable.
	 */
	new(CodeSnippetContext ctx, Variable variable) {
		this.ctx = ctx
		this.variable = variable
		if (variable.nullable == null) {
			ctx.requiresImport("javax.validation.constraints.NotNull")
		}
		if (variable.multiplicity != null) {
			ctx.requiresImport("java.util.List")
		}
		ctx.requiresReference(variable.type.uniqueName)
	}

	override toString() {
		if ((variable.invariants != null) && (variable.invariants.calls.nullSafe.size > 0)) {
			'''«FOR cc : variable.invariants.calls SEPARATOR ' '»«new SrcValidationAnnotation(ctx, cc)»«ENDFOR» «IF variable.nullable == null»@NotNull «ENDIF»final «variable.type(ctx)» «variable.name»'''
		} else {
			'''«IF variable.nullable == null»@NotNull «ENDIF»final «variable.type(ctx)» «variable.name»'''
		}
	}

}
