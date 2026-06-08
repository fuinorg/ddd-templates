package org.fuin.dsl.ddd.gen.aggregateid

import java.util.HashMap
import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.cqrsDsl.AggregateId
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.dsl.cqrs.tests.CqrsDslInjectorProvider
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.cqrs.extensions.CqrsDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class FinalAggregateIdArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

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
        val result = new String(testee.create(aggregateId, context, false).iterator().next().data)

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
        val result = new String(testee.create(aggregateId, context, false).iterator().next().data)
        
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
        val result = new String(testee.create(aggregateId, context, false).iterator().next().data)

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
        val result = new String(testee.create(aggregateId, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo("x/aggregateid/MyAggregate4Id.java".loadAbstractExample)
        
    }
        
    private def createTestee() {
        val factory = new FinalAggregateIdArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("aggregateId", FinalAggregateIdArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
        config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
        config.init(new DefaultContext(), null)
        factory.init(config)
        return factory
    }

    private def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/aggregateid.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
