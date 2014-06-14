package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.fest.assertions.Assertions.*

class SrcXmlElementTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable
		variable.setName("AbcDefGhi")
		val SrcXmlElement testee = new SrcXmlElement(ctx, variable)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''@XmlElement(name = "abc-def-ghi")''')
		assertThat(ctx.imports).contains("javax.xml.bind.annotation.XmlElement")

	}

}
