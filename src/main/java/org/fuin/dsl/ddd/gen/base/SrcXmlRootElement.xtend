package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

/**
 * Creates source code for a JAXB root element annotation.
 */
class SrcXmlRootElement implements CodeSnippet {

	val CodeSnippetContext ctx
	val String name

	/**
	 * Constructor with name.
	 * 
	 * @param ctx Context.
	 * @param name Type name.
	 */
	new(CodeSnippetContext ctx, String name) {
		this.ctx = ctx
		this.name = name
		ctx.requiresImport("javax.xml.bind.annotation.XmlRootElement")
	}

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param vo Value object.
	 */
	new(CodeSnippetContext ctx, ValueObject vo) {
		this(ctx, vo.name)
	}

	/**
	 * Constructor with event.
	 * 
	 * @param ctx Context.
	 * @param event Event.
	 */
	new(CodeSnippetContext ctx, Event event) {
		this(ctx, event.name)
	}

	/**
	 * Constructor with element.
	 * 
	 * @param ctx Context.
	 * @param el Element.
	 */
	new(CodeSnippetContext ctx, AbstractElement el) {
		this(ctx, el.name)
	}

	override toString() {
		'''@XmlRootElement(name = "«name.toXmlName»")'''
	}

}
