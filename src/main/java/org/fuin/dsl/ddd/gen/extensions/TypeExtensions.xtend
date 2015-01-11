package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*

/**
 * Provides extension methods for Type.
 */
class TypeExtensions {

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

}
