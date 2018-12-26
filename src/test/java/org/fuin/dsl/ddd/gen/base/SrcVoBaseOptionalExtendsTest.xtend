package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.assertj.core.api.Assertions.*

class SrcVoBaseOptionalExtendsTest {
	
	@Test
	def void testString() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType
		base.setName("String")
		
		val testee = new SrcVoBaseOptionalExtends(ctx, base)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("extends AbstractStringValueObject ")
		assertThat(ctx.imports).contains("org.fuin.objects4j.vo.AbstractStringValueObject")

	}

	@Test
	def void testUUID() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType
		base.setName("UUID")
		
		val testee = new SrcVoBaseOptionalExtends(ctx, base)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("extends AbstractUuidValueObject ")
		assertThat(ctx.imports).contains("org.fuin.objects4j.vo.AbstractUuidValueObject")

	}

	@Test
	def void testInteger() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType
		base.setName("Integer")
		
		val testee = new SrcVoBaseOptionalExtends(ctx, base)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("extends AbstractIntegerValueObject ")
		assertThat(ctx.imports).contains("org.fuin.objects4j.vo.AbstractIntegerValueObject")

	}

	@Test
	def void testLong() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType
		base.setName("Long")
		
		val testee = new SrcVoBaseOptionalExtends(ctx, base)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("extends AbstractLongValueObject ")
		assertThat(ctx.imports).contains("org.fuin.objects4j.vo.AbstractLongValueObject")

	}
	
}