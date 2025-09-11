package org.fuin.dsl.ddd.gen.base

import org.junit.jupiter.api.Test

import static org.assertj.core.api.Assertions.*
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

class SrcImportsTest {

    @Test
    def void test() {

        // PREPARE
        val imports = #{"a.b.C", "c.d.e.F", "java.lang.String", "java.lang.Integer", "java.lang.annotation.Annotation",
            "java.lang.reflect.*"
        }
        val CodeReferenceRegistry reg = new SimpleCodeReferenceRegistry()
        val CodeSnippetContext ctx = new SimpleCodeSnippetContext(reg)
        val testee = new SrcImports(ctx, "a.b", imports)

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo(
            '''
                import c.d.e.F;
                import java.lang.annotation.Annotation;
                import java.lang.reflect.*;
            '''.toString)

    }

}
