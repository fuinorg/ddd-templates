package org.fuin.dsl.ddd.gen.aggregateid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AggregateIdStreamFactoryArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (aggregateId.entity == null) {
			return null;
		}
		val Namespace ns = aggregateId.eContainer() as Namespace;
		val filename = (ns.asPackage + "." + aggregateId.getName()).replace('.', '/') + "StreamFactory.java";
		return new GeneratedArtifact(artifactName, filename, create(aggregateId, ns).toString().getBytes("UTF-8"));
	}

	def create(AggregateId id, Namespace ns) {
		''' 
			«copyrightHeader»
			package «ns.asPackage»;
			
			import org.fuin.ddd4j.eventstore.intf.*;
			import org.fuin.ddd4j.eventstore.jpa.*;
			
			/**
			 * Creates a «id.entity.name»Stream based on a AggregateStreamId.
			 */
			public class «id.name»StreamFactory implements IdStreamFactory {
			
			    @Override
			    public final Stream createStream(final StreamId streamId) {
					final String id = streamId.getSingleParamValue();
					return new «id.entity.name»Stream(«id.name».valueOf(id));
			  }
			
			    @Override
				public boolean containsType(final StreamId streamId) {
				return streamId.getName().equals(«id.name».TYPE.asString());
				  }
			
			}
		'''
	}

}
