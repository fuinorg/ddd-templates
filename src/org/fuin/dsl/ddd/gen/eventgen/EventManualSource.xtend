package org.fuin.dsl.ddd.gen.eventgen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class EventManualSource extends AbstractSource {
	
	def create(Event event, Namespace ns) {
''' 
package «ns.name»;

«_imports(event)»

/** «event.doc.text» */
public class «event.name» extends Abstract«event.name» {

	private static final long serialVersionUID = 1L;

	public «event.name»(«_paramsDecl(event.variables)») {
		«_superCall(event.variables)»
	}
	
}
''' 
	}
	
}