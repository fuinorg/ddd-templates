package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*

/**
 * Provides extension methods for Event.
 */
class EventExtensions {
	
	/**
	 * Returns the unique name of the event.
	 * 
	 * @param el Event to return a unique name for.
	 * 
	 * @return Unique name in the context/namespace.
	 */
	def static String uniqueName(Event event) {
		if (event == null) {
			throw new IllegalArgumentException("argument 'event' cannot be null")
		}
		if (event.context == null) {
			throw new IllegalArgumentException("argument 'event.context' cannot be null")
		}
		if (event.namespace == null) {
			throw new IllegalArgumentException("argument 'event.namespace' cannot be null")
		}
		return separated(".", event.context.name, event.namespace.name, event.name)
	}

}
