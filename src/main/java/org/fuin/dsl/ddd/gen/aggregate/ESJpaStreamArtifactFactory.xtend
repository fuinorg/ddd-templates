package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

class ESJpaStreamArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + aggregate.getName()).replace('.', '/') + "Stream.java"
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
		 * «aggregate.name» stream.
		 */
		@Table(name = "«aggregate.name.toSqlUpper»_STREAMS")
		@Entity
		public class «aggregate.name»Stream extends Stream {
		
		    @Id
		    @NotNull
		    @Column(name = "«aggregate.name.toSqlUpper»_ID")
		    private String «aggregate.name.toFirstLower»Id;
		
		    private transient «aggregate.name»Id id;
		
		    /**
		     * Protected default constructor for JPA.
		     */
		    protected «aggregate.name»Stream() {
				super();
		    }
		
		    /**
		     * Constructor with mandatory data.
		     * 
		     * @param «aggregate.name.toFirstLower»Id
		     *            Unique «aggregate.name.toFirstLower» identifier.
		     */
		    public «aggregate.name»Stream(@NotNull final «aggregate.name»Id «aggregate.name.toFirstLower»Id) {
				super();
				Contract.requireArgNotNull("«aggregate.name.toFirstLower»Id", «aggregate.name.toFirstLower»Id);
				this.«aggregate.name.toFirstLower»Id = «aggregate.name.toFirstLower»Id.asString();
				this.id = «aggregate.name.toFirstLower»Id;
		    }
		
		    /**
		     * Returns the unique «aggregate.name.toFirstLower» identifier as string.
		     * 
		     * @return «aggregate.name» identifier.
		     */
		    public final String get«aggregate.name»Id() {
				return «aggregate.name.toFirstLower»Id;
		    }
		
		    /**
		     * Returns the «aggregate.name.toFirstLower» identifier.
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
		     * Creates a container that stores the given event entry.
		     * 
		     * @param eventEntry
		     *            Event entry to convert into a JPA variant.
		     * 
		     * @return JPA entity.
		     */
		    public final StreamEvent createEvent(@NotNull final EventEntry eventEntry) {
				incVersion();
				return new «aggregate.name»Event(getId(), getVersion(), eventEntry);
		    }
		
		    @Override
		    public final String toString() {
				return «aggregate.name.toFirstLower»Id;
		    }
		
		}
		'''	
	}
	
}