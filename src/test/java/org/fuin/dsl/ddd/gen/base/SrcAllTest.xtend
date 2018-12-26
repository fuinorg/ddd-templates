package org.fuin.dsl.ddd.gen.base

import org.junit.Test

import static org.assertj.core.api.Assertions.*

class SrcAllTest {

	@Test
	def void test() {

		// PREPARE
		val copyright = '''	
			/**
			 * Copyright (C) 2013 Future Invent Informationsmanagement GmbH. All rights
			 * reserved. <http://www.fuin.org/>
			 */
		 '''
		val pkg = "org.fuin.dsl.ddd.gen"
		val imports = #{"java.lang.Integer", "static org.assertj.core.api.Assertions.assertThat"}
		val src = "public class Dummy {}"
		val testee = new SrcAll(copyright, pkg, imports, src)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''	
				/**
				 * Copyright (C) 2013 Future Invent Informationsmanagement GmbH. All rights
				 * reserved. <http://www.fuin.org/>
				 */
				package org.fuin.dsl.ddd.gen;
				
				import static org.assertj.core.api.Assertions.assertThat;
				
				public class Dummy {}
			'''.toString)

	}

}
