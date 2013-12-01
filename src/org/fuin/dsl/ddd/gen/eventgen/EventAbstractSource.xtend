package org.fuin.dsl.ddd.gen.eventgen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class EventAbstractSource extends AbstractSource {
	
	def create(Event event, Namespace ns) {
''' 
package «ns.name»;

import java.io.Serializable;
«_imports(event)»

/** «event.doc.text» */
public abstract class Abstract«event.name» implements Serializable {

	private static final long serialVersionUID = 1L;
	
	«_varsDecl(event.variables)»

	public Abstract«event.name»(«_paramsDecl(event.variables)») {
		super();
		«_paramsAssignment(event.variables)»
	}

	«_getters("public final", event.variables)»
	
}
''' 
	}
		
}