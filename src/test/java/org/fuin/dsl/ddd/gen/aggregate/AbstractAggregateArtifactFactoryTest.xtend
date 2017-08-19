package org.fuin.dsl.ddd.gen.aggregate

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.xmlcfg4j.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(DomainDrivenDesignDslInjectorProvider)
@RunWith(typeof(XtextRunner))
class AbstractAggregateArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testAbstractAggregateA() {
		testAggregate("AggregateA")
	}

	@Test
	def void testAbstractAggregateB() {
		testAggregate("AggregateB")
	}
	
	@Test
	def void testAbstractAggregateC() {
		testAggregate("AggregateC")
	}

	private def testAggregate(String aggregateName) {

		// PREPARE
		val abstractName = "Abstract" + aggregateName
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.types.Integer", "java.lang.Integer")
		refReg.putReference("x.aggregates." + aggregateName + "Id", "tst.x.aggregates." + aggregateName + "Id")
		refReg.putReference("x.aggregates." + aggregateName + "CreatedEvent", "tst.x.aggregates." + aggregateName + "CreatedEvent")

		val AbstractAggregateArtifactFactory testee = createTestee()
		val Aggregate aggregate = model.find(typeof(Aggregate), aggregateName)

		// TEST
		val result = new String(testee.create(aggregate, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/aggregates/" + abstractName + ".java").loadAbstractExample)

	}

	private def createTestee() {
		val factory = new AbstractAggregateArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("abstractAggregate",
			AbstractAggregateArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
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
