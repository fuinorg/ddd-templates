package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.cqrs.cqrsDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*

/**
 * Creates source code for a JAXB element annotation.
 */
class SrcXmlElement implements CodeSnippet {

    val Variable variable

    new(CodeSnippetContext ctx, Variable variable) {
        this.variable = variable

        ctx.requiresImport("jakarta.xml.bind.annotation.XmlElement")
    }

    override toString() {
        '''@XmlElement(name = "«variable.name.toXmlName»")'''
    }

}
