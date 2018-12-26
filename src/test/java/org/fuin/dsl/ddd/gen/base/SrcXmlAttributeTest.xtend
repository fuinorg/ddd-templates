package org.fuin.dsl.ddd.gen.base

import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.assertj.core.api.Assertions.*
import static org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory.eINSTANCE

import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*

class SrcXmlAttributeTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val variable = eINSTANCE.createAttribute("AbcDefGhi")
		val SrcXmlAttribute testee = new SrcXmlAttribute(ctx, variable)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''@XmlAttribute(name = "abc-def-ghi")'''.toString)
		assertThat(ctx.imports).contains("javax.xml.bind.annotation.XmlAttribute")

	}

}
