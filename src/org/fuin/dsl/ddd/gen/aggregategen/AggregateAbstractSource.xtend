package org.fuin.dsl.ddd.gen.aggregategen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class AggregateAbstractSource extends AbstractSource {
	
def create(Aggregate aggregate, Namespace ns) {
''' 
package «ns.name»;

«_imports(aggregate)»

/** «aggregate.doc.text» */
public abstract class Abstract«aggregate.name» {

	«_varsDecl(aggregate.variables)»

	«_settersGetters("protected final", aggregate.variables)»

	«_abstractMethodsDecl(aggregate.methods)»

	«_eventAbstractMethodsDecl(aggregate.methods)»

}
'''	
}
	
}