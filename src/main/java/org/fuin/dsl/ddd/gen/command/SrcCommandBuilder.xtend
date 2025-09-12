package org.fuin.dsl.ddd.gen.command

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEObjectExtensions.*
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.cqrs.cqrsDsl.Command
import org.fuin.dsl.cqrs.cqrsDsl.AbstractEntityId
import org.fuin.dsl.ddd.gen.base.SrcBuilderSetters

/**
 * Creates a builder snippet for a command.
 */
class SrcCommandBuilder implements CodeSnippet {
	
	val CodeSnippetContext ctx
	val GenerateOptions options
    val Command command

    new(CodeSnippetContext ctx, GenerateOptions options, Command command) {
    	this.ctx = ctx
    	this.options = options
        this.command = command
        if (options.jsonb) {
            ctx.requiresImport("org.fuin.cqrs4j.jsonb.AbstractAggregateCommand")        
        }
        if (options.jaxb) {
            ctx.requiresImport("org.fuin.cqrs4j.jaxb.AbstractAggregateCommand")        
        }
        if (options.jackson) {
            ctx.requiresImport("org.fuin.cqrs4j.jackson.AbstractAggregateCommand")        
        }
        
        ctx.requiresReference(command.entityIdType.uniqueName)
        
    }

    def AbstractEntityId getEntityIdType(Command command) {
        if (command.aggregate === null) {
            return null
        }
        return command.aggregate.idType
    }

    override toString() {
        var variables = command.target === null ? command.attributes : command.target.parameters
        '''
        /**
         * Builds an instance of the outer class.
         */
        public static final class Builder extends AbstractAggregateCommand.Builder<«command.entityIdType.name», «command.entityIdType.name», «command.name», Builder> {

            private «command.name» delegate;

            private Builder() {
                super(new «command.name»());
                delegate = delegate();
            }

            «new SrcBuilderSetters(ctx, options, variables)»

            /**
             * Creates the command and clears the builder.
             *
             * @return New instance.
             */
            public «command.name» build() {
                ensureBuildableAbstractAggregateCommand();
                if (delegate.getEventId() == null) {
                    this.eventId(new EventId());
                }
                if (delegate.getEventTimestamp() == null) {
                    this.timestamp(ZonedDateTime.now());
                }
                
            	«FOR variable : variables»
            	«IF variable.nullable === null»ensureNotNull("«variable.name»", delegate.«variable.name»);«ENDIF»
            	«ENDFOR»
                
                final «command.name» result = delegate;
                delegate = new «command.name»();
                resetAbstractAggregateCommand(delegate);
                return result;
            }

        }
        '''
    }
	
}