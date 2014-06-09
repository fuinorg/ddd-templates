package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

/**
 * Provides extension methods for ConstraintTarget.
 */
class ConstraintTargetExtensions {

	/**
	 * Returns the name of a constraint target.
	 * 
	 * @param target Target to return a name for.
	 * 
	 * @return Name.
	 */
	def static String getName(ConstraintTarget target) {
		if (target instanceof ValueObject) {
			return (target as ValueObject).name;
		} else if (target instanceof ExternalType) {
			return (target as ExternalType).name;
		}
		throw new IllegalStateException("Unknown constraint target type: " + target);
	}

	/**
	 * Returns the variables of a constraint target.
	 * 
	 * @param target Target to return a list of variables for.
	 * 
	 * @return Variables - Never null.
	 */
	def static List<Variable> getVariables(ConstraintTarget target) {
		if (target instanceof ValueObject) {
			return (target as ValueObject).variables;
		} else if (target instanceof ExternalType) {
			return new ArrayList<Variable>();
		}
		throw new IllegalStateException("Unknown constraint target type: " + target);
	}

}
