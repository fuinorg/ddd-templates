package org.fuin.dsl.ddd.gen.base

import java.util.Set
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for copyright, package, imports and the class.
 */
class SrcAll implements CodeSnippet {

	val CodeSnippetContext ctx
    val String copyrightHeader
    val String pkg 
    val Set<String> imports
    val String src

    /**
     * Constructor with all mandatory data.
     * 
     * @param ctx Context
     * @param copyrightHeader Copyright header. 
     * @param pkg Package.
     * @param imports Imports.
     * @param src Class source code. 
     */
    new(CodeSnippetContext ctx, String copyrightHeader, String pkg, Set<String> imports, String src) {
    	this.ctx = ctx
        this.copyrightHeader = copyrightHeader
        this.pkg = pkg
        this.imports = imports
        this.src = src
    }

    override toString() {
        '''    
            «copyrightHeader» 
            package «pkg»;
            
            «new SrcImports(ctx, pkg, imports)»
            
            «src»
        '''
    }

}
