package org.fuin.dsl.ddd.gen.base

import java.util.Set
import org.fuin.srcgen4j.core.emf.CodeSnippet

/**
 * Creates source code for copyright, package, imports and the class.
 */
class SrcAll implements CodeSnippet {

	val String copyrightHeader
	val String pkg 
	val Set<String> imports
	val String src

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param copyrightHeader Copyright header. 
	 * @param pkg Package.
	 * @param imports Imports.
	 * @param src Class source code. 
	 */
	new(String copyrightHeader, String pkg, Set<String> imports, String src) {
		this.copyrightHeader = copyrightHeader
		this.pkg = pkg
		this.imports = imports
		this.src = src
	}

	override toString() {
		'''	
			«copyrightHeader» 
			package «pkg»;
			
			«new SrcImports(pkg, imports)»
			
			«src»
		'''
	}

}
