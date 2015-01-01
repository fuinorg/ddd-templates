package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*

/**
 * Provides extension methods for Type.
 */
class TypeExtensions {

	/**
	 * Returns the doc text from the type.
	 * 
	 * @param type Type with doc text to read.
	 * 
	 * @return Type doc text.
	 */
	def static String doc(Type type) {
		if (type instanceof AbstractEntity) {
			return type.doc
		} else if (type instanceof AbstractVO) {
			return type.doc
		}
		return type.name;
	}

	/**
	 * Returns the last part of the name.
	 * 
	 * @param type Type.
	 * @param ctx Context.
	 * 
	 * @return Simple name (Name without package).
	 */
	def static String simpleName(Type type, CodeSnippetContext ctx) {
		val String name = ctx.getReference(type.uniqueName)
		val int p = name.lastIndexOf('.')
		if (p == -1) {
			return name
		}
		return name.substring(p + 1)
	}

	/**
	 * Returns the base type if available. External types as argument 
	 * will return the external type itself.
	 * 
	 * @param variable Type with base to return.
	 * 
	 * @return Base type or null.
	 */
	def static ExternalType base(Type type) {
		if (type instanceof AbstractVO) {
			return type.base
		} else if (type instanceof EnumObject) {
			return type.base
		} else if (type instanceof ExternalType) {
			return type
		}
		return null;
	}

	/**
	 * Returns the corresponding Java primitive type if one exists.
	 * 
	 * @param type Type 
	 * 
	 * @return Java primitive or original type name.
	 */
	def static String asJavaPrimitive(Type type) {
		var String name = type.name;
		switch name {
			case 'Byte': name = 'byte'
			case 'Short': name = 'short'
			case 'Integer': name = 'int'
			case 'Long': name = 'long'
			case 'Float': name = 'float'
			case 'Double': name = 'double'
			case 'Boolean': name = 'boolean'
			case 'Character': name = 'char'
		}
		return name;
	}

}
