package org.fuin.dsl.ddd.gen.entityid

import java.util.HashMap
import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.cqrs.cqrsDsl.EntityId
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
class EntityIdArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testCreateMyEntityId() {

        // PREPARE
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")
        refReg.putReference("x.entityid.MyEntityIdConverter", EXAMPLES_CONCRETE + ".x.entityid.MyEntityIdConverter")

        val EntityIdArtifactFactory testee = createTestee()
        val EntityId entityId = model.find(typeof(EntityId), "MyEntityId")

        // TEST
        val result = new String(testee.create(entityId, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo("x/entityid/MyEntityId.java".loadConcreteExample)

    }

    @Test
    def void testCreateMyEntity2Id() {

        // PREPARE
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")

        val EntityIdArtifactFactory testee = createTestee()
        val EntityId entityId = model.find(typeof(EntityId), "MyEntity2Id")

        // TEST
        val result = new String(testee.create(entityId, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo("x/entityid/MyEntity2Id.java".loadConcreteExample)

    }

    @Test
    def void testCreateMyEntity3Id() {

        // PREPARE
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")
        refReg.putReference("x.entityid.MyEntity3IdConverter", EXAMPLES_CONCRETE + ".x.entityid.MyEntity3IdConverter")

        val EntityIdArtifactFactory testee = createTestee()
        val EntityId entityId = model.find(typeof(EntityId), "MyEntity3Id")

        // TEST
        val result = new String(testee.create(entityId, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo("x/entityid/MyEntity3Id.java".loadConcreteExample)

    }

    @Test
    def void testCreateMyEntity4Id() {

        // PREPARE
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")

        val EntityIdArtifactFactory testee = createTestee()
        val EntityId entityId = model.find(typeof(EntityId), "MyEntity4Id")

        // TEST
        val result = new String(testee.create(entityId, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo("x/entityid/MyEntity4Id.java".loadConcreteExample)

    }

    private def createTestee() {
        val factory = new EntityIdArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("entityId", EntityIdArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
        config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
        config.init(new DefaultContext(), null)
        factory.init(config)
        return factory
    }

    private def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/entityid.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
