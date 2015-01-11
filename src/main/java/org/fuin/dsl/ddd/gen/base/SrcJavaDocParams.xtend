package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.objects4j.common.Nullable

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*

/**
 * Creates the source code for a JavaDoc <code>@param</code> lines.
 */
class SrcJavaDocParams {

	val List<Variable> variables

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param variables List of variables.
	 */
	new(@Nullable List<Variable> variables) {
		this.variables = variables
	}

	override toString() {
		if (variables.nullSafe.size == 0) {
			''''''
		} else {
			'''
				«sp»*
				«FOR v : variables»
					«new SrcJavaDocParam(v.name, v.superDoc)»
				«ENDFOR»
			'''
		}
	}

	def sp() {
		" "
	}

}
