package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractVOExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.TypeExtensions.*

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
		'''
		«IF vo.baseType != null»
		@Override
		public final «vo.baseType.simpleName(ctx)» asBaseType() {
			«IF vo.variables.nullSafe.size == 1»
			return get«vo.variables.first.name.toFirstUpper»();
			«ELSE»
			// TODO Implement!
			return null;
			«ENDIF»
		}
		
		«ENDIF»
		«IF "String".equals(baseName)»
			«new SrcVoBaseMethodsString(ctx, vo)»
		«ELSEIF "UUID".equals(baseName)»
			«new SrcVoBaseMethodsUUID(ctx, vo)»
		«ELSEIF "Integer".equals(baseName) || "Long".equals(baseName)»
			«new SrcVoBaseMethodsNumber(ctx, vo)»
		«ENDIF»
		'''
	}

}
