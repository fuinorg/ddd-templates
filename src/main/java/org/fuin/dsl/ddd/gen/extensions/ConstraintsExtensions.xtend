package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.Collections
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception

class ConstraintsExtensions {
	
	def static List<Exception> exceptionList(Constraints constraints) {
		if (constraints == null) {
			return Collections::emptyList;
		}
		var List<Exception> list = new ArrayList<Exception>();
		for (call : constraints.calls) {
			if (call.constraint != null) {
				var Exception exception = call.constraint.exception;
				if (exception != null) {
					list.add(exception);
				}
			}
		}
		return list;
	}
	
}