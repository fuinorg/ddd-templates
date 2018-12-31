package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddAttributeExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcParamsDeclTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val SrcParamsDecl testee = new SrcParamsDecl(ctx, GenerateOptions.empty(), valueObject.attributes.asParameters)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			"@NoArgConstraint @NotNull final String a, @NoArgConstraint final String b, @NotNull final String c, final String d")
		assertThat(ctx.imports).containsOnly("a.b.c.NoArgConstraint", "java.lang.String",
			"javax.validation.constraints.NotNull")

	}

	def DomainModel createModel() {
		val DomainModel model = parser.parse(
			'''
				context y {
					
					namespace a {
						
						import y.types.*
				
						constraint NoArgConstraint input String {
							message "NoArgConstraint message"
						}
				
						value-object MyValueObject {
							String a invariants NoArgConstraint
							nullable String b invariants NoArgConstraint
							String c
							nullable String d						
						}
				
					}
				
					namespace types {
						type String
					}
						
				}
			'''
		)
		validationTester.assertNoIssues(model)
		return model
	}


}
