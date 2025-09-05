package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.Parameter
import jakarta.annotation.Nullable

import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsVariableExtensions.*

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
