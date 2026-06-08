package org.fuin.dsl.ddd.gen.event

import java.util.Map
import org.fuin.dsl.cqrs.cqrsDsl.AbstractEntity
import org.fuin.dsl.cqrs.cqrsDsl.AbstractEntityId
import org.fuin.dsl.cqrs.cqrsDsl.Event
import org.fuin.dsl.cqrs.cqrsDsl.Namespace
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

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractEntityExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEObjectExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEventExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import java.util.List
import java.io.Serial
import java.time.ZonedDateTime

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

        return List.of(new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8")));
    }

    def addImports(CodeSnippetContext ctx, AbstractEntity entity, Event event) {
        ctx.requiresImport("org.fuin.ddd4j.core.EventType")
        
        if (entity === null) {
	        if (options.jsonb) {
	            ctx.requiresImport("org.fuin.ddd4j.jsonb.AbstractEvent")        
	        }
	        if (options.jaxb) {
	            ctx.requiresImport("org.fuin.ddd4j.jaxb.AbstractEvent")        
	        }
	        if (options.jackson) {
	            ctx.requiresImport("org.fuin.ddd4j.jackson.AbstractEvent")        
	        }
            if (event.attributes.nullSafe.size > 0) {
                ctx.requiresImport("org.fuin.objects4j.core.KeyValue")
            }
        } else {
	        if (options.jsonb) {
	            ctx.requiresImport("org.fuin.ddd4j.jsonb.AbstractDomainEvent")        
	        }
	        if (options.jaxb) {
	            ctx.requiresImport("org.fuin.ddd4j.jaxb.AbstractDomainEvent")        
	        }
	        if (options.jackson) {
	            ctx.requiresImport("org.fuin.ddd4j.jackson.AbstractDomainEvent")        
	        }
            ctx.requiresImport("jakarta.validation.constraints.NotNull")        
            ctx.requiresImport("org.fuin.objects4j.core.KeyValue")
            ctx.requiresImport("org.fuin.ddd4j.core.EventId")
            ctx.requiresImport(ZonedDateTime.name)
            ctx.requiresImport(Serial.name)
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
    	var variables = event.origin === null ? event.attributes : event.origin.parameters
        val String src = ''' 
            «new SrcJavaDocType(event)»
            «IF options.jaxb»
            «new SrcXmlRootElement(ctx, event.name)»
            «ENDIF»
            public final class «className» extends AbstractDomainEvent<«event.entityIdType.name»> {
            
                @Serial
                private static final long serialVersionUID = 1000L;
            
                /** Unique name used to store the event. */
                public static final EventType EVENT_TYPE = new EventType("«event.name»");
                
                «new SrcVarsDecl(ctx, "private", options, event)»
            
                @Override
                public EventType getEventType() {
                    return EVENT_TYPE;
                }
            
                «new SrcGetters(ctx, options, "public", variables)»
            
                @Override
                public String toString() {
                    return KeyValue.replace("«event.message»",
                        new KeyValue("#entityIdPath", getEntityIdPath())
                        «FOR v : variables»
                            , new KeyValue("«v.name»", «v.name»)
                        «ENDFOR»
                    );
                }
                
                /**
                 * Creates a new builder instance.
                 *
                 * @return New builder instance.
                 */
                public static Builder builder() {
                    return new Builder();
                }
                
                «new SrcEventBuilder(ctx, options, event)»
            }
            
        '''

        new SrcAll(ctx, copyrightHeader, pkg, ctx.imports, src).toString

    }

    def createStandardEvent(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
    	var variables = event.origin === null ? event.attributes : event.origin.parameters
        val String src = ''' 
            «new SrcJavaDocType(event)»
            «IF options.jaxb»
            «new SrcXmlRootElement(ctx, event.name)»
            «ENDIF»
            public final class «className» extends AbstractEvent {
            
                private static final long serialVersionUID = 1000L;
            
                /** Unique name used to store the event. */
                public static final EventType EVENT_TYPE = new EventType("«event.name»");
                
                «new SrcVarsDecl(ctx, "private", options, event)»
            
                «IF variables.nullSafe.size > 0»
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
                «FOR v : variables»
                    * @param «v.name» «v.superDoc» 
                «ENDFOR»
                */
                public «event.name»(«new SrcParamsDecl(ctx, options, variables.asParameters)») {
                    super();
                    «new SrcParamsAssignment(ctx, variables.asParameters)»
                }
            
                @Override
                public EventType getEventType() {
                    return EVENT_TYPE;
                }
            
                «new SrcGetters(ctx, options, "public", variables)»
            
                @Override
                public String toString() {
                    «IF variables.nullSafe.size == 0»
                        return "«event.message»";
                    «ELSE»
                        return KeyValue.replace("«event.message»"
                        «FOR v : variables»
                            , new KeyValue("«v.name»", «v.name»)
                        «ENDFOR»
                        );
                    «ENDIF»
                }
                
            }
        '''

        new SrcAll(ctx, copyrightHeader, pkg, ctx.imports, src).toString

    }

}
