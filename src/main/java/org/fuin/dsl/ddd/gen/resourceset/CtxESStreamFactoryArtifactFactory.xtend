package org.fuin.dsl.ddd.gen.resourceset

import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.resource.ResourceSet
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

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

			val className = ctx.toFirstUpper + "StreamFactory"
			val String pkg = getBasePkg() + "." + ctx + "." + getPkg()
			val fqn = pkg + "." + className
			val filename = fqn.replace('.', '/') + ".java";

			val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
			refReg.putReference(className, fqn)

			// TODO Support multiple generated artifacts for ArtifactFactory
			if (preparationRun) {
				return null
			}

			val SimpleCodeSnippetContext sctx = new SimpleCodeSnippetContext(refReg)
			sctx.addImports
			sctx.addReferences

			return new GeneratedArtifact(artifactName, filename,
				create(sctx, ctx, pkg, className, aggregateIds, resourceSet).toString().getBytes("UTF-8"));
		}

	}

	def addImports(CodeSnippetContext ctx) {
	}

	def addReferences(CodeSnippetContext ctx) {
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

	def create(SimpleCodeSnippetContext sctx, String ctx, String pkg, String className, List<AggregateId> aggregateIds,
		ResourceSet resourceSet) {
		val String src = ''' 
			/**
			 * Creates a stream for all known EMS aggregates based on a AggregateRootId.
			 */
			@ApplicationScoped
			public class «className» implements IdStreamFactory {
			
			    private Map<String, IdStreamFactory> map;
			
			    /**
			     * Default constructor.
			     */
			    public «className»() {
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

		new SrcAll(copyrightHeader, pkg, sctx.imports, src).toString 

	}

}
