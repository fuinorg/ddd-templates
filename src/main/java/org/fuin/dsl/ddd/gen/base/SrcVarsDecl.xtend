package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Creates source code for a one or more variable declarations.
 */
class SrcVarsDecl implements CodeSnippet {

	val CodeSnippetContext ctx
	val String visibility
	val boolean xml
	val List<Variable> variables

	/**
	 * Constructor with list of variables.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the variable.
	 * @param xml Create XML annotation.
	 * @param variables List.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, List<Variable> variables) {
		this.ctx = ctx
		this.visibility = visibility
		this.xml = xml
		this.variables = new ArrayList<Variable>(variables)
	}

	/**
	 * Constructor with internal type.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the variable.
	 * @param xml Create XML annotation.
	 * @param internalType Type that has a list of variables.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, InternalType internalType) {
		this(ctx, visibility, xml, internalType.variables)
	}

	/**
	 * Constructor with event.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the variable.
	 * @param xml Create XML annotation.
	 * @param event Event that has a list of variables.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, Event event) {
		this(ctx, visibility, xml, event.variables)
	}

	/**
	 * Constructor with exception.
	 * 
	 * @param ctx Context.
	 * @param visibility Visibility for the variable.
	 * @param xml Create XML annotation.
	 * @param exception Event that has a list of variables.
	 */
	new(CodeSnippetContext ctx, String visibility, boolean xml, Exception ex) {
		this(ctx, visibility, xml, ex.variables)
	}

	override toString() {
		'''
			«FOR variable : variables.nullSafe»
				«new SrcVarDecl(ctx, "private", xml, variable)»
				
			«ENDFOR»
		'''
	}

}
