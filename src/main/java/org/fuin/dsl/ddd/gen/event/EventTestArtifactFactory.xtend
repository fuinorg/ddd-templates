package org.fuin.dsl.ddd.gen.event

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class EventTestArtifactFactory extends AbstractSource<Event> {
	
	override getModelType() {
		typeof(Event)
	}
	
	override create(Event event) throws GenerateException {
        val EObject method = event.eContainer();
        val EObject container = method.eContainer();
        if (container instanceof AbstractEntity) {
            val AbstractEntity entity = container as AbstractEntity;
            val Namespace ns = entity.eContainer() as Namespace;
        	val filename = (ns.asPackage + "." + event.getName()).replace('.', '/') + "Test.java";
	        return new GeneratedArtifact(artifactName, filename, create(event, ns).toString().getBytes("UTF-8"));
		}        
	}
	
	def create(Event event, Namespace ns) {
		''' 
		«copyrightHeader»
		package «ns.asPackage»;
		
		import static org.fest.assertions.Assertions.assertThat;
		«_imports(event)»
		
		// CHECKSTYLE:OFF
		public final class «event.name»Test extends AbstractBaseTest {

			@Test
			public final void testSerializeDeserialize() {
		
				// PREPARE
				final «event.name» original = createTestee();
		
				// TEST
				final «event.name» copy = deserialize(serialize(original));
		
				// VERIFY
				assertThat(original).isEqualTo(copy);
		
			}
		
			@Test
			public final void testMarshalUnmarshal() {
		
				// PREPARE
				final «event.name» original = createTestee();
		
				// TEST
				final String xml = marshal(original, createAdapter(), «event.name».class);
				final «event.name» copy = unmarshal(xml, createAdapter(), «event.name».class);
		
				// VERIFY
				assertThat(original).isEqualTo(copy);
		
			}		

			private «event.name» createTestee() {
				final AId aId = null;
				«FOR v : event.variables.nullSafe»
				final «asJavaType(v)» «v.name» = null;
				«ENDFOR»
		
				return new «event.name»(new EntityIdPath(aId), «_methodCall(event.variables)»);
			}				
			
		    protected final XmlAdapter<?, ?>[] createAdapter() {
				final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(new EmsEntityIdFactory());
				return new XmlAdapter[] { entityIdPathConverter };
		    }
			
		}
		// CHECKSTYLE:ON
		''' 
	}
	
	
}