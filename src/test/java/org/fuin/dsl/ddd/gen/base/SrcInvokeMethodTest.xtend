package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test

import static org.assertj.core.api.Assertions.*

class SrcInvokeMethodTest {

	@Test
	def void testEmpty() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val names = new ArrayList<String>()
		val testee = new SrcInvokeMethod(ctx, "super", names)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''super();'''.toString)

	}

	@Test
	def void testOne() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val names = new ArrayList<String>()
		names.add("a")
		val testee = new SrcInvokeMethod(ctx, "super", names)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''super(a);'''.toString)

	}

	@Test
	def void testMultiple() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		val names = new ArrayList<String>()
		names.add("a")
		names.add("b")
		names.add("c")
		val testee = new SrcInvokeMethod(ctx, "super", names)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''super(a, b, c);'''.toString)

	}

}
