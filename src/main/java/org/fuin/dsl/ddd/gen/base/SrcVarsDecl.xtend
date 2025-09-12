package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.Event
import org.fuin.dsl.cqrs.cqrsDsl.Exception
import org.fuin.dsl.cqrs.cqrsDsl.InternalType
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*
import org.fuin.dsl.cqrs.cqrsDsl.Variable
import org.fuin.dsl.cqrs.cqrsDsl.Command

/**
 * Creates source code for a one or more attribute declarations.
 */
class SrcVarsDecl implements CodeSnippet {

    val CodeSnippetContext ctx
    val GenerateOptions options
    val List<? extends Variable> attributes

    /**
     * Constructor with list of attributes.
     * 
     * @param ctx Context.
     * @param modifiers Modifiers for the attribute.
     * @param options Options to use.
     * @param attributes List.
     */
    new(CodeSnippetContext ctx, String modifiers, GenerateOptions options, List<? extends Variable> attributes) {
        this.ctx = ctx
        this.options = options
        this.attributes = new ArrayList<Variable>(attributes)
    }

    /**
     * Constructor with internal type.
     * 
     * @param ctx Context.
     * @param visibility Visibility for the attribute.
     * @param options Options to use.
     * @param internalType Type that has a list of attributes.
     */
    new(CodeSnippetContext ctx, String visibility, GenerateOptions options, InternalType internalType) {
        this(ctx, visibility, options, internalType.attributes)
    }

    /**
     * Constructor with event.
     * 
     * @param ctx Context.
     * @param visibility Visibility for the attribute.
     * @param options Options to use.
     * @param event Event that has a list of attributes.
     */
    new(CodeSnippetContext ctx, String visibility, GenerateOptions options, Event event) {
        this(ctx, visibility, options, event.origin === null ? event.attributes : event.origin.parameters);    
    }

    /**
     * Constructor with command.
     * 
     * @param ctx Context.
     * @param visibility Visibility for the attribute.
     * @param options Options to use.
     * @param command Command that has a list of attributes.
     */
    new(CodeSnippetContext ctx, String visibility, GenerateOptions options, Command command) {
        this(ctx, visibility, options, command.target === null ? command.attributes : command.target.parameters);    
    }

    /**
     * Constructor with exception.
     * 
     * @param ctx Context.
     * @param visibility Visibility for the attribute.
     * @param options Options to use.
     * @param exception Event that has a list of attributes.
     */
    new(CodeSnippetContext ctx, String visibility, GenerateOptions options, Exception ex) {
        this(ctx, visibility, options, ex.attributes)
    }

    override toString() {
        '''
            «FOR attribute : attributes.nullSafe»
                «new SrcVarDecl(ctx, "private", options, attribute)»
                
            «ENDFOR»
        '''
    }

}
