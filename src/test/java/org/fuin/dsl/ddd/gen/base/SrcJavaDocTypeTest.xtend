package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.junit.Test

import static org.assertj.core.api.Assertions.*

class SrcJavaDocTypeTest {

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
		val testee = new SrcJavaDocType(vo)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Bla.
				 */
			'''.toString)

	}

}
