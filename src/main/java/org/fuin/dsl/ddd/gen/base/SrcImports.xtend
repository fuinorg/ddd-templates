package org.fuin.dsl.ddd.gen.base

import java.util.Set
import org.fuin.srcgen4j.core.emf.CodeSnippet

/**
 * Creates the import statements source code.
 */
class SrcImports implements CodeSnippet {

	val Set<String> imports

	new(Set<String> imports) {
		this.imports = imports
	}

	override toString() {
		if ((imports == null) || (imports.length == 0)) {
			return "";
		}
		'''
			«FOR imp : imports»
				import «imp»;
			«ENDFOR»
		'''
	}

}
