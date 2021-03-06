package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddEventExtensions.*

/**
 * Creates an abstract event handler method.
 */
class SrcAbstractHandleEventMethod implements CodeSnippet {

	val String name

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param event Event.
	 */
	new(CodeSnippetContext ctx, Event event) {
		this.name = event.name
		ctx.requiresReference(event.uniqueName)
		ctx.requiresImport("javax.validation.constraints.NotNull")
	}

	override toString() {
		'''
			/**
			 * Handles: «name».
			 *
			 * @param event Event to handle.
			 */
			protected abstract void handle(@NotNull final «name» event);
		'''
	}

}
