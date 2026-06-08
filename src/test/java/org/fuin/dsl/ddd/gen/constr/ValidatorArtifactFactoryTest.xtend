package org.fuin.dsl.ddd.gen.constr

import java.util.HashMap
import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.cqrsDsl.Constraint
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
class ValidatorArtifactFactoryTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testConstraintAValidator() {
        testConstraint("A")
    }
    
    @Test
    def void testConstraintBValidator() {
        testConstraint("B")
    }
    
    @Test
    def void testConstraintCValidator() {
        testConstraint("C")
    }
    
    @Test
    def void testConstraintDValidator() {
        testConstraint("D")
    }
    
    @Test
    def void testConstraintEValidator() {
        testConstraint("E")
    }
    
    @Test
    def void testConstraintFValidator() {
        testConstraint("F")
    }
    
    @Test
    def void testConstraintGValidator() {
        testConstraint("G")
    }
    
    @Test
    def void testConstraintHValidator() {
        testConstraint("H")
    }
    
    private def testConstraint(String constrChar) {
        
        // PREPARE
        val constrName = "Constraint" + constrChar
        val voName = "ValueObject" + constrChar
        val context = new HashMap<String, Object>()
        val refReg = context.codeReferenceRegistry
        refReg.putReference("x.types.String", "java.lang.String")
        refReg.putReference("x.constr." + constrName, EXAMPLES_CONCRETE + ".x.constr." + constrName)
        refReg.putReference("x.constr." + voName, EXAMPLES_CONCRETE + ".x.constr." + voName)

        val ValidatorArtifactFactory testee = createTestee()
        val Constraint constraint = model.find(typeof(Constraint), constrName)
        if (constraint.exception !== null) {
            val constrException = constrChar + "Exception"
            refReg.putReference("x.constr." + constrException, EXAMPLES_CONCRETE + ".x.constr." + constrException)
        }

        // TEST
        val result = new String(testee.create(constraint, context, false).iterator().next().data)

        // VERIFY
        assertThat(result).isEqualTo(("x/constr/" + constrName + "Validator.java").loadConcreteExample)

    }

    private def createTestee() {
        val factory = new ValidatorArtifactFactory()
        val ArtifactFactoryConfig config = new ArtifactFactoryConfig("validator", ValidatorArtifactFactory.name)
        config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_CONCRETE))
        config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
        config.init(new DefaultContext(), null)
        factory.init(config)
        return factory
    }

    private def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/constraint.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
