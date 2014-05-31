package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ESJpaEventIdArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + aggregate.getName()).replace('.', '/') + "EventId.java"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	def create(Aggregate aggregate, Namespace ns) {
		''' 
		«copyrightHeader» 
		package «ns.asPackage»;
		
		import java.io.Serializable;
		import javax.validation.constraints.*;
		import org.fuin.objects4j.common.*;
		
		/**
		 * Identifies a stream event based on a string representation of the aggregate identifier and a version number.
		 */
		public class «aggregate.name»EventId implements Serializable {
		
		    private static final long serialVersionUID = 0L;
		
		    private String «aggregate.name.toFirstLower»Id;
		
		    private Integer eventNumber;
		
		    /**
		     * Default constructor for JPA. <b><i>CAUTION:</i> DO NOT USE IN APPLICATION CODE.</b>
		     */
		    public «aggregate.name»EventId() {
				super();
		    }
		
		    /**
		     * Constructor with all required data.
		     * 
		     * @param «aggregate.name.toFirstLower»Id
		     *            Unique name.
		     * @param eventNumber
		     *            Number of the event within the stream.
		     */
		    public «aggregate.name»EventId(@NotNull final «aggregate.name»Id «aggregate.name.toFirstLower»Id, @NotNull final Integer eventNumber) {
				super();
				Contract.requireArgNotNull("«aggregate.name.toFirstLower»Id", «aggregate.name.toFirstLower»Id);
				Contract.requireArgNotNull("nueventNumbermber", eventNumber);
				this.«aggregate.name.toFirstLower»Id = «aggregate.name.toFirstLower»Id.asString();
				this.eventNumber = eventNumber;
		    }
		
		    /**
		     * Returns the aggregate ID.
		     * 
		     * @return Unique aggregate identifier.
		     */
		    @NeverNull
		    public String get«aggregate.name»Id() {
				return «aggregate.name.toFirstLower»Id;
		    }
		
		    /**
		     * Returns the number of the event within the stream.
		     * 
		     * @return Order of the event in the stream.
		     */
		    @NeverNull
		    public Integer getEventNumber() {
				return eventNumber;
		    }
		
		    // CHECKSTYLE:OFF Generated code
		    @Override
		    public int hashCode() {
				final int prime = 31;
				int result = 1;
				result = prime * result	+ ((«aggregate.name.toFirstLower»Id == null) ? 0 : «aggregate.name.toFirstLower»Id.hashCode());
				result = prime * result	+ ((eventNumber == null) ? 0 : eventNumber.hashCode());
				return result;
		    }
		
		    @Override
		    public boolean equals(Object obj) {
				if (this == obj)
				    return true;
				if (obj == null)
				    return false;
				if (getClass() != obj.getClass())
				    return false;
				«aggregate.name»EventId other = («aggregate.name»EventId) obj;
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
		    public String toString() {
				return «aggregate.name.toFirstLower»Id + "-" + eventNumber;
		    }
		
		}
		'''	
	}
	
}