package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions.*

/**
 * Creates source code for value object methods that have an external 'base' type.
 */
class SrcVoBaseMethods implements CodeSnippet {

	val CodeSnippetContext ctx;

	val AbstractVO vo;
	
	val String baseName

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param vo Value object.
	 */
	new(CodeSnippetContext ctx, AbstractVO vo) {
		this.ctx = ctx
		if (vo == null) {
			throw new IllegalArgumentException("vo cannot be null")
		}
		this.vo = vo
		this.baseName = vo.baseTypeName
	}

	override toString() {
		if (baseName == null) {
			return ""
		}
		if (baseName.equals("String")) {
			return new SrcVoBaseMethodsString(ctx, vo).toString()
		}
		if (baseName.equals("UUID")) {
			return new SrcVoBaseMethodsUUID(ctx, vo).toString()
		}
		if (baseName.equals("Integer") || baseName.equals("Long")) {
			return new SrcVoBaseMethodsNumber(ctx, vo).toString()
		}
		return ""
	}

}
