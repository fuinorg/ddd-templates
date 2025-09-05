package org.fuin.dsl.ddd.gen.base

import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.tests.CqrsDslInjectorProvider
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.cqrs.cqrsDsl.ValueObject
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.cqrs.extensions.CqrsDomainModelExtensions.*

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class SrcVarsDeclTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testCreate() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        refReg.putReference("a.b.String", "java.lang.String")
        refReg.putReference("a.b.Integer", "java.lang.Integer")
        refReg.putReference("a.b.Boolean", "java.lang.Boolean")
        val ctx = new SimpleCodeSnippetContext(refReg)

        val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
        val SrcVarsDecl testee = new SrcVarsDecl(ctx, "private", GenerateOptions.empty(), valueObject)

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo(
            '''
                @NotNull
                private String a;
                
                @NotNull
                private Integer b;
                
                @Nullable
                private Boolean c;
                
            '''.toString)
        assertThat(ctx.imports).containsOnly("java.lang.String", "java.lang.Integer", "java.lang.Boolean",
            "jakarta.validation.constraints.NotNull", "jakarta.annotation.Nullable")
    }

    def DomainModel createModel() {
        val DomainModel model = parser.parse(
            '''
                context a {
                    
                    namespace b {
                        
                        type String
                        type Integer
                        type Boolean
                
                        value-object MyValueObject {
                            String a
                            Integer b
                            nullable Boolean c
                        }
                
                    }
                
                }
            '''
        )
        validationTester.assertNoIssues(model)
        return model
    }

}
