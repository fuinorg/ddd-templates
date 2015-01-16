package org.fuin.dsl.ddd.gen.resourceset

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
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
class CtxEntityIdFactoryArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val String name = "XEntityIdFactory"
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.types.Integer", "java.lang.Integer")
		refReg.putReference("x.resourceset.AggregateAId", EXAMPLES_CONCRETE + ".x.resourceset.AggregateAId");
		refReg.putReference("x.resourceset.AggregateAIdConverter",
			EXAMPLES_CONCRETE + ".x.resourceset.AggregateAIdConverter");
		refReg.putReference("x.resourceset.AggregateBId", EXAMPLES_CONCRETE + ".x.resourceset.AggregateBId");
		refReg.putReference("x.resourceset.AggregateBIdConverter",
			EXAMPLES_CONCRETE + ".x.resourceset.AggregateBIdConverter");
		refReg.putReference("x.resourceset.EntityAId", EXAMPLES_CONCRETE + ".x.resourceset.EntityAId");
		refReg.putReference("x.resourceset.EntityAIdConverter", EXAMPLES_CONCRETE + ".x.resourceset.EntityAIdConverter");
		refReg.putReference("x.resourceset.EntityBId", EXAMPLES_CONCRETE + ".x.resourceset.EntityBId");
		refReg.putReference("x.resourceset.EntityBIdConverter", EXAMPLES_CONCRETE + ".x.resourceset.EntityBIdConverter");

		val CtxEntityIdFactoryArtifactFactory testee = createTestee()
		val ResourceSet resourceSet = model()

		// TEST
		val result = new String(testee.create(resourceSet, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/resourceset/" + name + ".java").loadConcreteExample)

	}

	private def createTestee() {
		val factory = new CtxEntityIdFactoryArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("ctxEntityIdFactory",
			CtxEntityIdFactoryArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_CONCRETE))
		config.addVariable(new Variable(AbstractSource.KEY_PKG, "resourceset"))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/resourceset.ddd")))
		validationTester.assertNoIssues(model)
		return model.eResource.resourceSet
	}

}
