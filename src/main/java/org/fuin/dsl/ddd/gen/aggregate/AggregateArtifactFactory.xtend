package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AggregateArtifactFactory extends AbstractSource implements ArtifactFactory<Aggregate> {

	String artifactName;

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override init(ArtifactFactoryConfig config) {
		artifactName = config.getArtifact()
	}
	
	override isIncremental() {
		true
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val String filename = ns.name + '.' + aggregate.name.replace('.', '/') + ".java";
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString());
	}
	
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