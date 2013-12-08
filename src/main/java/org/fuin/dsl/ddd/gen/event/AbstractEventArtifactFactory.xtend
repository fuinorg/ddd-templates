package org.fuin.dsl.ddd.gen.event

import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AbstractEventArtifactFactory extends AbstractSource implements ArtifactFactory<Event> {
	
	String artifactName;
	
	override getModelType() {
		typeof(Event)
	}
	
	override init(ArtifactFactoryConfig config) {
		artifactName = config.getArtifact()
	}
	
	override isIncremental() {
		true
	}
	
	override create(Event event) throws GenerateException {
        val EObject method = event.eContainer();
        val EObject container = method.eContainer();
        if (container instanceof AbstractEntity) {
            val AbstractEntity entity = container as AbstractEntity;
            val Namespace ns = entity.eContainer() as Namespace;
            val String filename = (ns.getName() + ".Abstract" + event.getName()).replace('.', '/') + ".java";
	        return new GeneratedArtifact(artifactName, filename, create(event, ns).toString().getBytes("UTF-8"));
		}        
	}
	
	def create(Event event, Namespace ns) {
		''' 
		package «ns.name»;
		
		import java.io.Serializable;
		«_imports(event)»
		
		/** «event.doc.text» */
		public abstract class Abstract«event.name» implements Serializable {
		
			private static final long serialVersionUID = 1L;
			
			«_varsDecl(event.variables)»
		
			public Abstract«event.name»(«_paramsDecl(event.variables)») {
				super();
				«_paramsAssignment(event.variables)»
			}
		
			«_getters("public final", event.variables)»
			
		}
		''' 
	}
		
}