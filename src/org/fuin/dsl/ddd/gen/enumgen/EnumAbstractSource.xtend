package org.fuin.dsl.ddd.gen.enumgen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class EnumAbstractSource extends AbstractSource {
	
def create(EnumObject vo, Namespace ns) {
''' 
package «ns.name»;

«_imports(vo)»

/** «vo.doc.text» */
public enum «vo.name» {

«FOR in : vo.instances SEPARATOR ','»
	«in.doc»
	«in.name»(«_methodCall(vo.variables, in.params)»)
	
«ENDFOR»;

	«_varsDecl(vo.variables)»

	private «vo.name»(«_paramsDecl(vo.variables)») {
		«_paramsAssignment(vo.variables)»
	}

}
'''	
}
	
}