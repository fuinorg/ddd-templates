package org.fuin.dsl.ddd.gen.valueobject

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
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
class ValueObjectArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateMyValueObject() {
		testCreate("MyValueObject")
	}

	@Test
	def void testCreateMyValueObject2() {
		testCreate("MyValueObject2")
	}

	@Test
	def void testCreateMyValueObject3() {
		testCreate("MyValueObject3")
	}

	@Test
	def void testCreateMyValueObject4() {
		testCreate("MyValueObject4")
	}
	
	@Test
	def void testCreateFullName() {
		testCreate("FullName")
	}
	
	private def void testCreate(String name) {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.valueobject." + name + "Converter", EXAMPLES_CONCRETE + ".x.valueobject." + name + "Converter")

		val ValueObjectArtifactFactory testee = createTestee()
		val ValueObject vo = model.find(typeof(ValueObject), name)

		// TEST
		val result = new String(testee.create(vo, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/valueobject/" + name + ".java").loadConcreteExample)

	}
	

	private def createTestee() {
		val factory = new ValueObjectArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("vo", ValueObjectArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		return parser.parse(Utils.readAsString(class.getResource("/valueobject.ddd")))
	}

}
