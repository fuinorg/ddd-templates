package org.fuin.dsl.ddd.gen.aggregateid

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
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

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class AbstractAggregateIdArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateMyAggregateId() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregateId")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/AbstractMyAggregateId.java".loadAbstractExample)

	}
	
	@Test
	def void testCreateMyAggregate2Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate2Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/AbstractMyAggregate2Id.java".loadAbstractExample)
		
	}	

	@Test
	def void testCreateMyAggregate3Id() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate3Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/AbstractMyAggregate3Id.java".loadAbstractExample)

	}

	@Test
	def void testCreateMyAggregate4Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate4Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/AbstractMyAggregate4Id.java".loadAbstractExample)
		
	}	

	@Test
	def void testCreateMyAggregate6Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.UUID", "java.util.UUID")

		val AbstractAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate6Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/AbstractMyAggregate6Id.java".loadAbstractExample)
		
	}	

	private def createTestee() {
		val factory = new AbstractAggregateIdArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("abstractAggregateId",
			AbstractAggregateIdArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/aggregateid.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
