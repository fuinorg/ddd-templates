package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*

/**
 * Creates source code for a multiple abstract child entity locator methods.
 */
class SrcAbstractChildEntityLocatorMethods implements CodeSnippet {

	val CodeSnippetContext ctx
	val AbstractEntity entity

	new(CodeSnippetContext ctx, AbstractEntity entity) {
		this.ctx = ctx
		this.entity = entity
	}

	override toString() {
		'''
			«FOR child : entity.childEntities»
				«new SrcAbstractChildEntityLocatorMethod(ctx, child)»
				
			«ENDFOR»
		'''
	}

}
