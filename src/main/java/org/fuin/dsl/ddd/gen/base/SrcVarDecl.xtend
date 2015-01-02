package org.fuin.dsl.ddd.gen.base

import java.util.List
import javax.validation.constraints.NotNull
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.InvariantsExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single variable declaration.
 */
class SrcVarDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val String visibility
	val boolean xml
	val Variable variable

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the variable.
	 * @param xml Create XML annotation.
	 * @param variable Variable.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, Variable variable) {
		this.ctx = ctx
		this.visibility = visibility
		this.xml = xml
		this.variable = variable

		if (variable.nullable == null) {
			ctx.requiresImport(NotNull.name)
		}
		if (variable.multiplicity != null) {
			ctx.requiresImport(List.name)
		}
		ctx.requiresReference(variable.type.uniqueName)
	}

	override toString() {
		'''
			«validationAnnotations»
			«xmlAnnotations»
			«new SrcMetaAnnotations(ctx, variable.overriddenMeta, null, variable.name)»
			«visibility» «variable.type(ctx)» «variable.name»;
		'''
	}

	private def validationAnnotations() {
		'''
			«FOR cc : variable.invariants.nullSafeCalls SEPARATOR ' '»
				«new SrcValidationAnnotation(ctx, cc)»
			«ENDFOR»
			«IF variable.nullable == null»
				@NotNull
			«ENDIF»
		'''
	}

	private def xmlAnnotations() {
		'''
			«IF xml»
				«new SrcXmlAttributeOrElement(ctx, variable)»
			«ENDIF»
		'''
	}

}
