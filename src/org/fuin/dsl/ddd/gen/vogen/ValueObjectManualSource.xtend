package org.fuin.dsl.ddd.gen.vogen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource

class ValueObjectManualSource extends AbstractSource {
	
def create(ValueObject vo, Namespace ns) {
''' 
package «ns.name»;

«_imports(vo)»

/** «vo.doc.text» */
public class «vo.name» extends Abstract«vo.name» {

	public «vo.name»(«_paramsDecl(vo.variables)») {
		«_superCall(vo.variables)»
	}
	
}
'''	
}
	
}