package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.gen.base.ConstructorParam

/**
 * Provides extension methods for collections.
 */
class CollectionExtensions {

	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param variables List of variables.
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(List<Variable> variables) {
		return parameters(variables, false)
	}
	
	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param variables List of variables.
	 * @param passToSuper Defines if all variables should be passed to the super call
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(List<Variable> variables, boolean passToSuper) {
		if (variables == null) {
			return null
		}
		val List<ConstructorParam> list = new ArrayList<ConstructorParam>()
		for (v : variables) {
			list.add(new ConstructorParam(v, passToSuper))
		}
		return list
	}

}
