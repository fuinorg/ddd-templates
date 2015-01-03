package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.gen.base.ConstructorParam

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Provides extension methods for Constructor.
 */
class ConstructorExtensions {

	def static List<Exception> allExceptions(Constructor constructor) {
		var List<Exception> list = new ArrayList<Exception>()
		for (cc : constructor.constraintCalls.nullSafe) {
			list.add(cc.constraint.exception)		
		}
		return list
	}

	def static List<Constraint> allConstraints(Constructor constructor) {
		val List<Constraint> list = new ArrayList<Constraint>()
		for (cc : constructor.constraintCalls.nullSafe) {
			list.add(cc.constraint)
		}
		return list
	}
	
	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param constructor Constructor with list of variables.
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(Constructor constructor) {
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
	def static List<ConstructorParam> parameters(Constructor constructor, boolean passToSuper) {
		return constructor.variables.parameters(passToSuper)
	}

}
