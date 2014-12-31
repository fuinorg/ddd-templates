package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO

/**
 * Creates source code for a number of methods.
 */
class SrcMethods implements CodeSnippet {

	val CodeSnippetContext ctx;
	val List<MethodData> methods

	/**
	 * Constructor with entity.
	 * 
	 * @param ctx Context.
	 * @param entity Entity.
	 */
	new(CodeSnippetContext ctx, AbstractEntity entity) {
		this.ctx = ctx
		this.methods = new ArrayList<MethodData>()
		for (method : entity.methods.nullSafe) {
			this.methods.add(new MethodData("public final", false, method))
		}
	}

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param type Value object.
	 */
	new(CodeSnippetContext ctx, AbstractVO vo) {
		this.ctx = ctx
		this.methods = new ArrayList<MethodData>()
		for (method : vo.methods.nullSafe) {
			this.methods.add(new MethodData("public final", false, method))
		}
	}

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param typeName Name of the type the constructors creates.
	 * @param constructors Constructors.
	 */
	new(CodeSnippetContext ctx, String typeName, List<MethodData> methods) {
		this.ctx = ctx
		this.methods = methods
	}

	override toString() {
		if ((methods == null) || (methods.size == 0)) {
			return ""
		}
		'''	
			«FOR method : methods.nullSafe»
				«new SrcMethod(ctx, method)»
				
			«ENDFOR»
		'''
	}

}
