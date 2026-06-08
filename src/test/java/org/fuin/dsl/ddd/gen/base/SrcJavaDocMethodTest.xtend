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
class SrcJavaDocMethodTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testCreate() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        val ctx = new SimpleCodeSnippetContext(refReg)

        val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
        val method = valueObject.methods.get(0)
        val SrcJavaDocMethod testee = new SrcJavaDocMethod(ctx, method)

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo(
            '''
                /**
                 * This method does cool things.
                 *
                 * @param a Abc.
                 * @param b Def.
                 */
            '''.toString)
        assertThat(ctx.imports).isEmpty()

    }

    def DomainModel createModel() {
        val DomainModel model = parser.parse(
            '''
                context a {
                    
                    namespace b {
                        
                        type String
                        type Integer
                
                        value-object MyValueObject {
                
                            /**
                             * This method does cool things.
                             */
                            method whatever {
                                
                                /** Abc. */
                                String a
                                
                                /** Def. */
                                Integer b
                                
                            }
                
                        }
                
                
                
                    }
                
                }
            ''')
            validationTester.assertNoIssues(model)
            return model        
    }

}
