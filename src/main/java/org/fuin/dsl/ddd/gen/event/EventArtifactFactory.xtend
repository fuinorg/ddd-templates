package org.fuin.dsl.ddd.gen.event

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.base.SrcXmlRootElement
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EventExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

class EventArtifactFactory extends AbstractSource<Event> {

	override getModelType() {
		typeof(Event)
	}

	override create(Event event, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val AbstractEntity entity = event.entity;
		val className = event.getName()		
		var Namespace ns;
		if (entity == null) {
			ns = event.namespace;
		} else {
			ns = entity.namespace;		
		}
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(event.uniqueName, fqn)

		if (preparationRun) {
			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(entity)
		ctx.addReferences(event)

		var String src;
		if (entity == null) {
			src = createStandardEvent(ctx, event, pkg, className).toString();
		} else {
			src = createDomainEvent(ctx, event, pkg, className).toString();		
		}

		return new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, AbstractEntity entity) {
		ctx.requiresImport("org.fuin.objects4j.vo.KeyValue")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EventType")
		ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractDomainEvent")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPath")
		if (entity != null) {
			ctx.requiresImport("javax.validation.constraints.NotNull")		
		}
	}

	def addReferences(CodeSnippetContext ctx, Event event) {
		if (event.entity != null) {
			ctx.requiresReference(event.entityIdType.uniqueName)		
		}
	}

	def AbstractEntityId getEntityIdType(Event event) {
		if (event.entity == null) {
			return null
		}
		return (event.entity as AbstractEntity).idType
	}

	def createDomainEvent(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(event)»
			«new SrcXmlRootElement(ctx, event.name)»
			public final class «className» extends AbstractDomainEvent<«event.entityIdType.name»> {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("«event.name»");
				
				«new SrcVarsDecl(ctx, "private", true, event)»
			
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
				public «event.name»(@NotNull final EntityIdPath entityIdPath«IF event.variables.nullSafe.size > 0», «new SrcParamsDecl(ctx, event.variables)»«ENDIF») {
					super(entityIdPath);
					«new SrcParamsAssignment(ctx, event.variables)»
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

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def createStandardEvent(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(event)»
			«new SrcXmlRootElement(ctx, event.name)»
			public final class «className» extends AbstractEvent {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("«event.name»");
				
				«new SrcVarsDecl(ctx, "private", true, event)»
			
				«IF event.variables.nullSafe.size > 0»
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
				«FOR v : event.variables»
				 * @param «v.name» «v.superDoc» 
				«ENDFOR»
				 */
				public «event.name»(«new SrcParamsDecl(ctx, event.variables)») {
					super();
					«new SrcParamsAssignment(ctx, event.variables)»
				}
			
				@Override
				public final EventType getEventType() {
					return EVENT_TYPE;
				}
			
				«new SrcGetters(ctx, "public final", event.variables)»
			
				@Override
				public final String toString() {
					«IF event.variables.nullSafe.size == 0»
					return "«event.message»";
					«ELSE»
					return KeyValue.replace("«event.message»"
					«FOR v : event.variables SEPARATOR ','»
						new KeyValue("«v.name»", «v.name»)
					«ENDFOR»
					);
					«ENDIF»
				}
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
