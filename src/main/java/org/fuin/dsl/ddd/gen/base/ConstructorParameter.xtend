package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter

/**
 * Wraps a parameter to add additional data.
 */
class ConstructorParameter {

	val Parameter parameter

	val boolean passToSuper

	/**
	 * Parameter only with delegate. The parameter will not be passed to the super constructor.
	 * 
	 * @param parameter Delegate - Cannot be <code>null</code>.
	 */
	new(Parameter parameter) {
		this(parameter, false)
	}

	/**
	 * Parameter only with all data.
	 * 
	 * @param parameter Delegate - Cannot be <code>null</code>.
	 * @param passToSuper Defines if the parameter should be passed to the super constructor.
	 */
	new(Parameter parameter, boolean passToSuper) {
		this.parameter = parameter
		this.passToSuper = passToSuper
	}

	/**
	 * Returns the delegate.
	 * 
	 * @return The wrapped parameter.
	 */
	def getDelegate() {
		return parameter
	}

	/**
	 * Returns the pass-to-super information.
	 * 
	 * @return Defines if the parameter should be passed to the super constructor.
	 */
	def isPassToSuper() {
		return passToSuper
	}

}
