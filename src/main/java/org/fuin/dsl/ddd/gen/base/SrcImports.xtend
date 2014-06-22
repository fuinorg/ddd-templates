package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.Collections
import java.util.List
import java.util.Set
import org.fuin.srcgen4j.core.emf.CodeSnippet

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

/**
 * Creates the import statements source code.
 */
class SrcImports implements CodeSnippet {

	val List<String> imports

	new(String currentPkg, Set<String> importSet) {
		imports = new ArrayList<String>()
		for (imp : importSet) {
			if (!javaLang(imp) && (imp.trim.length > 0) && !currentPkg.equals(imp.onlyPackage)) {
				imports.add(imp)
			}
		}
		Collections.sort(imports)
	}
	
	def boolean javaLang(String imp) {
		if (!imp.startsWith("java.lang.")) {
			return false
		}
		val p = imp.indexOf(".", 10)
		if (p == -1) {
			return true
		} 
		return false
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
