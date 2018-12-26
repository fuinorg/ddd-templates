package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Parameter
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.assertj.core.api.Assertions.*
import static org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory.eINSTANCE

import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*

class SrcParamsAssignmentTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val codeSnippetContext = new SimpleCodeSnippetContext(refReg)
		val params = new ArrayList<Parameter>()
		params.add(eINSTANCE.createParameter("a"))
		params.add(eINSTANCE.createParameter("b"))
		params.add(eINSTANCE.createParameter("c", true))

		val SrcParamsAssignment testee = new SrcParamsAssignment(codeSnippetContext, params)

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
			'''.toString
		)
		assertThat(codeSnippetContext.imports).containsOnly("org.fuin.objects4j.common.Contract")

	}

}
