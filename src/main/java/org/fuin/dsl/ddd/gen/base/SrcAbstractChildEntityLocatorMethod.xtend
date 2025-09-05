package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.CqrsDslFactory
import org.fuin.dsl.cqrs.cqrsDsl.Entity
import org.fuin.dsl.cqrs.cqrsDsl.Exception
import org.fuin.dsl.cqrs.cqrsDsl.Parameter
import org.fuin.dsl.cqrs.cqrsDsl.ReturnType
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsDslFactoryExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEntityExtensions.*

/**
 * Creates source code for a single abstract child entity locator method.
 */
class SrcAbstractChildEntityLocatorMethod implements CodeSnippet {

    val CodeSnippetContext ctx
    val GenerateOptions options
    val ReturnType returnType
    val List<String> annotations = null
    val List<Parameter> parameters
    val List<Exception> exceptions = null

    new(CodeSnippetContext ctx, GenerateOptions options, Entity entity) {
        this.ctx = ctx
        this.options = options
        this.returnType = CqrsDslFactory.eINSTANCE.createReturnType()
        this.returnType.setDoc("Child entity or NULL if no entity with the given identifier was found.")
        this.returnType.setType(entity)
        val parameter = CqrsDslFactory.eINSTANCE.createParameter(
            "Unique identifier of the child entity to find.", entity.idTypeNullsafe, entity.idTypeNullsafe.name.toFirstLower, false)
        this.parameters = #[parameter]

        ctx.requiresReference(entity.uniqueName)
        ctx.requiresReference(entity.idTypeNullsafe.uniqueName)
    }

    override toString() {
        '''«new SrcMethod(ctx, options,
            new MethodData("Locates a child entity of type " + returnType.type.name + ".", annotations, "protected",
                true, returnType, "find" + returnType.type.name, parameters, exceptions))»'''
    }

}
