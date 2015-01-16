package org.fuin.dsl.ddd.gen.constr

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.dsl.ddd.gen.constraint.ValidatorAnnotationArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class ValidatorAnnotationArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testConstraintA() {
		testConstraint("ConstraintA")
	}

	@Test
	def void testConstraintB() {
		testConstraint("ConstraintB")
	}

	@Test
	def void testConstraintC() {
		testConstraint("ConstraintC")
	}

	@Test
	def void testConstraintD() {
		testConstraint("ConstraintD")
	}
	
	@Test
	def void testConstraintE() {
		testConstraint("ConstraintE")
	}

	@Test
	def void testConstraintF() {
		testConstraint("ConstraintF")
	}

	@Test
	def void testConstraintG() {
		testConstraint("ConstraintG")
	}

	@Test
	def void testConstraintH() {
		testConstraint("ConstraintH")
	}

	private def testConstraint(String constrName) {

		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.constr." + constrName + "Validator",
			EXAMPLES_CONCRETE + ".x.constr." + constrName + "Validator")

		val ValidatorAnnotationArtifactFactory testee = createTestee()
		val Constraint constraint = model.find(typeof(Constraint), constrName)

		// TEST
		val result = new String(testee.create(constraint, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/constr/" + constrName + ".java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new ValidatorAnnotationArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("validatorAnnotation",
			ValidatorAnnotationArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/constraint.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
