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

import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class EventTestArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

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
		val EventTestArtifactFactory testee = createTestee()
		val Event event = model.find(typeof(Event), eventName)

		// TEST
		val result = new String(testee.create(event, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/ev/" + eventName + "Test.java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new EventTestArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("eventTest", EventTestArtifactFactory.name)
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
