package org.fuin.dsl.ddd.gen.base

import org.junit.jupiter.api.Test

import static org.assertj.core.api.Assertions.*
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry

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
        val CodeReferenceRegistry reg = new SimpleCodeReferenceRegistry()
        val CodeSnippetContext ctx = new SimpleCodeSnippetContext(reg)
        val pkg = "org.fuin.dsl.ddd.gen"
        val imports = #{"java.lang.Integer", "static org.assertj.core.api.Assertions.assertThat"}
        val src = "public class Dummy {}"
        val testee = new SrcAll(ctx, copyright, pkg, imports, src)

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
