package org.fuin.dsl.ddd.gen.entitygen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GeneratedArtifact

class EntityAbstractSource extends AbstractSource implements ArtifactFactory<Entity> {

	override getModelType() {
		typeof(Entity)
	}
	
	override init(ArtifactFactoryConfig config) {
		// Not used
	}
	
	override isIncremental() {
		true
	}

	override create(Entity entity) throws GenerateException {
        val Namespace ns = entity.eContainer() as Namespace;
        val filename = (ns.getName() + ".Abstract" + entity.getName()).replace('.', '/') + ".java";
        return new GeneratedArtifact("AbstractEntity", filename, create(entity, ns).toString());
	}

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
