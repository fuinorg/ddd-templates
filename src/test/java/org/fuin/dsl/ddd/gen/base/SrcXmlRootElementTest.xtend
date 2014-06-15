package org.fuin.dsl.ddd.gen.base

import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.fest.assertions.Assertions.*

class SrcXmlRootElementTest {

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val SrcXmlRootElement testee = new SrcXmlRootElement(ctx, "AbcDefGhi")

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''@XmlRootElement(name = "abc-def-ghi")''')
		assertThat(ctx.imports).contains("javax.xml.bind.annotation.XmlRootElement")

	}

}
