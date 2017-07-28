package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcInvokeGetterTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testNullObjName() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val codeSnippetContext = new SimpleCodeSnippetContext(refReg);
		val SrcInvokeGetter testee = createTestee(codeSnippetContext, "ctx", "ns", "MyValueObject", null, "a")

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''getA()''')
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
		assertThat(result).isEqualTo('''x.getA()''')
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
		val Variable variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable()
		variable.setName(varName)
		variable.setType(valueObject)
		return new SrcInvokeGetter(codeSnippetContext, objName, variable)
	}

}
