package org.fuin.dsl.ddd.gen.base

import org.junit.Test

import static org.fest.assertions.Assertions.*
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory

class SrcJavaDocTest {

	@Test
	def void test() {

		// PREPARE
		val vo = DomainDrivenDesignDslFactory.eINSTANCE.createValueObject
		vo.setDoc(
			'''
				/**
				 * Bla.
				 */
			'''
		)
		val testee = new SrcJavaDoc(vo)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Bla.
				 */
			''')

	}

}
