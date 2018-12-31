package org.fuin.dsl.ddd.gen.except

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.xmlcfg4j.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class ExceptionArtifactFactoryTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreateEventA() {
		testCreate("ExceptionA")
	}

	@Test
	def void testCreateEventB() {
		testCreate("ExceptionB")
	}

	@Test
	def void testCreateEventC() {
		testCreate("ExceptionC")
	}

	@Test
	def void testCreateEventD() {
		testCreate("ExceptionD")
	}

	@Test
	def void testCreateEventE() {
		testCreate("ExceptionE")
	}

	@Test
	def void testCreateEventF() {
		testCreate("ExceptionF")
	}

	private def testCreate(String name) {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.types.Integer", "java.lang.Integer")

		val ExceptionArtifactFactory testee = createTestee()
		val Exception ex = model.find(typeof(Exception), name)

		// TEST
		val result = new String(testee.create(ex, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/except/" + name + ".java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new ExceptionArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("exception", ExceptionArtifactFactory.name)
		config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/exception.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
