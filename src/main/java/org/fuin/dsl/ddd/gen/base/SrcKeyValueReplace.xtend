package org.fuin.dsl.ddd.gen.base

import java.util.List
import javax.validation.constraints.NotNull
import javax.annotation.Nullable
import org.fuin.objects4j.vo.KeyValue
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Creates source code for a {@link KeyValue#replace(String, KeyValue...)}.
 * If the list of variable names is empty, the message will be returned without replacing code.
 */
class SrcKeyValueReplace implements CodeSnippet {

	val CodeSnippetContext ctx
	val String message
	val List<String> variables

	new(@NotNull CodeSnippetContext ctx, @NotNull String message, @Nullable List<String> variables) {
		this.ctx = ctx
		this.message = message
		this.variables = variables

		if (variables.nullSafe.size > 0) {
			ctx.requiresImport(KeyValue.name)
		}
	}

	override toString() {
		if (variables.nullSafe.size == 0) {
			'''"«message»"'''
		} else {
			'''KeyValue.replace("«message»", «FOR name : variables SEPARATOR ','» new KeyValue("«name»", «name»)«ENDFOR»)'''
		}
	}

}
