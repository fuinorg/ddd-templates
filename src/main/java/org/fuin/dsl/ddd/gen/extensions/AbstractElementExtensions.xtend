package org.fuin.dsl.ddd.gen.extensions

import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static org.fuin.dsl.ddd.gen.base.Utils.*
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement

/**
 * Provides extension methods for AbstractElement.
 */
class AbstractElementExtensions {

	/**
	 * Returns the unique name of the abstract element.
	 * 
	 * @param el Element to return a unique name for.
	 * 
	 * @return Unique name in the context/namespace.
	 */
	def static String uniqueName(AbstractElement el) {
		if (el == null) {
			throw new IllegalArgumentException("argument 'el' cannot be null")
		}
		if (el.context == null) {
			throw new IllegalArgumentException("argument 'el.context' cannot be null")
		}
		if (el.namespace == null) {
			throw new IllegalArgumentException("argument 'el.namespace' cannot be null")
		}
		return separated(".", el.context.name, el.namespace.name, el.name)
	}

}
