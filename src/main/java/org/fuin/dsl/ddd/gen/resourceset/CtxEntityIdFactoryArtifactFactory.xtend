package org.fuin.dsl.ddd.gen.resourceset

import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.resource.ResourceSet
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcImports
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import org.fuin.dsl.ddd.gen.base.SrcAll

class CtxEntityIdFactoryArtifactFactory extends AbstractSource<ResourceSet> {

	override getModelType() {
		typeof(ResourceSet)
	}

	override isIncremental() {
		false
	}

	override create(ResourceSet resourceSet, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val Map<String, List<AbstractEntityId>> contextEntityIds = resourceSet.contextEntityIdMap

		val Iterator<String> ctxIt = contextEntityIds.keySet.iterator
		while (ctxIt.hasNext) {
			val String ctx = ctxIt.next
			val List<AbstractEntityId> entityIds = contextEntityIds.get(ctx)

			val className = ctx.toFirstUpper + "EntityIdFactory"
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
				create(sctx, ctx, pkg, className, entityIds, resourceSet).toString().getBytes("UTF-8"));

		}

	}

	def addImports(CodeSnippetContext ctx) {
	}

	def addReferences(CodeSnippetContext ctx) {
	}

	def contextEntityIdMap(ResourceSet resourceSet) {
		val Map<String, List<AbstractEntityId>> contextEntityIds = new HashMap<String, List<AbstractEntityId>>();
		val Iterator<AbstractEntityId> iter = resourceSet.getAllContents().filter(typeof(AbstractEntityId))
		while (iter.hasNext) {
			val AbstractEntityId entityId = iter.next
			var List<AbstractEntityId> entityIds = contextEntityIds.get(entityId.context.name)
			if (entityIds == null) {
				entityIds = new ArrayList<AbstractEntityId>();
				contextEntityIds.put(entityId.context.name, entityIds)
			}
			entityIds.add(entityId)
		}
		return contextEntityIds
	}

	def create(SimpleCodeSnippetContext sctx, String ctx, String pkg, String className, List<AbstractEntityId> entityIds,
		ResourceSet resourceSet) {
		val String src = ''' 
			/**
			 * Creates entity identifier instanced based on the type.
			 */
			@ApplicationScoped
			public final class «className» implements EntityIdFactory {
			
			    private Map<String, SingleEntityIdFactory> map;
			
			    /**
			     * Default constructor.
			     */
			    public «className»() {
					super();
					map = new HashMap<String, SingleEntityIdFactory>();
					«FOR entityId : entityIds»
					map.put(«entityId.name».TYPE.asString(), new «entityId.name»Converter());
					«ENDFOR»
			    }
			
			    @Override
			    public EntityId createEntityId(final String type, final String id) {
					final SingleEntityIdFactory factory = map.get(type);
					if (factory == null) {
			  			throw new IllegalArgumentException("Unknown type: " + type);
					}
					return factory.createEntityId(id);
			  }
			
			    @Override
			    public boolean containsType(final String type) {
					return map.containsKey(type);
			  }
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, sctx.imports, src).toString 

	}

}
