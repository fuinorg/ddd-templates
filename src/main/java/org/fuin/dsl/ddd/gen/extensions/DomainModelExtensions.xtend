package org.fuin.dsl.ddd.gen.extensions;

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel

class DomainModelExtensions {

	/**
     * Returns an abstract element of a given type by it's name. 
     * Throws an exception if the element is not found.
     * 
     * @param model Domain model.
     * @param type Type to find.
     * @param name Name that is unique within the type.
     * 
     * @return Element.
     */
	def static <T extends AbstractElement> T find(DomainModel model, Class<T> type, String name) {
		val iter = model.eAllContents.filter(type)
		while (iter.hasNext) {
			val T el = iter.next
			if (name.equals(el.name)) {
				return el
			}
		}
		throw new IllegalArgumentException("No abstract element of type '" + type.simpleName + "' found with name '" + name + "'")
	}

}
