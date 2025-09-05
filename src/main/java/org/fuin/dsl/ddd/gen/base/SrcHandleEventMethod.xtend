package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.cqrs.cqrsDsl.Event
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsEventExtensions.*

/**
 * Creates an event handler method.
 */
class SrcHandleEventMethod implements CodeSnippet {

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
        ctx.requiresImport("jakarta.validation.constraints.NotNull")
        ctx.requiresImport("org.fuin.ddd4j.core.ApplyEvent")
    }

    override toString() {
        '''
            /**
             * Handles: «name».
             *
             * @param event Event to handle.
             */
            @Override
            @ApplyEvent
            protected final void handle(@NotNull final «name» event) {
                // TODO Handle event!
            }
        '''
    }

}
