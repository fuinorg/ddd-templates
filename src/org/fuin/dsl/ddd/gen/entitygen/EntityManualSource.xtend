package org.fuin.dsl.ddd.gen.entitygen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class EntityManualSource extends AbstractSource {
	
def create(Entity entity, Namespace ns) {
''' 
package «ns.name»;

«_imports(entity)»

/** «entity.doc.text» */
public class «entity.name» extends Abstract«entity.name» {

	«_constructorsDecl(entity, entity.constructors)»

	«_methodsDecl(entity.methods)»

	«_eventMethodsDecl(entity.methods)»

}
'''	
}

	
}