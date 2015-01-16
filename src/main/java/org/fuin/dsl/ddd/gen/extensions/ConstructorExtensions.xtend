package org.fuin.dsl.ddd.gen.extensions

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.gen.base.ConstructorParameter

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ParameterExtensions.*

/**
 * Provides extension methods for Constructor.
 */
class ConstructorExtensions {

	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param constructor Constructor with list of variables.
	 * @param passToSuper Defines if all variables should be passed to the super call
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParameter> asWrappedParameters(Constructor constructor, boolean passToSuper) {
		return constructor.parameters.nullSafe.asWrappedParameters(passToSuper)
	}

}
