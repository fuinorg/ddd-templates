package org.fuin.dsl.ddd.gen.event

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import java.util.Map

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class EventArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

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

	private def testCreate(Map<String, Object> context, String eventName) {
		
		// PREPARE
		val EventArtifactFactory testee = createTestee()
		val Event event = model.find(typeof(Event), eventName)

		// TEST
		val result = new String(testee.create(event, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/ev/" + eventName + ".java").loadConcreteExample)
		
	}

	private def createTestee() {
		val factory = new EventArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("event", EventArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		return parser.parse(Utils.readAsString(class.getResource("/event.ddd")))
	}

}
