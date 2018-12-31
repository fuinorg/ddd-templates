package org.fuin.dsl.ddd.gen.event

import java.util.HashMap
import java.util.Map
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
class EventArtifactFactoryTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreateEventA() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.ev.CustomerId", EXAMPLES_CONCRETE + ".x.ev.CustomerId")

		testCreate(context, "EventA")

	}

	
	@Test
	def void testCreateEventB() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.ev.CustomerId", EXAMPLES_CONCRETE + ".x.ev.CustomerId")

		testCreate(context, "EventB")

	}
	
	
	@Test
	def void testCreateEventC() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.types.Integer", "java.lang.Integer")
		refReg.putReference("x.ev.CustomerId", EXAMPLES_CONCRETE + ".x.ev.CustomerId")

		testCreate(context, "EventC")

	}
	
	@Test
	def void testCreateEventD() {

		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		testCreate(context, "EventD")
		
	}

	@Test
	def void testCreateEventE() {

		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		testCreate(context, "EventE")
		
	}
	
	private def testCreate(Map<String, Object> context, String eventName) {
		
		// PREPARE
		val EventArtifactFactory testee = createTestee(GenerateOptions.builder.withJaxb()
			.withJaxbElements(false).withJsonb().create()
		)
		val Event event = model.find(typeof(Event), eventName)

		// TEST
		val result = new String(testee.create(event, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/ev/" + eventName + ".java").loadConcreteExample)
		
	}

	private def createTestee(GenerateOptions options) {
		val factory = new EventArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("event", EventArtifactFactory.name)
		config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.addVariable(new Variable(GenerateOptions.KEY_JAXB, options.jaxb.toString));
		config.addVariable(new Variable(GenerateOptions.KEY_JAXB_ELEMENTS, options.jaxbElements.toString));
		config.addVariable(new Variable(GenerateOptions.KEY_JSONB, options.jsonb.toString));
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
