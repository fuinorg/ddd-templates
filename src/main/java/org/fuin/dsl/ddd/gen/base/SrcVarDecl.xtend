package org.fuin.dsl.ddd.gen.base

import java.util.List
import javax.validation.constraints.NotNull
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddInvariantsExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for a single attribute declaration.
 */
class SrcVarDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val String modifiers
	val boolean xml
	val Attribute attribute

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers for the attribute.
	 * @param xml Create XML annotation.
	 * @param attribute Attribute.
	 */
	new(CodeSnippetContext ctx, String modifiers, boolean xml, Attribute attribute) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.xml = xml
		this.attribute = attribute

		if (attribute.nullable == null) {
			ctx.requiresImport(NotNull.name)
		}
		if (attribute.multiplicity != null) {
			ctx.requiresImport(List.name)
		}
		ctx.requiresReference(attribute.type.uniqueName)
	}

	override toString() {
		'''
			«validationAnnotations»
			«xmlAnnotations»
			«new SrcMetaAnnotations(ctx, attribute.overriddenMeta, null, attribute.name)»
			«modifiers» «attribute.type(ctx)» «attribute.name»;
		'''
	}

	private def validationAnnotations() {
		'''
			«FOR cc : attribute.invariants.nullSafe SEPARATOR ' '»
				«new SrcValidationAnnotation(ctx, cc)»
			«ENDFOR»
			«IF attribute.nullable == null»
				@NotNull
			«ENDIF»
		'''
	}

	private def xmlAnnotations() {
		'''
			«IF xml»
				«new SrcXmlAttributeOrElement(ctx, attribute)»
			«ENDIF»
		'''
	}

}
