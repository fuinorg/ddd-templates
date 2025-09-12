package org.fuin.dsl.ddd.gen.base

import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.Variable

/**
 * Creates source code for one or more builder setters.
 */
class SrcBuilderSetters implements CodeSnippet {
	
    val CodeSnippetContext ctx
    val GenerateOptions options
    val List<? extends Variable> attributes

    new(CodeSnippetContext ctx, GenerateOptions options, List<? extends Variable> attributes) {
        this.ctx = ctx        
        this.options = options
        this.attributes = attributes
    }

    override toString() {
        '''    
            «FOR attribute : attributes»
                «new SrcBuilderSetter(ctx, options, attribute)»
                
            «ENDFOR»
        '''
    }
	
}