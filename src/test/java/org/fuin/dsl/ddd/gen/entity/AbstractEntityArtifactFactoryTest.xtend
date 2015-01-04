package org.fuin.dsl.ddd.gen.entity

import java.util.HashMap
import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.Utils
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.DefaultContext
import org.fuin.srcgen4j.commons.Variable
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.base.TestExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class AbstractEntityArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testAbstractEntityA() {
		testEntity("EntityA")
	}
	
	@Test
	def void testAbstractEntityB() {
		testEntity("EntityB")
	}
	
	@Test
	def void testAbstractEntityC() {
		testEntity("EntityC")
	}
	
	private def testEntity(String entityName) {
		
		// PREPARE
		val abstractName = "Abstract" + entityName
		val context = new HashMap<String, Object>()
		val refReg = context.codeReferenceRegistry
		refReg.putReference("x.types.String", "java.lang.String")
		refReg.putReference("x.types.Integer", "java.lang.Integer")
		refReg.putReference("x.entities.AggregateX", "tst.x.entities.AggregateX")
		refReg.putReference("x.entities.AggregateXId", "tst.x.entities.AggregateXId")
		refReg.putReference("x.entities." + entityName + "Id", "tst.x.entities." + entityName + "Id")
		refReg.putReference("x.entities.AnyConstraintViolatedException", "tst.x.entities.AnyConstraintViolatedException")
		refReg.putReference("x.entities." + entityName + "CreatedEvent", "tst.x.entities." + entityName + "Id")

		val AbstractEntityArtifactFactory testee = createTestee()
		val Entity entity = model.find(typeof(Entity), entityName)

		// TEST
		val result = new String(testee.create(entity, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(("x/entities/" + abstractName + ".java").loadAbstractExample)

	}

	private def createTestee() {
		val factory = new AbstractEntityArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("abstractEntity", AbstractEntityArtifactFactory.name)
		config.addVariable(new Variable(AbstractSource.KEY_BASE_PKG, EXAMPLES_ABSTRACT))
		config.addVariable(new Variable(AbstractSource.KEY_COPYRIGHT_HEADER, Utils.readAsString("required-header.txt")))
		config.init(new DefaultContext(), null)
		factory.init(config)
		return factory
	}

	private def model() {
		return parser.parse(Utils.readAsString(class.getResource("/entity.ddd")))
	}

}