package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ESRepositoryArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + aggregate.getName()).replace('.', '/') + "Repository.java"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	def create(Aggregate aggregate, Namespace ns) {
		''' 
		«copyrightHeader» 
		package «ns.asPackage»;
		
		import org.fuin.ddd4j.ddd.*;
		import org.fuin.ddd4j.esrepo.*;
		import org.fuin.ddd4j.eventstore.jpa.*;
		
		/**
		 * Repository that is capable of storing a {@link «aggregate.name»}.
		 */
		public final class «aggregate.name»Repository extends EventStoreRepository<«aggregate.idType.name», «aggregate.name»> {
		
			/**
			 * Constructor with event store to use as storage.
			 * 
			 * @param eventStore Event store.
			 * @param serRegistry Registry used to locate serializers.
			 * @param desRegistry Registry used to locate deserializers.
			 */
			public «aggregate.name»Repository(final EventStore eventStore,
					final SerializerRegistry serRegistry, final DeserializerRegistry desRegistry) {
				super(eventStore, serRegistry, desRegistry);
			}
		
			@Override
			public Class<«aggregate.name»> getAggregateClass() {
				return «aggregate.name».class;
			}
		
			@Override
			public final EntityType getAggregateType() {
				return «aggregate.idType.name».TYPE;
			}
		
			@Override
			public final «aggregate.name» create() {
				return new «aggregate.name»();
			}
		
			@Override
			protected final String getIdParamName() {
				return "«aggregate.idType.name.toFirstLower»";
			}
		
		}
		'''	
	}
	
}