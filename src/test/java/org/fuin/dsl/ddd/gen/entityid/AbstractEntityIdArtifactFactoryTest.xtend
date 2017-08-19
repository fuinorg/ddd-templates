package org.fuin.dsl.ddd.gen.entityid

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.xmlcfg4j.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class AbstractEntityIdArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateMyEntityId() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntityId")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/AbstractMyEntityId.java".loadAbstractExample)

	}
	
	@Test
	def void testCreateMyEntity2Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntity2Id")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/AbstractMyEntity2Id.java".loadAbstractExample)
		
	}	

	@Test
	def void testCreateMyEntity3Id() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntity3Id")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/AbstractMyEntity3Id.java".loadAbstractExample)

	}

	@Test
	def void testCreateMyEntity4Id() {
		
		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")

		val AbstractEntityIdArtifactFactory testee = createTestee()
		val EntityId entityId = model.find(typeof(EntityId), "MyEntity4Id")

		// TEST
		val result = new String(testee.create(entityId, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo("x/entityid/AbstractMyEntity4Id.java".loadAbstractExample)
		
	}	

	private def createTestee() {
		val factory = new AbstractEntityIdArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("abstractEntityId",
			AbstractEntityIdArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
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
