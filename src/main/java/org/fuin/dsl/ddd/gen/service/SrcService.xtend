package org.fuin.dsl.ddd.gen.service

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Service
import org.fuin.dsl.ddd.gen.base.SrcJavaDocMethod
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcMethodSignature
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Creates source code for a service.
 */
class SrcService implements CodeSnippet {

	val CodeSnippetContext ctx
	val Service service

	new(CodeSnippetContext ctx, Service service) {
		this.ctx = ctx
		this.service = service
	}

	override toString() {
		'''	
		«new SrcJavaDocType(service)»
		public interface «service.name» {
			
			«FOR method : service.methods.nullSafe»
				«new SrcJavaDocMethod(ctx, method).toString»
				«new SrcMethodSignature(ctx, "public", false, method).toString»;
				
			«ENDFOR»
		}
		'''
	}

}
