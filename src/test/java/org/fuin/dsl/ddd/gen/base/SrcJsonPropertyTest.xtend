package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.assertj.core.api.Assertions.*

class SrcJsonPropertyTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable
		variable.setName("AbcDefGhi")
		val SrcJsonProperty testee = new SrcJsonProperty(ctx, variable)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''@JsonbProperty("abc-def-ghi")'''.toString)
		assertThat(ctx.imports).contains("javax.json.bind.annotation.JsonbProperty")

	}

}
