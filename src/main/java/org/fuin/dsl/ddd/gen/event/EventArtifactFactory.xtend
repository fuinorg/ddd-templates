package org.fuin.dsl.ddd.gen.event

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class EventArtifactFactory extends AbstractSource<Event> {

	override getModelType() {
		typeof(Event)
	}

	override create(Event event) throws GenerateException {
		val EObject method = event.eContainer();
		val EObject container = method.eContainer();
		if (container instanceof AbstractEntity) {
			val AbstractEntity entity = container as AbstractEntity;
			val Namespace ns = entity.eContainer() as Namespace;
			val filename = (ns.asPackage + "." + event.getName()).replace('.', '/') + ".java";
			return new GeneratedArtifact(artifactName, filename, create(event, ns).toString().getBytes("UTF-8"));
		}
	}

	def create(Event event, Namespace ns) {
		''' 
			«copyrightHeader»
			package «ns.asPackage»;
			
			import javax.validation.constraints.*;
			import javax.xml.bind.annotation.*;
			import org.fuin.objects4j.common.*;
			import org.fuin.objects4j.vo.*;
			import java.io.Serializable;
			«_imports(event)»
			
			/** «event.doc.text» */
			«_xmlRootElement(event.name)»
			public final class «event.name» extends AbstractDomainEvent<«event.entityIdType.name»> {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("«event.name»");
				
				«_varsDecl(event)»
			
				/**
				 * Protected default constructor for deserialization.
				 */
				protected «event.name»() {
					super();
				}
				
				/**
				 * «event.doc.text»
				 *
				 * @param entityIdPath Path from the aggregate root (first) to the entity that raised the event (last). 
				«FOR v : event.variables»
					* @param «v.name» «v.superDoc» 
				«ENDFOR»
				*/
				public «event.name»(@NotNull final EntityIdPath entityIdPath, «_paramsDecl(event.variables)») {
					super(entityIdPath);
					«_paramsAssignment(event.variables)»
				}
			
				@Override
				public final EventType getEventType() {
					return EVENT_TYPE;
				}
			
				«_getters("public final", event.variables)»

				@Override
				public final String toString() {
					return KeyValue.replace("«event.message»",
						new KeyValue("#entityIdPath", getEntityIdPath())
						«FOR v : event.variables»
						, new KeyValue("«v.name»", «v.name»)
						«ENDFOR»
					);
				}
				
			}
		'''
	}

	def _varsDecl(Event event) {
		'''
			«FOR variable : event.variables.nullSafe»
				«_varDecl(variable, true)»
				
			«ENDFOR»
		'''
	}

}
