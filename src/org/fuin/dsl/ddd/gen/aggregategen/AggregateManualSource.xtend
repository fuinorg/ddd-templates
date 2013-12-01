package org.fuin.dsl.ddd.gen.aggregategen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class AggregateManualSource extends AbstractSource {
	
def create(Aggregate aggregate, Namespace ns) {
''' 
package «ns.name»;

«_imports(aggregate)»

/** «aggregate.doc.text» */
public class «aggregate.name» extends Abstract«aggregate.name» {

	«_constructorsDecl(aggregate, aggregate.constructors)»

	«_methodsDecl(aggregate.methods)»

	«_eventMethodsDecl(aggregate.methods)»

}
'''	
}
	
}