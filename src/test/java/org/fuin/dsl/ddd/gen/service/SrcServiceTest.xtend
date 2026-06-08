package org.fuin.dsl.ddd.gen.service

import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.tests.CqrsDslInjectorProvider
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.cqrs.cqrsDsl.Service
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.cqrs.extensions.CqrsDomainModelExtensions.*

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class SrcServiceTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testServiceA() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        val ctx = new SimpleCodeSnippetContext(refReg)
        val Service service = model.find(typeof(Service), "ServiceA")
        val SrcService testee = new SrcService(ctx, service)

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo(
            '''
                /**
                 * Service A - No methods.
                 */
                public interface ServiceA {
                    
                }
            '''.toString)
        assertThat(ctx.imports).isEmpty

    }
    
    @Test
    def void testServiceB() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        refReg.putReference("x.types.Integer", "java.lang.Integer")
        refReg.putReference("x.types.String", "java.lang.String")
        
        val ctx = new SimpleCodeSnippetContext(refReg)
        val Service service = model.find(typeof(Service), "ServiceB")
        val SrcService testee = new SrcService(ctx, service)

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo(
            '''
            /**
             * Service B - Single method.
             */
            public interface ServiceB {
                
                /**
                 * Finds something.
                 *
                 * @param a Key.
                 *
                 * @return Value.
                 */
                public String find(@NotNull final Integer a);
                
            }
            '''.toString)
        assertThat(ctx.imports).containsOnly("java.lang.Integer", "java.lang.String", "jakarta.validation.constraints.NotNull")

    }
    
    private def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/service.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
