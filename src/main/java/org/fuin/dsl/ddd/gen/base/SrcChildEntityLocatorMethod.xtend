package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*


/**
 * Creates source code for a single child entity locator method.
 */
class SrcChildEntityLocatorMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val ReturnType returnType
	val List<String> annotations
	val List<Variable> variables
	val List<Exception> exceptions = null

	new(CodeSnippetContext ctx, AbstractEntity entity) {
		this.ctx = ctx
		this.returnType = DomainDrivenDesignDslFactory.eINSTANCE.createReturnType()
		this.returnType.setType(entity)
		this.annotations = #["@Override", "@ChildEntityLocator"]
		this.variables = #[
			DomainDrivenDesignDslFactory.eINSTANCE.createVariable(entity.idType, entity.idType.name.toFirstLower, false)]

		ctx.requiresImport("org.fuin.ddd4j.ddd.ChildEntityLocator")
		ctx.requiresReference(entity.uniqueName)
		ctx.requiresReference(entity.idType.uniqueName)
	}

	override toString() {
		'''«new SrcMethod(ctx,
			new MethodData(null, annotations,
				"protected final", false, returnType, "find" + returnType.type.name, variables, exceptions))»'''
	}

}
