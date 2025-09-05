package org.fuin.dsl.ddd.gen.base

import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.jupiter.api.Test

import static org.assertj.core.api.Assertions.*
import static org.fuin.dsl.cqrs.cqrsDsl.CqrsDslFactory.eINSTANCE

import static extension org.fuin.dsl.cqrs.extensions.CqrsDslFactoryExtensions.*

class SrcParamAssignmentTest {

    @Test
    def void testCreate() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        val codeSnippetContext = new SimpleCodeSnippetContext(refReg)
        val SrcParamAssignment testee = new SrcParamAssignment(codeSnippetContext, eINSTANCE.createParameter("a"))

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo("this.a = a;")
        assertThat(codeSnippetContext.imports).empty

    }

}
