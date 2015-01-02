package org.fuin.dsl.ddd.gen.extensions

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants
import org.fuin.objects4j.common.Nullable

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import java.util.Collections

/**
 * Provides extension methods for Invariants.
 */
class InvariantsExtensions {

	/**
	 * Returns a list of invariant calls in a null safe way.
	 * 
	 * @param invariants Map with registry.
	 * 
	 * @return Registry.
	 */
	@Nullable
	def static List<ConstraintCall> nullSafeCalls(@Nullable Invariants invariants) {
		if (invariants == null) {
			return Collections.EMPTY_LIST
		}
		return invariants.calls.nullSafe
	}

}
