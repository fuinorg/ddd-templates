package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.DomainDrivenDesignDslFactoryExtensions.*

/**
 * Creates source code for a single abstract child entity locator method.
 */
class SrcAbstractChildEntityLocatorMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val Entity entity
	val List<String> annotations = null
	val List<Variable> variables
	val List<Exception> exceptions = null

	new(CodeSnippetContext ctx, Entity entity) {
		this.ctx = ctx
		this.entity = entity
		val variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable("Unique identifier of the child entity to find.", entity.idType, entity.idType.name.toFirstLower, false)
		this.variables = #[variable]

		ctx.requiresReference(entity.uniqueName)
		ctx.requiresReference(entity.idType.uniqueName)
	}

	override toString() {
		'''«new SrcMethod(ctx,
			new MethodData("Locates a child entity of type " + entity.name + ".", annotations, "protected", true,
				entity, "find" + entity.name, variables, exceptions))»'''
	}

}