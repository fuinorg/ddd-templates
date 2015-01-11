package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcParamsDeclTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val SrcParamsDecl testee = new SrcParamsDecl(ctx, valueObject.variables)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			"@NoArgConstraint @NotNull final String a, @NoArgConstraint final String b, @NotNull final String c, final String d")
		assertThat(ctx.imports).containsOnly("a.b.c.NoArgConstraint", "java.lang.String",
			"javax.validation.constraints.NotNull")

	}

	private def DomainModel createModel() {
		parser.parse(
			'''
				context y {
					
					namespace a {
						
						import y.types.*
				
						constraint NoArgConstraint on String {
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
	}

}
