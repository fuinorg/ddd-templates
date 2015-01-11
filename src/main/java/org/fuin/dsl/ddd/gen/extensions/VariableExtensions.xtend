package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.TypeExtensions.*

/**
 * Provides extension methods for Variable.
 */
class VariableExtensions {

	/**
	 * Returns the simple type name. If there is a multiplicity <code>List</code> 
	 * with the type as generic argument will be returned.
	 * 
	 * @param variable Variable.
	 * @param ctx Context.
	 * 
	 * @return <code>Type name</code> or <code>List&lt;type name&gt;</code>
	 */
	def static String type(Variable variable, CodeSnippetContext ctx) {
		var String name = variable.type.simpleName(ctx);
		if (variable.multiplicity == null) {
			return name;
		}
		return "List<" + name + ">";
	}

}
