package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*

/**
 * Creates source code for one or more getters.
 */
class SrcGetters implements CodeSnippet {

	val CodeSnippetContext ctx
	val String modifiers
	val List<Attribute> attributes

	new(CodeSnippetContext ctx, String modifiers, List<Attribute> attributes) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.attributes = attributes
		for (Attribute attribute : attributes) {
			ctx.requiresReference(attribute.type.uniqueName)
		}
	}

	override toString() {
		'''	
			«FOR v : attributes»
				«new SrcGetter(ctx, modifiers, v).toString»
				
			«ENDFOR»			
		'''
	}

}
