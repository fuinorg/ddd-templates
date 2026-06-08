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
class SimpleAggregateIdArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testCreateMyAggregateId5() {

        // PREPARE
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")

        val SimpleAggregateIdArtifactFactory testee = createTestee()
        val AggregateId aggregateId = model.find(typeof(AggregateId), "MyAggregate5Id")

        // TEST
        val result = new String(testee.create(aggregateId, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo("x/aggregateid/MyAggregate5Id.java".loadConcreteExample)

    }

    private def createTestee() {
        val factory = new SimpleAggregateIdArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("aggregateId", SimpleAggregateIdArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
        config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
        config.addVariable(new Variable(GenerateOptions.KEY_JPA, "true"))
        config.addVariable(new Variable(GenerateOptions.KEY_JAXB, "true"))
        config.addVariable(new Variable(GenerateOptions.KEY_JSONB, "true"))
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
