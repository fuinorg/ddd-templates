package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.EventExtensions.*

/**
 * Creates an event handler method.
 */
class SrcHandleEventMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val String name

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param event Event.
	 */
	new(CodeSnippetContext ctx, Event event) {
		this.ctx = ctx
		this.name = event.name
		ctx.requiresReference(event.uniqueName)
		ctx.requiresImport("javax.validation.constraints.NotNull")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EventHandler")
	}

	override toString() {
		'''
			/**
			 * Handles: «name».
			 *
			 * @param event Event to handle.
			 */
			@Override
			@EventHandler
			protected final void handle(@NotNull final «name» event) {
				// TODO Handle event!
			}
		'''
	}

}
