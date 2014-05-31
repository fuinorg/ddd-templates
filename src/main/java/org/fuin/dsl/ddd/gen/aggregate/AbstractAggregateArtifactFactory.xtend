package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

/**
 * Generates an abstract aggregate Java class.
 */
class AbstractAggregateArtifactFactory extends AbstractSource<Aggregate>  {
	
	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.asPackage + ".Abstract" + aggregate.getName()).replace('.', '/') + ".java"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	/**
	 * Creates the actual source code.
	 */
	def create(Aggregate aggregate, Namespace ns) {
		'''
		«copyrightHeader» 
		package «ns.asPackage»;
		
		«_imports(aggregate)»
		
		«_typeDoc(aggregate)»
		public abstract class Abstract«aggregate.name» extends AbstractAggregateRoot<«aggregate.idType.name»> {
		
			@NotNull
			private «aggregate.idType.name» id;

			«_varsDecl(aggregate)»
		
			@Override
			public final EntityType getType() {				
				return «aggregate.idType.name».TYPE;
			}
		
			@Override
			public final «aggregate.idType.name» getId() {
				return id;
			}
		
			/**
			 * Sets the aggregate identifier.
			 * 
			 * @param id Unique aggregate identifier.
			 */
			protected final void setId(@NotNull final «aggregate.idType.name» id) {
				Contract.requireArgNotNull("id", id);
				this.id = id;
			}
			
			«_settersGetters("protected final", aggregate.variables)»
		
			«_abstractChildEntityLocatorMethods(aggregate)»

			«_eventAbstractMethodsDecl(aggregate)»
		
		}
	'''	
	}
	
}