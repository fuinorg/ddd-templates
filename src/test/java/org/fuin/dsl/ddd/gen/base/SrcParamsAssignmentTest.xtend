package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*

class SrcParamsAssignmentTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val codeSnippetContext = new SimpleCodeSnippetContext(refReg)
		val vars = new ArrayList<Variable>()
		vars.add(DomainDrivenDesignDslFactory.eINSTANCE.createVariable("a"))
		vars.add(DomainDrivenDesignDslFactory.eINSTANCE.createVariable("b"))
		vars.add(DomainDrivenDesignDslFactory.eINSTANCE.createVariable("c", true))

		val SrcParamsAssignment testee = new SrcParamsAssignment(codeSnippetContext, vars)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				Contract.requireArgNotNull("a", a);
				Contract.requireArgNotNull("b", b);
				
				this.a = a;
				this.b = b;
				this.c = c;
			'''
		)
		assertThat(codeSnippetContext.imports).containsOnly("org.fuin.objects4j.common.Contract")

	}

}
