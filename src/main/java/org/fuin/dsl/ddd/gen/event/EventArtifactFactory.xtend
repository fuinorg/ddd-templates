package org.fuin.dsl.ddd.gen.event

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.base.SrcXmlRootElement
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAttributeExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEventExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class EventArtifactFactory extends AbstractSource<Event> {

	override getModelType() {
		typeof(Event)
	}

	override create(Event event, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val AbstractEntity entity = event.entity;
		val className = event.getName()
		var Namespace ns;
		if (entity === null) {
			ns = event.namespace;
		} else {
			ns = entity.namespace;
		}
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(event.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(entity, event)
		ctx.addReferences(event)

		var String src;
		if (entity === null) {
			src = createStandardEvent(ctx, event, pkg, className).toString();
		} else {
			src = createDomainEvent(ctx, event, pkg, className).toString();
		}

		return new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, AbstractEntity entity, Event event) {
		ctx.requiresImport("org.fuin.ddd4j.ddd.EventType")
		if (entity === null) {
			ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractEvent")
			if (event.attributes.nullSafe.size > 0) {
				ctx.requiresImport("org.fuin.objects4j.vo.KeyValue")
			}
		} else {
			ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractDomainEvent")
			ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPath")
			ctx.requiresImport("javax.validation.constraints.NotNull")		
			ctx.requiresImport("org.fuin.objects4j.vo.KeyValue")
		}
	}

	def addReferences(CodeSnippetContext ctx, Event event) {
		if (event.entity !== null) {
			ctx.requiresReference(event.entityIdType.uniqueName)
		}
	}

	def AbstractEntityId getEntityIdType(Event event) {
		if (event.entity === null) {
			return null
		}
		return event.entity.idType
	}

	def createDomainEvent(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDocType(event)»
			«new SrcXmlRootElement(ctx, event.name)»
			public final class «className» extends AbstractDomainEvent<«event.entityIdType.name»> {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("«event.name»");
				
				«new SrcVarsDecl(ctx, "private", options, event)»
			
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
				«FOR v : event.attributes»
					* @param «v.name» «v.superDoc» 
				«ENDFOR»
				*/
				public «event.name»(@NotNull final EntityIdPath entityIdPath«IF event.attributes.nullSafe.size > 0», «new SrcParamsDecl(
				ctx, options, event.attributes.asParameters)»«ENDIF») {
					super(entityIdPath);
					«new SrcParamsAssignment(ctx, event.attributes.asParameters)»
				}
			
				@Override
				public final EventType getEventType() {
					return EVENT_TYPE;
				}
			
				«new SrcGetters(ctx, options, "public final", event.attributes)»
			
				@Override
				public final String toString() {
					return KeyValue.replace("«event.message»",
						new KeyValue("#entityIdPath", getEntityIdPath())
						«FOR v : event.attributes»
							, new KeyValue("«v.name»", «v.name»)
						«ENDFOR»
					);
				}
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def createStandardEvent(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDocType(event)»
			«new SrcXmlRootElement(ctx, event.name)»
			public final class «className» extends AbstractEvent {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("«event.name»");
				
				«new SrcVarsDecl(ctx, "private", options, event)»
			
				«IF event.attributes.nullSafe.size > 0»
					/**
					 * Protected default constructor for deserialization.
					 */
					protected «event.name»() {
						super();
					}
					
				«ENDIF»
				/**
				 * «event.doc.text»
				 *
				«FOR v : event.attributes»
					* @param «v.name» «v.superDoc» 
				«ENDFOR»
				*/
				public «event.name»(«new SrcParamsDecl(ctx, options, event.attributes.asParameters)») {
					super();
					«new SrcParamsAssignment(ctx, event.attributes.asParameters)»
				}
			
				@Override
				public final EventType getEventType() {
					return EVENT_TYPE;
				}
			
				«new SrcGetters(ctx, options, "public final", event.attributes)»
			
				@Override
				public final String toString() {
					«IF event.attributes.nullSafe.size == 0»
						return "«event.message»";
					«ELSE»
						return KeyValue.replace("«event.message»"
						«FOR v : event.attributes»
							, new KeyValue("«v.name»", «v.name»)
						«ENDFOR»
						);
					«ENDIF»
				}
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
