package org.fuin.dsl.ddd.gen.exceptions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class ExceptionManualSource extends AbstractSource {
	
def create(Constraint constr, Namespace ns) {
''' 
package «ns.name»;

«_imports(constr)»

/** «constr.doc.text» */
public final class «constr.exception» extends Abstract«constr.exception» {

	private static final long serialVersionUID = 1L;

	public «constr.exception»(«_paramsDecl(allVariables(constr))») {
		«_superCall(allVariables(constr))»
	}

}
'''	
}

}