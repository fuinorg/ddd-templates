package org.fuin.dsl.ddd.gen.base

import java.util.List
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcGettersTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		refReg.putReference("ctx.types.Locale", "java.util.Locale")
		val ctx = new SimpleCodeSnippetContext(refReg);
		val SrcGetters testee = createTestee(ctx)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Returns: Human readable name.
				 *
				 * @return Current value.
				 */
				@NotNull
				public String getName() {
					return name;
				}
				
				/**
				 * Returns: Language the name is in.
				 *
				 * @return Current value.
				 */
				@Nullable
				public Locale getLocale() {
					return locale;
				}
				
			'''.toString)
		assertThat(ctx.imports).containsOnly("java.lang.String", "java.util.Locale",
			"javax.validation.constraints.NotNull", "javax.annotation.Nullable")

	}

	private def SrcGetters createTestee(CodeSnippetContext codeSnippetContext) {
		val model = parser.parse(
			'''
				context ctx {
				
					namespace a.b {
						
						import ctx.types.*
						
						value-object MyValueObject {
							
							/** Human readable name. */
							String name
							
							/** Language the name is in. */
							nullable Locale locale
							
						}
						
					}
				
					namespace types {
						type String
						type Locale
					}
					
				}
			'''
		)
		validationTester.assertNoIssues(model)
		val ValueObject valueObject = model.contexts.get(0).namespaces.get(0).elements.get(0) as ValueObject
		val List<Attribute> attributes = valueObject.attributes
		return new SrcGetters(codeSnippetContext, GenerateOptions.empty(), "public", attributes)
	}

}
