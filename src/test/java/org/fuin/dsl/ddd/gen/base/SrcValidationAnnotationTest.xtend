package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcValidationAnnotationTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateNoArgConstraint() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.types.Integer", "java.lang.Integer")
		refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(0)
		val constraintCall = variable.invariants.calls.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall)

		ctx.resolve(refReg)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NoArgConstraint")
		assertThat(ctx.references).containsOnly("y.a.NoArgConstraint")
		assertThat(ctx.imports).containsOnly("a.b.c.NoArgConstraint")

	}
	
	@Test
	def void testCreateOneArgConstraint() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.types.Integer", "java.lang.Integer")
		refReg.putReference("y.a.OneArgConstraint", "a.b.c.OneArgConstraint")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(1)
		val constraintCall = variable.invariants.calls.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall)

		ctx.resolve(refReg)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@OneArgConstraint(50)")
		assertThat(ctx.references).containsOnly("y.a.OneArgConstraint", "y.types.Integer")
		assertThat(ctx.imports).containsOnly("a.b.c.OneArgConstraint", "java.lang.Integer")

	}

	@Test
	def void testCreateTwoArgsConstraint() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.types.Integer", "java.lang.Integer")
		refReg.putReference("y.a.TwoArgsConstraint", "a.b.c.TwoArgsConstraint")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(2)
		val constraintCall = variable.invariants.calls.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall)

		ctx.resolve(refReg)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@TwoArgsConstraint(min = 1, max = 100)")
		assertThat(ctx.references).containsOnly("y.a.TwoArgsConstraint", "y.types.Integer")
		assertThat(ctx.imports).containsOnly("a.b.c.TwoArgsConstraint", "java.lang.Integer")

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
					
					constraint OneArgConstraint on String {
						Integer expected
						message "OneArgConstraint message"
					}
			
					constraint TwoArgsConstraint on String {
						Integer min
						Integer max
				        message "TwoArgsConstraint message"
					}
			
					value-object MyValueObject {
						String strNoArgConstraint invariants NoArgConstraint
						String strOneArgConstraint invariants OneArgConstraint(50)
						String strTwoArgsConstraint invariants TwoArgsConstraint(1, 100)
					}
			
				}
			
				namespace types {
					type String
					type Integer
				}
					
			}
			'''
		)
	}

}
