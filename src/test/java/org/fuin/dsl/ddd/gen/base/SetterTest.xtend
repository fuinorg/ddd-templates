package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcSetterTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateNoMultiplicity() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext()
		val SrcSetter testee = createTesteeNoMultiplicity(ctx)

		// TEST
		val result = testee.toString
		ctx.resolve(refReg)

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
			''')
		assertThat(ctx.references).contains("ctx.types.String")
		assertThat(ctx.imports).contains("javax.validation.constraints.NotNull", "java.lang.String",
			"org.fuin.objects4j.common.Contract")

	}

	@Test
	def void testCreateWithMultiplicity() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("ctx.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext()
		val SrcSetter testee = createTesteeWithMultiplicity(ctx)

		// TEST
		val result = testee.toString
		ctx.resolve(refReg)

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
			''')
		assertThat(ctx.references).contains("ctx.types.String")
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
		val Variable variable = valueObject.variables.get(0)
		return new SrcSetter(codeSnippetContext, "public", variable)
	}

	private def SrcSetter createTesteeWithMultiplicity(CodeSnippetContext codeSnippetContext) {
		val model = parser.parse(
			'''
				context ctx {
				
					namespace a.b {
						
						import ctx.types.*
						
						value-object MyValueObject {
							
							/** List of human readable names. */
							String* names
							
						}
						
					}
				
					namespace types {
						type String
					}
					
				}
			'''
		)
		val ValueObject valueObject = model.contexts.get(0).namespaces.get(0).elements.get(0) as ValueObject
		val Variable variable = valueObject.variables.get(0)
		return new SrcSetter(codeSnippetContext, "public", variable)
	}

}
