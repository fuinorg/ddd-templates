package org.fuin.dsl.ddd.gen.extensions

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.gen.base.ConstructorParam

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Provides extension methods for AbstractVO.
 */
class AbstractVOExtensions {

	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param constructor Constructor with list of variables.
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(AbstractVO constructor) {
		return parameters(constructor, false)
	}

	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param constructor Constructor with list of variables.
	 * @param passToSuper Defines if all variables should be passed to the super call
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(AbstractVO constructor, boolean passToSuper) {
		return constructor.variables.parameters(passToSuper)
	}
	
}
