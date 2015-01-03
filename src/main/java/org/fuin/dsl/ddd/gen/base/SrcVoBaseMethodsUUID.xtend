package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions.*

/**
 * Creates source code for value objects that have an external 'base' of type 'UUID'.
 */
class SrcVoBaseMethodsUUID implements CodeSnippet {

	val CodeSnippetContext ctx;

	val String typeName;

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
		if (vo.baseType == null) {
			throw new IllegalArgumentException("vo.base cannot be null")
		}
		this.typeName = vo.name
		ctx.requiresReference(vo.uniqueName)
		ctx.requiresImport("java.util.UUID")
	}

	override toString() {
		'''	
			/**
			 * Returns the information if a given string can be converted into
			 * an instance of «typeName». A <code>null</code> value returns <code>true</code>.
			 * 
			 * @param value
			 *            Value to check.
			 * 
			 * @return TRUE if it's a valid string, else FALSE.
			 */
			public static boolean isValid(final String value) {
				return UUIDStrValidator.isValid(value);
			}
			
			/**
			 * Parses a given string and returns a new instance of «typeName».
			 * 
			 * @param value
			 *            Value to convert. A <code>null</code> value returns
			 *            <code>null</code>.
			 * 
			 * @return Converted value.
			 */
			public static «typeName» valueOf(final String value) {
				if (value == null) {
					return null;
				}
				return new «typeName»(UUID.fromString(value));
			}
			
		'''
	}

}
