package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception

import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions.*

/**
 * Provides extension methods for Method.
 */
class MethodExtensions {


	def static List<Constraint> allConstraints(Method method) {
		val List<Constraint> list = new ArrayList<Constraint>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allConstraints);
		}
		if (method.constraints != null) {
			for (ConstraintCall cc : method.constraints.calls) {
				list.add(cc.constraint);
			}
		}
		return list;
	}

	def static List<Variable> allVariables(Method method) {
		var List<Variable> list = new ArrayList<Variable>();
		list.addAll(method.variables);
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allVariables);
		}
		return list;
	}

	def static List<Exception> allExceptions(Method method) {
		var List<Exception> list = new ArrayList<Exception>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allExceptions);
		}
		if (method.constraints != null) {
			list.addAll(method.constraints.exceptionList);
		}
		return list;
	}
	
}
