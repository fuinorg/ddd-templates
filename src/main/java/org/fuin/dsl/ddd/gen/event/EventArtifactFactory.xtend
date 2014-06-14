package org.fuin.dsl.ddd.gen.event

import java.util.Map
import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EventExtensions.*

class EventArtifactFactory extends AbstractSource<Event> {

	override getModelType() {
		typeof(Event)
	}

	override create(Event event, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		val EObject method = event.eContainer();
		val EObject container = method.eContainer();
		if (container instanceof AbstractEntity) {
			val AbstractEntity entity = container as AbstractEntity;
			
			val className = event.getName()
			val Namespace ns = entity.eContainer() as Namespace;
			val pkg = ns.asPackage
			val fqn = pkg + "." + event.getName()
			val filename = fqn.replace('.', '/') + ".java";
			
			val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
			refReg.putReference(event.uniqueName, fqn)

			if (preparationRun) {
	
				// No code generation during preparation phase
				return null
			}
			
			val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext()
			ctx.addImports
			ctx.addReferences(event)
			ctx.resolve(refReg)
			
			return new GeneratedArtifact(artifactName, filename, create(ctx, event, pkg, className).toString().getBytes("UTF-8"));
		}
	}

	def AbstractEntityId getEntityIdType(Event event) {
		var AbstractEntity abstractEntity = (event.eContainer.eContainer as AbstractEntity);
		return abstractEntity.idType
	}
	
	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")
	}	

	def addReferences(CodeSnippetContext ctx, Event event) {		
	}

	def create(CodeSnippetContext ctx, Event event, String pkg, String className) {
		''' 
			«copyrightHeader»
			package «pkg»;
			
			«_imports(event)»
			
			/** «event.doc.text» */
			«_xmlRootElement(event.name)»
			public final class «className» extends AbstractDomainEvent<«event.entityIdType.name»> {
			
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
			
				«new SrcGetters(ctx, "public final", event.variables)»
			
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
