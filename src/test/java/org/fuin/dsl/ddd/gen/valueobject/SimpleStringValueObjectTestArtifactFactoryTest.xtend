package org.fuin.dsl.ddd.gen.valueobject

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
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
class SimpleStringValueObjectTestArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject
	private ValidationTestHelper validationTester

	@Test
	def void testCreateMyValueObject() {

		// PREPARE
		val name = "MySimpleStringValueObject"
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.valueobject." + name + "Converter",
			EXAMPLES_CONCRETE + ".x.valueobject." + name + "Converter")

		val SimpleStringValueObjectTestArtifactFactory testee = createTestee()
		val ValueObject vo = model.find(typeof(ValueObject), name)

		// TEST
		val result = new String(testee.create(vo, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/valueobject/" + name + "Test.java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new SimpleStringValueObjectTestArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("test", SimpleStringValueObjectTestArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.addVariable(new Variable(AbstractSource.KEY_JPA, "true"))
		config.addVariable(new Variable(AbstractSource.KEY_JAXB, "true"))
		config.addVariable(new Variable(AbstractSource.KEY_JSONB, "true"))
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
