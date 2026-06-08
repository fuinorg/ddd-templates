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
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.junit.jupiter.api.^extension.ExtendWith

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class ESRepositoryFactoryArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testCreate() {

        // PREPARE
        val aggregateName = "AggregateC"
        val repoClassName = aggregateName + "Repository"
        val className = repoClassName + "Factory"
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.aggregates." + repoClassName, EXAMPLES_CONCRETE + ".x.aggregates." + repoClassName)
        refReg.putReference("XEventRegistry", EXAMPLES_CONCRETE + ".x.resourceset.XEventRegistry")

        val ESRepositoryFactoryArtifactFactory testee = createTestee()
        val Aggregate aggregate = model.find(typeof(Aggregate), aggregateName)

        // TEST
        val result = new String(testee.create(aggregate, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo(("x/aggregates/" + className + ".java").loadConcreteExample)

    }

    private def createTestee() {
        val factory = new ESRepositoryFactoryArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("esRepositoryFactory",
            ESRepositoryFactoryArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
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
