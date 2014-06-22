package org.fuin.dsl.ddd.gen.base

import org.junit.Test

import static org.fest.assertions.Assertions.*

class SrcImportsTest {

	@Test
	def void test() {

		// PREPARE
		val imports = #{"a.b.C", "c.d.e.F", "java.lang.String", "java.lang.Integer", "java.lang.annotation.Annotation",
			"java.lang.reflect.*"
		}
		val testee = new SrcImports("a.b", imports)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				import c.d.e.F;
				import java.lang.annotation.Annotation;
				import java.lang.reflect.*;
			''')

	}

}
