package org.fuin.dsl.ddd.gen.base

import javax.validation.constraints.NotNull
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddInvariantsExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import javax.annotation.Nullable

/**
 * Creates source code for a single attribute declaration.
 */
class SrcVarDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val String modifiers
	val boolean xml
	val boolean xmlElements
	val boolean json
	val Attribute attribute

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers for the attribute.
	 * @param xml Create XML annotation.
	 * @param xmlElements Create always XML elements instead of attributes.
	 * @param json Create JSON annotation.
	 * @param attribute Attribute.
	 */
	new(CodeSnippetContext ctx, String modifiers, boolean xml, boolean xmlElements, boolean json, Attribute attribute) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.xml = xml
		this.xmlElements = xmlElements
		this.json = json
		this.attribute = attribute

		if (attribute.nullable === null) {
			ctx.requiresImport(NotNull.name)
		} else {
			ctx.requiresImport(Nullable.name)
		}
		addRequiredReferences(attribute, ctx)
	}

	override toString() {
		'''
			«validationAnnotations»
			«xmlAnnotations»
			«jsonAnnotations»
			«new SrcMetaAnnotations(ctx, attribute.overriddenMeta, null, attribute.name)»
			«modifiers» «attribute.type(ctx)» «attribute.name»;
		'''
	}

	private def validationAnnotations() {
		'''
			«FOR cc : attribute.invariants.nullSafe SEPARATOR ' '»
				«new SrcValidationAnnotation(ctx, cc)»
			«ENDFOR»
			«IF attribute.nullable === null»
				@NotNull
			«ELSE»
				@Nullable
			«ENDIF»
		'''
	}

	private def xmlAnnotations() {
		'''
			«IF xml»
				«new SrcXmlAttributeOrElement(ctx, attribute, xmlElements)»
			«ENDIF»
		'''
	}

	private def jsonAnnotations() {
		'''
			«IF json»
				«new SrcJsonProperty(ctx, attribute)»
			«ENDIF»
		'''
	}

}
