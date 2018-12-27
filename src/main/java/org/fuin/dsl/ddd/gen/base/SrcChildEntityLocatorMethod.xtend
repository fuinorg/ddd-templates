package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEntityExtensions.*

/**
 * Creates source code for a single child entity locator method.
 */
class SrcChildEntityLocatorMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val GenerateOptions options 
	val ReturnType returnType
	val List<String> annotations
	val List<Parameter> parameters
	val List<Exception> exceptions = null

	new(CodeSnippetContext ctx, GenerateOptions options, Entity entity) {
		this.ctx = ctx
		this.options = options
		this.returnType = DomainDrivenDesignDslFactory.eINSTANCE.createReturnType()
		this.returnType.setType(entity)
		this.annotations = #["@Override", "@ChildEntityLocator"]
		this.parameters = #[
			DomainDrivenDesignDslFactory.eINSTANCE.createParameter(entity.idTypeNullsafe, entity.idTypeNullsafe.name.toFirstLower, false)]

		ctx.requiresImport("org.fuin.ddd4j.ddd.ChildEntityLocator")
		ctx.requiresReference(entity.uniqueName)
		ctx.requiresReference(entity.idTypeNullsafe.uniqueName)
	}

	override toString() {
		'''«new SrcMethod(ctx, options,
			new MethodData(null, annotations,
				"protected final", false, returnType, "find" + returnType.type.name, parameters, exceptions))»'''
	}

}
