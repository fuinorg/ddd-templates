package org.fuin.dsl.ddd.gen.enumobject

import java.util.HashMap
import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.cqrs.cqrsDsl.EnumObject
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
class EnumArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testEnumA() {
        testEnum("EnumA")
    }

    @Test
    def void testEnumB() {
        testEnum("EnumB")
    }

    @Test
    def void testEnumC() {
        testEnum("EnumC")
    }

    private def testEnum(String enumName) {

        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")
        refReg.putReference("x.types.Integer", "java.lang.Integer")

        val EnumArtifactFactory testee = createTestee()
        val EnumObject enu = model.find(typeof(EnumObject), enumName)

        // TEST
        val result = new String(testee.create(enu, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo(("x/enumobject/" + enumName + ".java").loadConcreteExample)

    }

    private def createTestee() {
        val factory = new EnumArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("enumObject", EnumArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
        config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
        config.init(new DefaultContext(), null)
        factory.init(config)
        return factory
    }

    private def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/enumobject.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
