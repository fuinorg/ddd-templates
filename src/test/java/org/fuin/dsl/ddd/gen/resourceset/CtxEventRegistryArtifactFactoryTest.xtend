package org.fuin.dsl.ddd.gen.resourceset

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class CtxEventRegistryArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val String name = "XEventRegistry"
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.ev.EventA", EXAMPLES_CONCRETE + ".x.ev.EventA");
		refReg.putReference("x.ev.EventB", EXAMPLES_CONCRETE + ".x.ev.EventB");
		refReg.putReference("x.ev.EventC", EXAMPLES_CONCRETE + ".x.ev.EventC");
		refReg.putReference("x.ev.EventD", EXAMPLES_CONCRETE + ".x.ev.EventD");

		val CtxEventRegistryArtifactFactory testee = createTestee()
		val ResourceSet resourceSet = model()

		// TEST
		val result = new String(testee.create(resourceSet, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/resourceset/" + name + ".java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new CtxEventRegistryArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("ctxEventRegistry",
			CtxEventRegistryArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_PKG, "resourceset"))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/event.ddd")))
		validationTester.assertNoIssues(model)
		return model.eResource.resourceSet
	}

}
