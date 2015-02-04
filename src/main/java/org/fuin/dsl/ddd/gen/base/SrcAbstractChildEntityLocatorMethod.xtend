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
 * Creates source code for a single abstract child entity locator method.
 */
class SrcAbstractChildEntityLocatorMethod implements CodeSnippet {

	val CodeSnippetContext ctx
	val ReturnType returnType
	val List<String> annotations = null
	val List<Parameter> parameters
	val List<Exception> exceptions = null

	new(CodeSnippetContext ctx, Entity entity) {
		this.ctx = ctx
		this.returnType = DomainDrivenDesignDslFactory.eINSTANCE.createReturnType()
		this.returnType.setDoc("Child entity or NULL if no entity with the given identifier was found.")
		this.returnType.setType(entity)
		val parameter = DomainDrivenDesignDslFactory.eINSTANCE.createParameter(
			"Unique identifier of the child entity to find.", entity.idTypeNullsafe, entity.idTypeNullsafe.name.toFirstLower, false)
		this.parameters = #[parameter]

		ctx.requiresReference(entity.uniqueName)
		ctx.requiresReference(entity.idTypeNullsafe.uniqueName)
	}

	override toString() {
		'''«new SrcMethod(ctx,
			new MethodData("Locates a child entity of type " + returnType.type.name + ".", annotations, "protected",
				true, returnType, "find" + returnType.type.name, parameters, exceptions))»'''
	}

}
