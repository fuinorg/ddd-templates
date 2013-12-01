package org.fuin.dsl.ddd.gen.entitygen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource

class EntityAbstractSource extends AbstractSource {

	def create(Entity entity, Namespace ns) {
		''' 
package «ns.name»;

«_imports(entity)»

/** «entity.doc.text» */
public abstract class Abstract«entity.name» {

	«_varsDecl(entity.variables)»

	«_settersGetters("protected final", entity.variables)»

	«_abstractMethodsDecl(entity.methods)»

	«_eventAbstractMethodsDecl(entity.methods)»

}
'''
	}



}
