package org.fuin.dsl.ddd.gen.exceptions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class ExceptionAbstractSource  extends AbstractSource {
	
def create(Constraint constr, Namespace ns) {
''' 
package «ns.name»;

«_imports(constr)»

/** «constr.doc.text» */
public abstract class Abstract«constr.exception» extends Exception {

	private static final long serialVersionUID = 1L;

	«_varsDecl(allVariables(constr))»

	public Abstract«constr.exception»(«_paramsDecl(allVariables(constr))») {
		super("«constr.message.text»");
		«_paramsAssignment(allVariables(constr))»
	}

	«_getters("public final", allVariables(constr))»

}
'''	
}

}