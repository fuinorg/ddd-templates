package org.fuin.dsl.ddd.gen.event

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.junit.Test
import org.junit.runner.RunWith
import java.util.HashMap
import org.fuin.dsl.ddd.gen.base.Utils

import static org.fest.assertions.Assertions.*
import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*
import org.fuin.srcgen4j.commons.Variable
import org.fuin.srcgen4j.commons.DefaultContext

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class EventArtifactFactoryTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateDomainEvent() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = Utils.getCodeReferenceRegistry(context)
		refReg.putReference("ctx.types.String", "java.lang.String")
		refReg.putReference("ctx.a.b.CustomerId", "tst.ctx.a.b.CustomerId")		
		
		val EventArtifactFactory testee = createTestee()
		val Event event = model.find(typeof(Event), "CustomerCreatedEvent")

		// TEST
		val result = new String(testee.create(event, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(
			'''
			package tst.ctx.a.b;
			
			import javax.validation.constraints.NotNull;
			import javax.xml.bind.annotation.XmlRootElement;
			import org.fuin.ddd4j.ddd.AbstractDomainEvent;
			import org.fuin.ddd4j.ddd.EntityIdPath;
			import org.fuin.ddd4j.ddd.EventType;
			import org.fuin.objects4j.vo.KeyValue;
			
			/**
			 * A new customer was created.
			 */
			@XmlRootElement(name = "customer-created-event")
			public final class CustomerCreatedEvent extends AbstractDomainEvent<CustomerId> {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("CustomerCreatedEvent");
				
			
				/**
				 * Protected default constructor for deserialization.
				 */
				protected CustomerCreatedEvent() {
					super();
				}
				
				/**
				 * A new customer was created.
				 *
				 * @param entityIdPath Path from the aggregate root (first) to the entity that raised the event (last). 
				*/
				public CustomerCreatedEvent(@NotNull final EntityIdPath entityIdPath) {
					super(entityIdPath);
				}
			
				@Override
				public final EventType getEventType() {
					return EVENT_TYPE;
				}
			
			
				@Override
				public final String toString() {
					return KeyValue.replace("Customer created",
						new KeyValue("#entityIdPath", getEntityIdPath())
					);
				}
				
			}
			''')

	}

	@Test
	def void testCreateStandardEvent() {

		// PREPARE
		val context = new HashMap<String, Object>()
		val refReg = Utils.getCodeReferenceRegistry(context)
		refReg.putReference("ctx.types.String", "java.lang.String")
		
		val EventArtifactFactory testee = createTestee()
		val Event event = model.find(typeof(Event), "SomethingInterestingHappenedEvent")

		// TEST
		val result = new String(testee.create(event, context, false).data)

		// VERIFY
		assertThat(result).isEqualTo(
			'''
			package tst.ctx.a.b;
			
			import javax.xml.bind.annotation.XmlRootElement;
			import org.fuin.ddd4j.ddd.AbstractDomainEvent;
			import org.fuin.ddd4j.ddd.EntityIdPath;
			import org.fuin.ddd4j.ddd.EventType;
			import org.fuin.objects4j.vo.KeyValue;
			
			/**
			 * Tells the world, that something interesting happened.
			 */
			@XmlRootElement(name = "something-interesting-happened-event")
			public final class SomethingInterestingHappenedEvent extends AbstractEvent {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name used to store the event. */
				public static final EventType EVENT_TYPE = new EventType("SomethingInterestingHappenedEvent");
				
			
				/**
				 * Tells the world, that something interesting happened.
				 *
				 */
				public SomethingInterestingHappenedEvent() {
					super();
				}
			
				@Override
				public final EventType getEventType() {
					return EVENT_TYPE;
				}
			
			
				@Override
				public final String toString() {
					return "Something interesting happened!";
				}
				
			}
			''')

	}

	private def createTestee() {
		val factory = new EventArtifactFactory()
		val ArtifactFactoryConfig config = new ArtifactFactoryConfig("event", EventArtifactFactory.name)
		config.addVariable(new Variable("basepkg", "tst"))
		config.init(new DefaultContext(), null)		
		factory.init(config)
		return factory
	}
	
	private def model() {
		parser.parse(
			'''
			context ctx {
			
				namespace a.b {
					
					type UUID
					type String
					
					aggregate-id CustomerId identifies Customer base UUID {	}
					
					aggregate Customer identifier CustomerId {
						constructor create fires CustomerCreatedEvent, SomethingInterestingHappenedEvent {			
						}
						/** A new customer was created. */
						event CustomerCreatedEvent {
							// No fields
							message "Customer created"					
						}
					}
					
					/** Tells the world, that something interesting happened. */
					event SomethingInterestingHappenedEvent {
						message "Something interesting happened!"
					}
					
				}
			
			}
			'''
		)
	}

}
