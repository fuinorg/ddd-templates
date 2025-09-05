package org.fuin.dsl.ddd.gen.service

import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.Service
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*

/**
 * Creates source code for a service.
 */
class SrcServices implements CodeSnippet {

    val CodeSnippetContext ctx
    val List<Service> services

    new(CodeSnippetContext ctx, List<Service> services) {
        this.ctx = ctx
        this.services = services
    }

    override toString() {
        '''    
        «FOR service : services.nullSafe»
            «new SrcService(ctx, service).toString»
            
        «ENDFOR»
        '''
    }

}
