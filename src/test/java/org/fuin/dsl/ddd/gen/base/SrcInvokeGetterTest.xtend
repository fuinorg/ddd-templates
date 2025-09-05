package org.fuin.dsl.ddd.gen.base

import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.tests.CqrsDslInjectorProvider
import org.fuin.dsl.cqrs.cqrsDsl.CqrsDslFactory
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.cqrs.cqrsDsl.ValueObject
import org.fuin.dsl.cqrs.cqrsDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.assertj.core.api.Assertions.*

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class SrcInvokeGetterTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testNullObjName() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        val codeSnippetContext = new SimpleCodeSnippetContext(refReg);
        val SrcInvokeGetter testee = createTestee(codeSnippetContext, "ctx", "ns", "MyValueObject", null, "a")

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo('''getA()'''.toString)
        assertThat(codeSnippetContext.imports).empty

    }

    @Test
    def void testWithObjName() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        val codeSnippetContext = new SimpleCodeSnippetContext(refReg);
        val SrcInvokeGetter testee = createTestee(codeSnippetContext, "ctx", "ns", "MyValueObject", "x", "a")

        // TEST
        val result = testee.toString

        // VERIFY
        assertThat(result).isEqualTo('''x.getA()'''.toString)
        assertThat(codeSnippetContext.imports).empty

    }

    private def SrcInvokeGetter createTestee(CodeSnippetContext codeSnippetContext, String ctx, String ns, String type,
        String objName, String varName) {
        val model = parser.parse(
            '''
                context «ctx» {
                    namespace «ns» {
                        value-object «type» {
                        }
                    }     
                }
            '''
        )
        validationTester.assertNoIssues(model)
        val ValueObject valueObject = model.contexts.get(0).namespaces.get(0).elements.get(0) as ValueObject
        val Variable variable = CqrsDslFactory.eINSTANCE.createVariable()
        variable.setName(varName)
        variable.setType(valueObject)
        return new SrcInvokeGetter(codeSnippetContext, objName, variable)
    }

}
