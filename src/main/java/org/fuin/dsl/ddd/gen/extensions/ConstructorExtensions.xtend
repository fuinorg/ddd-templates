package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception

import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions.*

/**
 * Provides extension methods for Constructor.
 */
class ConstructorExtensions {

	def static List<Exception> allExceptions(Constructor constructor) {
		var List<Exception> list = new ArrayList<Exception>();
		if (constructor.constraints != null) {
			list.addAll(constructor.constraints.exceptionList);
		}
		return list;
	}

	def static List<Constraint> allConstraints(Constructor constructor) {
		val List<Constraint> list = new ArrayList<Constraint>();
		if (constructor.constraints != null) {
			for (ConstraintCall cc : constructor.constraints.calls) {
				list.add(cc.constraint);
			}
		}
		return list;
	}

}
