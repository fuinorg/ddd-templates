package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ESJpaEventArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + aggregate.getName()).replace('.', '/') + "Event.java"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	def create(Aggregate aggregate, Namespace ns) {
		''' 
		«copyrightHeader» 
		package «ns.asPackage»;
		
		import javax.persistence.*;
		import javax.validation.constraints.*;
		import org.fuin.ddd4j.eventstore.jpa.*;
		import org.fuin.objects4j.common.*;
		
		/**
		 * «aggregate.name» event.
		 */
		@Table(name = "«aggregate.name.toSqlUpper»_EVENTS")
		@Entity
		@IdClass(«aggregate.name»EventId.class)
		public class «aggregate.name»Event extends StreamEvent {
		
		    @Id
		    @NotNull
		    @Column(name = "«aggregate.name.toSqlUpper»_ID")
		    private String «aggregate.name.toFirstLower»Id;
		
		    @Id
		    @NotNull
		    @Column(name = "EVENT_NUMBER")
		    private Integer eventNumber;
		
		    private transient «aggregate.name»Id id;
		
		    /**
		     * Protected default constructor only required for JPA.
		     */
		    protected «aggregate.name»Event() {
				super();
		    }
		
		    /**
		     * Constructor with all mandatory data.
		     * 
		     * @param «aggregate.name.toFirstLower»Id
		     *            Unique aggregate identifier.
		     * @param version
		     *            Version.
		     * @param eventEntry
		     *            Event entry to connect.
		     */
		    public «aggregate.name»Event(@NotNull final «aggregate.name»Id «aggregate.name.toFirstLower»Id,
			    @NotNull final Integer version, final EventEntry eventEntry) {
				super(eventEntry);
				Contract.requireArgNotNull("«aggregate.name.toFirstLower»Id", «aggregate.name.toFirstLower»Id);
				Contract.requireArgNotNull("version", version);
				this.«aggregate.name.toFirstLower»Id = «aggregate.name.toFirstLower»Id.asString();
				this.eventNumber = version;
				this.id = «aggregate.name.toFirstLower»Id;
		    }
		
		    /**
		     * Returns the unique aggregate identifier.
		     * 
		     * @return Aggregate identifier.
		     */
		    public final String get«aggregate.name»Id() {
				return «aggregate.name.toFirstLower»Id;
		    }
		
		    /**
		     * Returns the aggregate identifier.
		     * 
		     * @return Name converted into a «aggregate.name.toFirstLower» ID.
		     */
		    public final «aggregate.name»Id getId() {
				if (id == null) {
				    id = «aggregate.name»Id.valueOf(«aggregate.name.toFirstLower»Id);
				}
				return id;
		    }
		
		    /**
		     * Returns the event number of the stream.
		     * 
		     * @return Number that is unique in combination with the name.
		     */
		    public final Integer getEventNumber() {
				return eventNumber;
		    }
		
		    // CHECKSTYLE:OFF Generated code
		    @Override
		    public final int hashCode() {
				final int prime = 31;
				int result = 1;
				result = prime * result	+ ((«aggregate.name.toFirstLower»Id == null) ? 0 : «aggregate.name.toFirstLower»Id.hashCode());
				result = prime * result	+ ((eventNumber == null) ? 0 : eventNumber.hashCode());
				return result;
		    }
		
		    @Override
		    public final boolean equals(final Object obj) {
				if (this == obj)
				    return true;
				if (obj == null)
				    return false;
				if (getClass() != obj.getClass())
				    return false;
				«aggregate.name»Event other = («aggregate.name»Event) obj;
				if («aggregate.name.toFirstLower»Id == null) {
				    if (other.«aggregate.name.toFirstLower»Id != null)
					return false;
				} else if (!«aggregate.name.toFirstLower»Id.equals(other.«aggregate.name.toFirstLower»Id))
				    return false;
				if (eventNumber == null) {
				    if (other.eventNumber != null)
					return false;
				} else if (!eventNumber.equals(other.eventNumber))
				    return false;
				return true;
		    }
		
		    // CHECKSTYLE:ON
		
		    @Override
		    public final String toString() {
				return «aggregate.name.toFirstLower»Id + "-" + eventNumber;
		    }
		
		}
		'''	
	}
	
}