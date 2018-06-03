package org.fuin.dsl.ddd.gen.base

import javax.validation.constraints.NotNull
import org.fuin.dsl.ddd.domainDrivenDesignDsl.TypeMetaInfo
import javax.annotation.Nullable
import org.fuin.objects4j.ui.Label
import org.fuin.objects4j.ui.Prompt
import org.fuin.objects4j.ui.ShortLabel
import org.fuin.objects4j.ui.Tooltip
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates the source code for meta annotations.
 */
class SrcMetaAnnotations implements CodeSnippet {

	val TypeMetaInfo meta

	val String bundle

	val String key

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param meta Meta information
	 * @param bundle Bundle
	 * @param key Key
	 */
	new(@NotNull CodeSnippetContext ctx, @Nullable TypeMetaInfo meta, @Nullable String bundle, @NotNull String key) {
		this.meta = meta
		this.bundle = bundle
		this.key = key
		if (meta !== null) {
			if (meta.slabel !== null) {
				ctx.requiresImport(ShortLabel.name)
			}
			if (meta.label !== null) {
				ctx.requiresImport(Label.name)
			}
			if (meta.tooltip !== null) {
				ctx.requiresImport(Tooltip.name)
			}
			if (meta.prompt !== null) {
				ctx.requiresImport(Prompt.name)
			}
		}
	}

	override toString() {
		if (meta === null) {
			''''''
		} else {
			'''
				«IF meta.slabel !== null»
					@ShortLabel(«IF bundle !== null»bundle = "«bundle»", «ENDIF»key = "«key».slabel", value = "«meta.slabel»")
				«ENDIF»
				«IF meta.label !== null»
					@Label(«IF bundle !== null»bundle = "«bundle»", «ENDIF»key = "«key».label", value = "«meta.label»")
				«ENDIF»
				«IF meta.tooltip !== null»
					@Tooltip(«IF bundle !== null»bundle = "«bundle»", «ENDIF»key = "«key».tooltip", value = "«meta.tooltip»")
				«ENDIF»
				«IF meta.prompt !== null»
					@Prompt(«IF bundle !== null»bundle = "«bundle»", «ENDIF»key = "«key».prompt", value = "«meta.prompt»")
				«ENDIF»
			'''
		}
	}

}
