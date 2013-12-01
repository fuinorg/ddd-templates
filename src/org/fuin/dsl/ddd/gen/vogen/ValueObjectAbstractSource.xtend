package org.fuin.dsl.ddd.gen.vogen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource

class ValueObjectAbstractSource extends AbstractSource {

def create(ValueObject vo, Namespace ns) {
''' 
package «ns.name»;

«_imports(vo)»

/** «vo.doc.text» */
public abstract class Abstract«vo.name» {

	«_varsDecl(vo.variables)»

	public Abstract«vo.name»(«_paramsDecl(vo.variables)») {
		super();
		«_paramsAssignment(vo.variables)»
	}
	
}
'''	
}
	
}