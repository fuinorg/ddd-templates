package org.fuin.dsl.ddd.gen.resourceset

import org.fuin.dsl.ddd.gen.base.AbstractSource
import java.util.ArrayList
import java.util.HashMap
import java.util.Iterator
import java.util.List
import java.util.Map
import org.eclipse.emf.ecore.resource.ResourceSet
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class CtxEventRegistryArtifactFactory extends AbstractSource<ResourceSet> {

	override getModelType() {
		typeof(ResourceSet)
	}

	override isIncremental() {
		false
	}

	override create(ResourceSet resourceSet) throws GenerateException {

		val Map<String, List<Event>> contextEvents = resourceSet.contextEventMap

		val Iterator<String> ctxIt = contextEvents.keySet.iterator
		while (ctxIt.hasNext) {
			val String ctx = ctxIt.next
			val List<Event> events = contextEvents.get(ctx)
			val String pkg = getBasePkg() + "." + ctx + "." + getPkg()
			val filename = (pkg + "." + ctx.toFirstUpper + "EventRegistry").replace('.', '/') + ".java";
			// TODO Support multiple generated artifacts for ArtifactFactory
			return new GeneratedArtifact(artifactName, filename,
				create(pkg, ctx, events, resourceSet).toString().getBytes("UTF-8"));
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

	def create(String pkg, String ctx, List<Event> events, ResourceSet resourceSet) {
		''' 
			«copyrightHeader»
			package «pkg»;
			
			import java.nio.charset.Charset;
			
			import javax.enterprise.context.ApplicationScoped;
			
			import org.fuin.ddd4j.ddd.Deserializer;
			import org.fuin.ddd4j.ddd.DeserializerRegistry;
			import org.fuin.ddd4j.ddd.EventMetaData;
			import org.fuin.ddd4j.ddd.Serializer;
			import org.fuin.ddd4j.ddd.SerializerRegistry;
			import org.fuin.ddd4j.ddd.SimpleDeserializerRegistry;
			import org.fuin.ddd4j.ddd.XmlDeSerializer;
			
			«FOR event : events»
				import «event.fqn»;
			«ENDFOR»
			
			/**
			 * Contains a list of all events defined by this package.
			 */
			@ApplicationScoped
			public class «ctx.toFirstUpper»EventRegistry implements DeserializerRegistry,
				SerializerRegistry {
			
			    private final SimpleDeserializerRegistry registry;
			
			    @Inject
			    private EntityIdFactory entityIdFactory;
			
				@PostConstruct
				protected void init() {
					
					final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(entityIdFactory);
					final XmlAdapter<?, ?>[] adapters = new XmlAdapter<?, ?>[] { entityIdPathConverter };
					
					registry = new SimpleDeserializerRegistry();
					registry.add(new XmlDeSerializer("EventMetaData", EventMetaData.class));
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
	}

}
