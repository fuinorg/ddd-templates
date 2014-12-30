package org.fuin.dsl.ddd.gen.aggregateid

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class FinalAggregateIdArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateMyAggregateId() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.aggregateid.MyAggregateIdConverter", EXAMPLES_CONCRETE + ".x.aggregateid.MyAggregateIdConverter")
		refReg.putReference("x.aggregateid.AbstractMyAggregateId", EXAMPLES_ABSTRACT + ".x.aggregateid.AbstractMyAggregateId")

		val FinalAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregateId")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/MyAggregateId.java".loadAbstractExample)

	}
	@Test
	def void testCreateMyAggregate2Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.aggregateid.AbstractMyAggregate2Id", EXAMPLES_ABSTRACT + ".x.aggregateid.AbstractMy2AggregateId")

		val FinalAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate2Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/MyAggregate2Id.java".loadAbstractExample)
		
	}	

	@Test
	def void testCreateMyAggregate3Id() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.aggregateid.MyAggregate3IdConverter", EXAMPLES_CONCRETE + ".x.aggregateid.MyAggregate3IdConverter")
		refReg.putReference("x.aggregateid.AbstractMyAggregate3Id", EXAMPLES_ABSTRACT + ".x.aggregateid.AbstractMyAggregate3Id")

		val FinalAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate3Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/MyAggregate3Id.java".loadAbstractExample)

	}
	@Test
	def void testCreateMyAggregate4Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.aggregateid.AbstractMyAggregate4Id", EXAMPLES_ABSTRACT + ".x.aggregateid.AbstractMy4AggregateId")

		val FinalAggregateIdArtifactFactory testee = createTestee()
		val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate4Id")

		// TEST
		val result = new String(testee.create(aggregateId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/aggregateid/MyAggregate4Id.java".loadAbstractExample)
		
	}
		
	private def createTestee() {
		val factory = new FinalAggregateIdArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("aggregateId", FinalAggregateIdArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		return parser.parse(Utils.readAsString(class.getResource("/aggregateid.ddd")))
	}

}
