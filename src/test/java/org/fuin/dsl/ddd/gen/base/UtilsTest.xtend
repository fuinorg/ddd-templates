package org.fuin.dsl.ddd.gen.base

import org.junit.Test

import static org.assertj.core.api.Assertions.*

class UtilsTest {
	
	@Test
	def void testSeparated() {
		
		// TEST & VERIFY
		assertThat(Utils.separated(",", null)).isEqualTo("")
		assertThat(Utils.separated(",")).isEqualTo("")
		assertThat(Utils.separated(",", #[])).isEqualTo("")
		assertThat(Utils.separated(",", #["a"])).isEqualTo("a")
		assertThat(Utils.separated(",", #["a", "b"])).isEqualTo("a,b")
		assertThat(Utils.separated("-", #["a", "b", "c"])).isEqualTo("a-b-c")
		
	}
	
	
}