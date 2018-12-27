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
	val GenerateOptions options
	val Attribute attribute

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers for the attribute.
	 * @param options Options to use.
	 * @param attribute Attribute.
	 */
	new(CodeSnippetContext ctx, String modifiers, GenerateOptions options, Attribute attribute) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.options = options
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
			«IF options.jaxb»
				«new SrcXmlAttributeOrElement(ctx, attribute, options.jaxbElements)»
			«ENDIF»
		'''
	}

	private def jsonAnnotations() {
		'''
			«IF options.jsonb»
				«new SrcJsonProperty(ctx, attribute)»
			«ENDIF»
		'''
	}

}
