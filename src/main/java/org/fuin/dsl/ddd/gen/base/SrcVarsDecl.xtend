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
	val boolean xmlElements
	val boolean json
	val List<Attribute> attributes

	/**
	 * Constructor with list of attributes.
	 * 
	 * @param ctx Context.
	 * @param modifiers Modifiers for the attribute.
	 * @param xml Create XML annotation.
	 * @param xmlElements Create always XML elements instead of attributes.
	 * @param json Create JSON annotation.
	 * @param attributes List.
	 */
	new(CodeSnippetContext ctx, String modifiers, boolean xml, boolean xmlElements, boolean json, List<Attribute> attributes) {
		this.ctx = ctx
		this.modifiers = modifiers
		this.xml = xml
		this.xmlElements = xmlElements
		this.json = json
		this.attributes = new ArrayList<Attribute>(attributes)
	}

	/**
	 * Constructor with internal type.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the attribute.
	 * @param xml Create XML annotation.
	 * @param xmlElements Create always XML elements instead of attributes.
	 * @param json Create JSON annotation.
	 * @param internalType Type that has a list of attributes.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, boolean xmlElements, boolean json, InternalType internalType) {
		this(ctx, visibility, xml, xmlElements, json, internalType.attributes)
	}

	/**
	 * Constructor with event.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the attribute.
	 * @param xml Create XML annotation.
	 * @param xmlElements Create always XML elements instead of attributes.
	 * @param json Create JSON annotation.
	 * @param event Event that has a list of attributes.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, boolean xmlElements, boolean json, Event event) {
		this(ctx, visibility, xml, xmlElements, json, event.attributes)
	}

	/**
	 * Constructor with exception.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the attribute.
	 * @param xml Create XML annotation.
	 * @param xmlElements Create always XML elements instead of attributes.
	 * @param json Create JSON annotation.
	 * @param exception Event that has a list of attributes.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, boolean xmlElements, boolean json, Exception ex) {
		this(ctx, visibility, xml, xmlElements, json, ex.attributes)
	}

	override toString() {
		'''
			«FOR attribute : attributes.nullSafe»
				«new SrcVarDecl(ctx, "private", xml, xmlElements, json, attribute)»
				
			«ENDFOR»
		'''
	}

}
