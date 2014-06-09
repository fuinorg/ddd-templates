package org.fuin.dsl.ddd.gen.extensions

import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace

/**
 * Provides extension methods for EObject.
 */
class EObjectExtensions {

	/**
	 * Returns the namespace for an object.
	 * 
	 * @param obj Object to return the namespace for.
	 * 
	 * @return Namespace or null if the object is not inside one.
	 */
	def static Namespace getNamespace(EObject obj) {
		if (obj == null) {
			return null
		}
		if (obj instanceof Namespace) {
			return obj
		}
		return getNamespace(obj.eContainer)
	}

	/**
	 * Returns the context for an object.
	 * 
	 * @param obj Object to return the context for.
	 * 
	 * @return Context or null if the object is not inside one.
	 */
	def static Context getContext(EObject obj) {
		if (obj == null) {
			return null
		}
		if (obj instanceof Context) {
			return obj
		}
		return getContext(obj.eContainer)
	}

}
