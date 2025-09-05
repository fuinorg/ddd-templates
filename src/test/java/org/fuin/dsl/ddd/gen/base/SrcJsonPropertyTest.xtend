package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.cqrs.cqrsDsl.CqrsDslFactory
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.jupiter.api.Test

import static org.assertj.core.api.Assertions.*

class SrcJsonPropertyTest {

    @Test
    def void testCreate() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        val ctx = new SimpleCodeSnippetContext(refReg)
        val variable = CqrsDslFactory.eINSTANCE.createVariable
        variable.setName("AbcDefGhi")
        val SrcJsonProperty testee = new SrcJsonProperty(ctx, variable)

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo('''@JsonbProperty("abc-def-ghi")'''.toString)
        assertThat(ctx.imports).contains("jakarta.json.bind.annotation.JsonbProperty")

    }

}
