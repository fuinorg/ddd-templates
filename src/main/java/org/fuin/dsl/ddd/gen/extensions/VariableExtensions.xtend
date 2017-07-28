package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
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
		if (variable.generics === null) {
			return name;
		}
		val StringBuilder sb = new StringBuilder()
		for (arg : variable.generics.args) {
			if (sb.length > 0) {
				sb.append(", ");				
			}
			sb.append(arg.simpleName(ctx));
		}
		return name + "<" + sb + ">";
	}
	
	/**
	 * Adds the required references for a variable to the context.
	 * 
	 * @param variable Variable to add the required references for.
	 * @param ctx Context to add the requirements to.
	 */
	def static void addRequiredReferences(Variable variable, CodeSnippetContext ctx) {
		if (variable.generics !== null) {
			for (arg : variable.generics.args) {
				ctx.requiresReference(arg.uniqueName)
			}
		}
		ctx.requiresReference(variable.type.uniqueName)
	}
	

}
