package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory

class DomainDrivenDesignDslFactoryExtensions {

	/**
	 * Creates a variable with a name.
	 * 
	 * @param factory Factory.
	 * @param name Name.
	 */
	def static createVariable(DomainDrivenDesignDslFactory factory, String name) {
		createVariable(factory, name, false)
	}

	/**
	 * Creates a variable with a name and "nullable" information.
	 * 
	 * @param factory Factory.
	 * @param name Name.
	 * @param nullable TRUE if nullable, else false.
	 */
	def static createVariable(DomainDrivenDesignDslFactory factory, String name, boolean nullable) {
		var v = factory.createVariable
		v.setName(name)
		if (nullable) {
			v.setNullable("nullable")
		}
		return v
	}

}
