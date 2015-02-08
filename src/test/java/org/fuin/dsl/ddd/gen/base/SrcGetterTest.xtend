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

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcGetterTest {

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
		val SrcGetter testee = createTesteeNoMultiplicity(ctx)

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
				 @NeverNull
				public String getName() {
					return name;
				}
			''')
		assertThat(ctx.imports).containsOnly("org.fuin.objects4j.common.NeverNull", "java.lang.String")

	}

	@Test
	def void testCreateWithMultiplicity() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		refReg.putReference("ctx.types.List", "java.util.List")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val SrcGetter testee = createTesteeWithMultiplicity(ctx)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Returns: List of human readable names.
				 *
				 * @return Current value.
				 */
				 @NeverNull
				public List<String> getNames() {
					return names;
				}
			''')
		assertThat(ctx.imports).containsOnly("org.fuin.objects4j.common.NeverNull", "java.util.List", "java.lang.String")

	}

	private def SrcGetter createTesteeNoMultiplicity(CodeSnippetContext codeSnippetContext) {
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
		return new SrcGetter(codeSnippetContext, "public", valueObject.attributes.first)
	}

	private def SrcGetter createTesteeWithMultiplicity(CodeSnippetContext codeSnippetContext) {
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
		return new SrcGetter(codeSnippetContext, "public", valueObject.attributes.first)
	}

}
