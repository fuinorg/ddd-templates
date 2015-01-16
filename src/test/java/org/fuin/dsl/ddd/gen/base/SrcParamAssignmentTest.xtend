package org.fuin.dsl.ddd.gen.base

import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.fest.assertions.Assertions.*
import static org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory.eINSTANCE

import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*

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
