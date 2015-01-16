package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.dsl.ddd.gen.base.ConstructorParameter

/**
 * Provides extension methods for Parameter.
 */
class ParameterExtensions {

	/**
	 * Creates a new constructor parameter list from the parameters.
	 * 
	 * @param parameters List of parameters.
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParameter> asWrappedParameters(List<Parameter> parameters) {
		return asWrappedParameters(parameters, false)
	}
	
	/**
	 * Creates a new constructor parameter list from the parameters.
	 * 
	 * @param parameters List of parameters.
	 * @param passToSuper Defines if all parameters should be passed to the super call
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParameter> asWrappedParameters(List<Parameter> parameters, boolean passToSuper) {
		if (parameters == null) {
			return null
		}
		val List<ConstructorParameter> list = new ArrayList<ConstructorParameter>()
		for (v : parameters) {
			list.add(new ConstructorParameter(v, passToSuper))
		}
		return list
	}

}
