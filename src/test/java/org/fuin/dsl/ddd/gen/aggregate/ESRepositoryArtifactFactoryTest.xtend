package org.fuin.dsl.ddd.gen.aggregate

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
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
class ESRepositoryArtifactFactoryTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val aggregateName = "AggregateC"
		val className = aggregateName + "Repository"
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.aggregates." + aggregateName, EXAMPLES_ABSTRACT + ".x.aggregates." + aggregateName)
		refReg.putReference("x.aggregates." + aggregateName + "Id", EXAMPLES_ABSTRACT + ".x.aggregates." + aggregateName + "Id")

		val ESRepositoryArtifactFactory testee = createTestee()
		val Aggregate aggregate = model.find(typeof(Aggregate), aggregateName)

		// TEST
		val result = new String(testee.create(aggregate, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/aggregates/" + className + ".java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new ESRepositoryArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("esRepository",
			ESRepositoryArtifactFactory.name)
		config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/aggregate.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
