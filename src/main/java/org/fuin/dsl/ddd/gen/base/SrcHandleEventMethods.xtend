package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates multiple event handler methods.
 */
class SrcHandleEventMethods implements CodeSnippet {

	val CodeSnippetContext ctx
	val List<Event> events

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param event Event.
	 */
	new(CodeSnippetContext ctx, List<Event> events) {
		this.ctx = ctx
		this.events = events
	}

	override toString() {
		'''
			«FOR event : events»
				«new SrcHandleEventMethod(ctx, event)»
				
			«ENDFOR»
		'''
	}

}
