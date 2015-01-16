package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcSettersTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		refReg.putReference("ctx.types.Locale", "java.util.Locale")
		val ctx = new SimpleCodeSnippetContext(refReg);
		val SrcSetters testee = createTestee(ctx)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Sets: Human readable name.
				 *
				 * @param name Value to set.
				 */
				public void setName(@NotNull final String name) {
					Contract.requireArgNotNull("name", name);
					this.name = name;
				}
				
				/**
				 * Sets: Language the name is in.
				 *
				 * @param locale Value to set.
				 */
				public void setLocale(final Locale locale) {
					this.locale = locale;
				}
				
			''')
		assertThat(ctx.imports).containsOnly("java.lang.String", "java.util.Locale",
			"javax.validation.constraints.NotNull", "org.fuin.objects4j.common.Contract")

	}

	private def SrcSetters createTestee(CodeSnippetContext codeSnippetContext) {
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
		return new SrcSetters(codeSnippetContext, "public", valueObject.attributes)
	}

}
