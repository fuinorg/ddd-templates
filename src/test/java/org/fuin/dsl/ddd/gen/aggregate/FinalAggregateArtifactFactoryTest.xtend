package org.fuin.dsl.ddd.gen.aggregate

import java.util.HashMap
import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.cqrsDsl.Aggregate
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.dsl.cqrs.tests.CqrsDslInjectorProvider
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.jupiter.api.Test

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.cqrs.extensions.CqrsDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.extensions.InjectionExtension

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class FinalAggregateArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testAggregateA() {
        testAggregate("AggregateA")
    }

    @Test
    def void testAggregateB() {
        testAggregate("AggregateB")
    }
    
    @Test
    def void testAggregateC() {
        testAggregate("AggregateC")
    }

    private def testAggregate(String aggregateName) {

        // PREPARE
        val abstractName = "Abstract" + aggregateName
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")
        refReg.putReference("x.types.Integer", "java.lang.Integer")
        refReg.putReference("x.aggregates." + abstractName, "tst.x.aggregates." + abstractName)
        refReg.putReference("x.aggregates." + aggregateName + "Id", "tst.x.aggregates." + aggregateName + "Id")
        refReg.putReference("x.aggregates." + aggregateName + "CreatedEvent", "tst.x.aggregates." + aggregateName + "CreatedEvent")
        refReg.putReference("x.aggregates.AnyConstraintViolatedException", "tst.x.aggregates.AnyConstraintViolatedException")

        val FinalAggregateArtifactFactory testee = createTestee()
        val Aggregate aggregate = model.find(typeof(Aggregate), aggregateName)

        // TEST
        val result = new String(testee.create(aggregate, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo(("x/aggregates/" + aggregateName + ".java").loadAbstractExample)

    }

    private def createTestee() {
        val factory = new FinalAggregateArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("aggregate",
            FinalAggregateArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
        config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
        config.init(new DefaultContext(), null)
        factory.init(config)
        return factory
    }

    private def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/aggregate.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
