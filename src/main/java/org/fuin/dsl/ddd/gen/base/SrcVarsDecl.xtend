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
	val String modifiers
	val boolean xml
	val List<Attribute> attributes

	/**
	 * Constructor with list of attributes.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers for the attribute.
	 * @param xml Create XML annotation.
	 * @param attributes List.
	 */
	new(CodeSnippetContext ctx, String modifiers, boolean xml, List<Attribute> attributes) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.xml = xml
		this.attributes = new ArrayList<Attribute>(attributes)
	}

	/**
	 * Constructor with internal type.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the attribute.
	 * @param xml Create XML annotation.
	 * @param internalType Type that has a list of attributes.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, InternalType internalType) {
		this(ctx, visibility, xml, internalType.attributes)
	}

	/**
	 * Constructor with event.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the attribute.
	 * @param xml Create XML annotation.
	 * @param event Event that has a list of attributes.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, Event event) {
		this(ctx, visibility, xml, event.attributes)
	}

	/**
	 * Constructor with exception.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the attribute.
	 * @param xml Create XML annotation.
	 * @param exception Event that has a list of attributes.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, Exception ex) {
		this(ctx, visibility, xml, ex.attributes)
	}

	override toString() {
		'''
			«FOR attribute : attributes.nullSafe»
				«new SrcVarDecl(ctx, "private", xml, attribute)»
				
			«ENDFOR»
		'''
	}

}
