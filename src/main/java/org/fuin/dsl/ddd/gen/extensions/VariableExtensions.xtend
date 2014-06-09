package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.TypeExtensions.*

/**
 * Provides extension methods for Variable.
 */
class VariableExtensions {

	/**
	 * Returns the doc text from the variable or the type.
	 * 
	 * @param variable Variable with doc text to read.
	 * 
	 * @return Variable or type doc.
	 */
	def static String superDoc(Variable variable) {
		if (variable.doc == null) {
			variable.type.doc.text
		} else {
			return variable.doc.text
		}
	}

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
