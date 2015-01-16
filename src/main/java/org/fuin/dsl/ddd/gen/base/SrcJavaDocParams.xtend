package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.objects4j.common.Nullable

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*

/**
 * Creates the source code for a JavaDoc <code>@param</code> lines.
 */
class SrcJavaDocParams {

	val List<Parameter> parameters

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param parameters List of parameters.
	 */
	new(@Nullable List<Parameter> parameters) {
		this.parameters = parameters
	}

	override toString() {
		if (parameters.nullSafe.size == 0) {
			''''''
		} else {
			'''
				«sp»*
				«FOR v : parameters»
					«new SrcJavaDocParam(v.name, v.superDoc)»
				«ENDFOR»
			'''
		}
	}

	def sp() {
		" "
	}

}
