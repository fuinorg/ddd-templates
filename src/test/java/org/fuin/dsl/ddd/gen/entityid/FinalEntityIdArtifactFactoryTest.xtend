package org.fuin.dsl.ddd.gen.entityid

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.xmlcfg4j.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class FinalEntityIdArtifactFactoryTest {

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
		refReg.putReference("x.entityid.AbstractMyEntityId", EXAMPLES_ABSTRACT + ".x.entityid.AbstractMyEntityId")

		val FinalEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntityId")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/MyEntityId.java".loadAbstractExample)

	}
	@Test
	def void testCreateMyEntity2Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.entityid.AbstractMyEntity2Id", EXAMPLES_ABSTRACT + ".x.entityid.AbstractMy2EntityId")

		val FinalEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntity2Id")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/MyEntity2Id.java".loadAbstractExample)
		
	}	

	@Test
	def void testCreateMyEntity3Id() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.entityid.MyEntity3IdConverter", EXAMPLES_CONCRETE + ".x.entityid.MyEntity3IdConverter")
		refReg.putReference("x.entityid.AbstractMyEntity3Id", EXAMPLES_ABSTRACT + ".x.entityid.AbstractMyEntity3Id")

		val FinalEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntity3Id")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/MyEntity3Id.java".loadAbstractExample)

	}
	@Test
	def void testCreateMyEntity4Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.entityid.AbstractMyEntity4Id", EXAMPLES_ABSTRACT + ".x.entityid.AbstractMy4EntityId")

		val FinalEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntity4Id")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/MyEntity4Id.java".loadAbstractExample)
		
	}
		
	private def createTestee() {
		val factory = new FinalEntityIdArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("entityId", FinalEntityIdArtifactFactory.name)
		config.addVariable(new Variable(GenerateOptions.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(GenerateOptions.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/entityid.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
