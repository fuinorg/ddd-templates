package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Creates source code for a one or more attribute declarations.
 */
class SrcVarsDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val GenerateOptions options
	val List<Attribute> attributes

	/**
	 * Constructor with list of attributes.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers for the attribute.
	 * @param options Options to use.
	 * @param attributes List.
	 */
	new(CodeSnippetContext ctx, String modifiers, GenerateOptions options, List<Attribute> attributes) {
		this.ctx = ctx
		this.options = options
		this.attributes = new ArrayList<Attribute>(attributes)
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
		this(ctx, visibility, options, event.attributes)
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
