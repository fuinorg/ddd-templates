package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
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
		val ValueObject valueObject = model.contexts.get(0).namespaces.get(0).elements.get(0) as ValueObject
		val Variable variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable()
		variable.setName(varName)
		variable.setType(valueObject)
		return new SrcInvokeGetter(codeSnippetContext, objName, variable)
	}

}
