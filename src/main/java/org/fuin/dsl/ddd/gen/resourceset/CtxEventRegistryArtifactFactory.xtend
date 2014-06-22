package org.fuin.dsl.ddd.gen.resourceset

import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.resource.ResourceSet
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EventExtensions.*

class CtxEventRegistryArtifactFactory extends AbstractSource<ResourceSet> {

	override getModelType() {
		typeof(ResourceSet)
	}

	override isIncremental() {
		false
	}

	override create(ResourceSet resourceSet, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val Map<String, List<Event>> contextEvents = resourceSet.contextEventMap

		val Iterator<String> ctxIt = contextEvents.keySet.iterator
		while (ctxIt.hasNext) {
			val String ctx = ctxIt.next
			val List<Event> events = contextEvents.get(ctx)

			val className = ctx.toFirstUpper + "EventRegistry"
			val String pkg = contextPkg(ctx)
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
			sctx.addReferences(events)

			return new GeneratedArtifact(artifactName, filename,
				create(sctx, ctx, pkg, className, events, resourceSet).toString().getBytes("UTF-8"));
		}

	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.enterprise.context.ApplicationScoped")
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter")
		ctx.requiresImport("java.nio.charset.Charset")
		ctx.requiresImport("javax.inject.Inject")
		ctx.requiresImport("javax.annotation.PostConstruct")
		ctx.requiresImport("org.fuin.ddd4j.ddd.SerializerDeserializerRegistry")
		ctx.requiresImport("org.fuin.ddd4j.ddd.Deserializer")
		ctx.requiresImport("org.fuin.ddd4j.ddd.Serializer")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdFactory")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPathConverter")
		ctx.requiresImport("org.fuin.ddd4j.ddd.BasicEventMetaData")		
		ctx.requiresImport("org.fuin.ddd4j.ddd.XmlDeSerializer")
		ctx.requiresImport("org.fuin.ddd4j.ddd.SimpleSerializerDeserializerRegistry")
	}

	def addReferences(CodeSnippetContext ctx, List<Event> events) {
		for (event : events) {
			ctx.requiresReference(event.uniqueName)
		}
	}

	def contextEventMap(ResourceSet resourceSet) {
		val Map<String, List<Event>> contextEvents = new HashMap<String, List<Event>>();
		val Iterator<Event> iter = resourceSet.getAllContents().filter(typeof(Event))
		while (iter.hasNext) {
			val Event event = iter.next
			var List<Event> events = contextEvents.get(event.context.name)
			if (events == null) {
				events = new ArrayList<Event>();
				contextEvents.put(event.context.name, events)
			}
			events.add(event)
		}
		return contextEvents
	}

	def create(SimpleCodeSnippetContext sctx, String ctx, String pkg, String className, List<Event> events, ResourceSet resourceSet) {
		val String src = ''' 
			/**
			 * Contains a list of all events defined by this package.
			 */
			@ApplicationScoped
			public class «className» implements SerializerDeserializerRegistry {
			
			    private SimpleSerializerDeserializerRegistry registry;
			
			    @Inject
			    private EntityIdFactory entityIdFactory;
			
				@PostConstruct
				protected void init() {
					
					final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(entityIdFactory);
					final XmlAdapter<?, ?>[] adapters = new XmlAdapter<?, ?>[] { entityIdPathConverter };
					
					registry = new SimpleSerializerDeserializerRegistry();
					registry.add(new XmlDeSerializer("BasicEventMetaData", BasicEventMetaData.class));
					«FOR event : events»
						registry.add(new XmlDeSerializer(«event.name».EVENT_TYPE.asBaseType(), adapters, «event.name».class));
					«ENDFOR»
			
				}
			
			  	@Override
			  	 public Serializer getSerializer(final String type) {
					return registry.getSerializer(type);
				}
			
			    @Override
			    public Deserializer getDeserializer(final String type, final int version, final String mimeType, final Charset encoding) {
					return registry.getDeserializer(type, version, mimeType, encoding);
				}
			
			}
			
		'''

		new SrcAll(copyrightHeader, pkg, sctx.imports, src).toString 

	}

}
