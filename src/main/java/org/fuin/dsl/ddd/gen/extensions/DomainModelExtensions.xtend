package org.fuin.dsl.ddd.gen.extensions;

import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.utils4j.InvokeMethodFailedException
import org.fuin.utils4j.Utils4J

class DomainModelExtensions {

	/**
     * Returns an abstract element of a given type by it's name. The object 
     * must have a public instance method <code>String getName()</code>.
     *  
     * Throws an exception if the element is not found.
     * 
     * @param model Domain model.
     * @param type Type to find.
     * @param name Name that is unique within the type.
     * 
     * @return Element.
     */
	def static <T extends EObject> T find(DomainModel model, Class<T> type, String name) {
		val iter = model.eAllContents.filter(type)
		while (iter.hasNext) {
			val T el = iter.next
			if (name.equals(el.name)) {
				return el
			}
		}
		throw new IllegalArgumentException("No element of type '" + type.simpleName + "' found with name '" + name + "'")
	}

	private def static String getName(Object obj) {
		try {
			val result = Utils4J.invoke(obj, "getName", null, null)
			if (result instanceof String) {
				return result as String
			}
			return null
		} catch (InvokeMethodFailedException ex) {
			return null;
		}
	}

}
