package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.fest.assertions.Assertions.*

class SrcParamAssignmentTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val codeSnippetContext = new SimpleCodeSnippetContext(refReg)
		val variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable
		variable.setName("a")
		val SrcParamAssignment testee = new SrcParamAssignment(codeSnippetContext, variable)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("this.a = a;")
		assertThat(codeSnippetContext.imports).empty

	}

}
