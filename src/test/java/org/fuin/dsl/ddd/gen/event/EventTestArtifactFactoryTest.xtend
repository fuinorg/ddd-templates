package org.fuin.dsl.ddd.gen.event

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
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
class EventTestArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateEventA() {
		testCreate("EventA")
	}

	@Test
	def void testCreateEventB() {
		testCreate("EventB")
	}

	@Test
	def void testCreateEventC() {
		testCreate("EventC")
	}

	@Test
	def void testCreateEventD() {
		testCreate("EventD")
	}

	private def testCreate(String eventName) {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.types.Integer", "java.lang.Integer")
		refReg.putReference("x.ev.CustomerId", EXAMPLES_CONCRETE + ".x.ev.CustomerId")
		refReg.putReference("x.ev." + eventName, EXAMPLES_CONCRETE + ".x.ev." + eventName)
		refReg.putReference("XEntityIdFactory", EXAMPLES_CONCRETE + ".x.ev.XEntityIdFactory")
		val EventTestArtifactFactory testee = createTestee(true, true, true)
		val Event event = model.find(typeof(Event), eventName)

		// TEST
		val result = new String(testee.create(event, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/ev/" + eventName + "Test.java").loadConcreteExample)

	}

	private def createTestee(boolean jaxb, boolean jaxbElements, boolean jsonb) {
		val factory = new EventTestArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("eventTest", EventTestArtifactFactory.name)
		config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.addVariable(new Variable(GenerateOptions.KEY_JAXB, jaxb.toString));
		config.addVariable(new Variable(GenerateOptions.KEY_JAXB_ELEMENTS, jaxbElements.toString));
		config.addVariable(new Variable(GenerateOptions.KEY_JSONB, jsonb.toString));
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/event.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
