package org.fuin.dsl.ddd.gen.valueobject

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
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
class ValueObjectArtifactFactoryTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

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

		val ValueObjectArtifactFactory testee = createTestee(true, false, true)
		val ValueObject vo = model.find(typeof(ValueObject), name)

		// TEST
		val result = new String(testee.create(vo, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/valueobject/" + name + ".java").loadConcreteExample)

	}
	

	private def createTestee(boolean jaxb, boolean jaxbElements, boolean jsonb) {
		val factory = new ValueObjectArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("vo", ValueObjectArtifactFactory.name)
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
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/valueobject.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
