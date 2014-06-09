package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.Collections
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints

class ConstraintsExtensions {
	
	def static List<String> exceptionList(Constraints constraints) {
		if (constraints == null) {
			return Collections::emptyList;
		}
		var List<String> list = new ArrayList<String>();
		for (call : constraints.calls) {
			if (call.constraint != null) {
				var String exception = call.constraint.exception.name;
				if (exception != null) {
					list.add(exception);
				}
			}
		}
		return list;
	}
	
}