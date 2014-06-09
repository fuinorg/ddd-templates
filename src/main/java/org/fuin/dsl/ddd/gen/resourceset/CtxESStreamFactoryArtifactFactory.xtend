package org.fuin.dsl.ddd.gen.resourceset

import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.resource.ResourceSet
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*

class CtxESStreamFactoryArtifactFactory extends AbstractSource<ResourceSet> {

	override getModelType() {
		typeof(ResourceSet)
	}

	override isIncremental() {
		false
	}

	override create(ResourceSet resourceSet, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val Map<String, List<AggregateId>> contextAggregateIds = resourceSet.contextAggregateIdMap

		val Iterator<String> ctxIt = contextAggregateIds.keySet.iterator
		while (ctxIt.hasNext) {
			val String ctx = ctxIt.next
			val List<AggregateId> aggregateIds = contextAggregateIds.get(ctx)
			val String pkg = getBasePkg() + "." + ctx + "." + getPkg()
			val filename = (pkg + "." + ctx.toFirstUpper + "StreamFactory").replace('.', '/') + ".java";

			// TODO Support multiple generated artifacts for ArtifactFactory
			return new GeneratedArtifact(artifactName, filename,
				create(pkg, ctx, aggregateIds, resourceSet).toString().getBytes("UTF-8"));
		}

	}

	def contextAggregateIdMap(ResourceSet resourceSet) {
		val Map<String, List<AggregateId>> contextEntityIds = new HashMap<String, List<AggregateId>>();
		val Iterator<AggregateId> iter = resourceSet.getAllContents().filter(typeof(AggregateId))
		while (iter.hasNext) {
			val AggregateId aggregateId = iter.next
			var List<AggregateId> aggregateIds = contextEntityIds.get(aggregateId.context.name)
			if (aggregateIds == null) {
				aggregateIds = new ArrayList<AggregateId>();
				contextEntityIds.put(aggregateId.context.name, aggregateIds)
			}
			aggregateIds.add(aggregateId)
		}
		return contextEntityIds
	}

	def create(String pkg, String ctx, List<AggregateId> aggregateIds, ResourceSet resourceSet) {
		''' 
			«copyrightHeader»
			package «pkg»;
				
			import java.util.*;
			import javax.enterprise.context.*;
			import org.fuin.ddd4j.eventstore.intf.*;
			import org.fuin.ddd4j.eventstore.jpa.*;
			
			/**
			 * Creates a stream for all known EMS aggregates based on a AggregateRootId.
			 */
			@ApplicationScoped
			public class «ctx.toFirstUpper»StreamFactory implements IdStreamFactory {
			
			    private Map<String, IdStreamFactory> map;
			
			    /**
			     * Default constructor.
			     */
			    public «ctx.toFirstUpper»StreamFactory() {
					super();
					map = new HashMap<String, IdStreamFactory>();
					«FOR aggregateId : aggregateIds»
				map.put(«aggregateId.name».TYPE.asString(), new «aggregateId.name»StreamFactory());
					«ENDFOR»
			    }
			
			    @Override
			    public boolean containsType(final StreamId streamId) {
					return map.get(streamId.getName()) != null;
			  }
			
			    @Override
			    public Stream createStream(final StreamId streamId) {
					final IdStreamFactory factory = map.get(streamId.getName());
					if (factory == null) {
			    throw new IllegalArgumentException("Unknown stream id type: "
			     + streamId);
					}
					return factory.createStream(streamId);
			  }
			
			}
		'''
	}

}
