package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcSetterTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateNoMultiplicity() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val SrcSetter testee = createTesteeNoMultiplicity(ctx)

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
			'''.toString)
		assertThat(ctx.imports).contains("javax.validation.constraints.NotNull", "java.lang.String",
			"org.fuin.objects4j.common.Contract")

	}

	@Test
	def void testCreateWithMultiplicity() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		refReg.putReference("ctx.types.List", "java.util.List")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val SrcSetter testee = createTesteeWithMultiplicity(ctx)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Sets: List of human readable names.
				 *
				 * @param names Value to set.
				 */
				public void setNames(@NotNull final List<String> names) {
					Contract.requireArgNotNull("names", names);
					this.names = names;
				}
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "java.util.List",
			"java.lang.String", "org.fuin.objects4j.common.Contract")

	}

	private def SrcSetter createTesteeNoMultiplicity(CodeSnippetContext codeSnippetContext) {
		val model = parser.parse(
			'''
				context ctx {
				
					namespace a.b {
						
						import ctx.types.*
						
						value-object MyValueObject {
							
							/** Human readable name. */
							String name
							
						}
						
					}
				
					namespace types {
						type String
					}
					
				}
			'''
		)
		val ValueObject valueObject = model.contexts.get(0).namespaces.get(0).elements.get(0) as ValueObject
		return new SrcSetter(codeSnippetContext, GenerateOptions.empty(), "public", valueObject.attributes.first)
	}

	private def SrcSetter createTesteeWithMultiplicity(CodeSnippetContext codeSnippetContext) {
		val model = parser.parse(
			'''
				context ctx {
				
					namespace a.b {
						
						import ctx.types.*
						
						value-object MyValueObject {
							
							/** List of human readable names. */
							List<String> names
							
						}
						
					}
				
					namespace types {
						type String
						type List generics 1
					}
					
				}
			'''
		)
		validationTester.assertNoIssues(model)
		val ValueObject valueObject = model.contexts.get(0).namespaces.get(0).elements.get(0) as ValueObject
		return new SrcSetter(codeSnippetContext, GenerateOptions.empty(), "public", valueObject.attributes.first)
	}

}
