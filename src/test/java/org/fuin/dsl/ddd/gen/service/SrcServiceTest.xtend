package org.fuin.dsl.ddd.gen.service

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Service
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcServiceTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

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
			''')
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
				 *
				 * @throws AnyConstraintViolatedException The constraint was violated.
				 */
				public String find(@NotNull final Integer a) throws AnyConstraintViolatedException;
				
			}
			''')
		assertThat(ctx.imports).containsOnly("java.lang.Integer", "java.lang.String", "x.services.AnyConstraintViolatedException", "javax.validation.constraints.NotNull")

	}
	
	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/service.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
