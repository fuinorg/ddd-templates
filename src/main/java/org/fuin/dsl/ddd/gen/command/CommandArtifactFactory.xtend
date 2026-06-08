package org.fuin.dsl.ddd.gen.command

import java.util.Map
import org.fuin.dsl.cqrs.cqrsDsl.AbstractEntity
import org.fuin.dsl.cqrs.cqrsDsl.AbstractEntityId
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

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEObjectExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.Command
import org.fuin.dsl.cqrs.cqrsDsl.Aggregate
import java.io.Serial
import java.time.ZonedDateTime
import org.fuin.dsl.cqrs.cqrsDsl.AggregateId

class CommandArtifactFactory extends AbstractSource<Command> {

    override getModelType() {
        typeof(Command)
    }

    override create(Command command, Map<String, Object> context, boolean preparationRun) throws GenerateException {

        val Aggregate entity = command.aggregate
        val className = command.getName()
        var Namespace ns;
        if (entity === null) {
            ns = command.namespace;
        } else {
            ns = entity.namespace;
        }
        val pkg = ns.asPackage
        val fqn = pkg + "." + className
        val filename = fqn.replace('.', '/') + ".java";

        val CodeReferenceRegistry refReg = context.codeReferenceRegistry
        refReg.putReference(command.uniqueName, fqn)

        if (preparationRun) {

            // No code generation during preparation phase
            return null
        }

        val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
        ctx.addImports(entity, command)
        ctx.addReferences(command)

        var String src;
        if (entity === null) {
            src = createStandardCommand(ctx, command, pkg, className).toString();
        } else {
            src = createDomainCommand(ctx, command, pkg, className).toString();
        }

        return List.of(new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8")));
    }

    def addImports(CodeSnippetContext ctx, AbstractEntity entity, Command command) {
        ctx.requiresImport("org.fuin.ddd4j.core.EventType")
        
        if (entity === null) {
	        if (options.jsonb) {
	            ctx.requiresImport("org.fuin.cqrs4j.jsonb.AbstractCommand")        
	        }
	        if (options.jaxb) {
	            ctx.requiresImport("org.fuin.cqrs4j.jaxb.AbstractCommand")        
	        }
	        if (options.jackson) {
	            ctx.requiresImport("org.fuin.cqrs4j.jackson.AbstractCommand")        
	        }
            if (command.attributes.nullSafe.size > 0) {
                ctx.requiresImport("org.fuin.objects4j.core.KeyValue")
            }
        } else {
	        if (options.jsonb) {
	            ctx.requiresImport("org.fuin.cqrs4j.jsonb.AbstractAggregateCommand")        
	        }
	        if (options.jaxb) {
	            ctx.requiresImport("org.fuin.cqrs4j.jaxb.AbstractAggregateCommand")        
	        }
	        if (options.jackson) {
	            ctx.requiresImport("org.fuin.cqrs4j.jackson.AbstractAggregateCommand")        
	        }
            ctx.requiresImport("jakarta.validation.constraints.NotNull")        
            ctx.requiresImport("org.fuin.objects4j.core.KeyValue")
            ctx.requiresImport("org.fuin.ddd4j.core.EventId")
            ctx.requiresImport(ZonedDateTime.name)
            ctx.requiresImport(Serial.name)
        }
    }

    def addReferences(CodeSnippetContext ctx, Command command) {    	
        if (command.aggregate !== null) {
            ctx.requiresReference(command.entityIdType.uniqueName)
        }
    }

    def AggregateId getAggregateIdType(Command command) {
        if (command.aggregate === null) {
            return null
        }
        return command.aggregate.idType
    }

    def AbstractEntityId getEntityIdType(Command command) {
        if (command.entity === null) {
            return null
        }
        return command.entity.idType
    }

    def createDomainCommand(SimpleCodeSnippetContext ctx, Command command, String pkg, String className) {
    	var variables = command.target === null ? command.attributes : command.target.parameters
        val String src = ''' 
            «new SrcJavaDocType(command)»
            «IF options.jaxb»
            «new SrcXmlRootElement(ctx, command.name)»
            «ENDIF»
            public final class «className» extends AbstractAggregateCommand<«command.aggregateIdType.name», «command.entityIdType.name»> {
            
            	@Serial
                private static final long serialVersionUID = 1000L;
            
                /** Unique name used to store the command. */
                public static final EventType EVENT_TYPE = new EventType("«command.name»");
                
                «new SrcVarsDecl(ctx, "private", options, command)»
            
                @Override
                public EventType getEventType() {
                    return EVENT_TYPE;
                }
            
                «new SrcGetters(ctx, options, "public", variables)»
            
                @Override
                public String toString() {
                    return KeyValue.replace("«command.message»",
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
                
                «new SrcCommandBuilder(ctx, options,command)»
            }
        '''

        new SrcAll(ctx, copyrightHeader, pkg, ctx.imports, src).toString

    }

    def createStandardCommand(SimpleCodeSnippetContext ctx, Command command, String pkg, String className) {
    	var variables = command.target === null ? command.attributes : command.target.parameters
        val String src = ''' 
            «new SrcJavaDocType(command)»
            «IF options.jaxb»
            «new SrcXmlRootElement(ctx, command.name)»
            «ENDIF»
            public final class «className» extends AbstractCommand {
            
                private static final long serialVersionUID = 1000L;
            
                /** Unique name used to store the command. */
                public static final EventType EVENT_TYPE = new EventType("«command.name»");
                
                «new SrcVarsDecl(ctx, "private", options, command)»
            
                «IF variables.nullSafe.size > 0»
                    /**
                     * Protected default constructor for deserialization.
                     */
                    protected «command.name»() {
                        super();
                    }
                    
                «ENDIF»
                /**
                 * «command.doc.text»
                 *
                «FOR v : variables»
                    * @param «v.name» «v.superDoc» 
                «ENDFOR»
                */
                public «command.name»(«new SrcParamsDecl(ctx, options, variables.asParameters)») {
                    super();
                    «new SrcParamsAssignment(ctx, variables.asParameters)»
                }
            
                @Override
                public final EventType getEventType() {
                    return EVENT_TYPE;
                }
            
                «new SrcGetters(ctx, options, "public final", variables)»
            
                @Override
                public final String toString() {
                    «IF variables.nullSafe.size == 0»
                        return "«command.message»";
                    «ELSE»
                        return KeyValue.replace("«command.message»"
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
