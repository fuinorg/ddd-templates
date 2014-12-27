package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Provides extension methods for Constructor.
 */
class ConstructorExtensions {

	def static List<Exception> allExceptions(Constructor constructor) {
		var List<Exception> list = new ArrayList<Exception>();
		for (ConstraintCall cc : constructor.constraintCalls.nullSafe) {
			list.add(cc.constraint.exception);		
		}
		return list;
	}

	def static List<Constraint> allConstraints(Constructor constructor) {
		val List<Constraint> list = new ArrayList<Constraint>();
		for (ConstraintCall cc : constructor.constraintCalls.nullSafe) {
			list.add(cc.constraint);
		}
		return list;
	}

}
