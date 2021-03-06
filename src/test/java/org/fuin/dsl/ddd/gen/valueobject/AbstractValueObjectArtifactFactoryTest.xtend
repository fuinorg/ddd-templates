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
class AbstractValueObjectArtifactFactoryTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreateAbstractMyValueObject() {
		testCreate("MyValueObject")
	}
	
	@Test
	def void testCreateAbstractMyValueObject2() {
		testCreate("MyValueObject2")
	}	

	@Test
	def void testCreateAbstractMyValueObject3() {
		testCreate("MyValueObject3")
	}

	@Test
	def void testCreateAbstractMyValueObject4() {
		testCreate("MyValueObject4")
	}	

	@Test
	def void testCreateAbstractFullName() {
		testCreate("FullName")
	}	

	def void testCreate(String name) {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractValueObjectArtifactFactory testee = createTestee()
		val ValueObject vo = model.find(typeof(ValueObject), name)

		// TEST
		val result = new String(testee.create(vo, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/valueobject/Abstract" + name + ".java").loadAbstractExample)
		
	}
		
	private def createTestee() {
		val factory = new AbstractValueObjectArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("abstractValueObject",
			AbstractValueObjectArtifactFactory.name)
		config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
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
