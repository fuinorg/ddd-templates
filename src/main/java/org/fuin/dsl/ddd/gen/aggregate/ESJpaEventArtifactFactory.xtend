package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAggregateExtensions.*

class ESJpaEventArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregate.getName() + "Event"
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(aggregate.uniqueName + "Event", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(aggregate)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, aggregate, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.persistence.Column")
		ctx.requiresImport("javax.persistence.Entity")
		ctx.requiresImport("javax.persistence.Id")
		ctx.requiresImport("javax.persistence.IdClass")
		ctx.requiresImport("javax.persistence.Table")
		ctx.requiresImport("javax.validation.constraints.NotNull")
		ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.EventEntry")
		ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.StreamEvent")
		ctx.requiresImport("org.fuin.objects4j.common.Contract")
		
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate) {
		ctx.requiresReference(aggregate.idTypeNullsafe.uniqueName)
		ctx.requiresReference(aggregate.uniqueName + "Id")
	}

	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		val String src = ''' 
			/**
			 * «aggregate.name» event.
			 */
			@Table(name = "«aggregate.name.toSqlUpper»_EVENTS")
			@Entity
			@IdClass(«aggregate.name»EventId.class)
			public class «className» extends StreamEvent {
			
			    @Id
			    @NotNull
			    @Column(name = "«aggregate.idTypeNullsafe.name.toSqlUpper»")
			    private String «aggregate.idTypeNullsafe.name.toFirstLower»;
			
			    @Id
			    @NotNull
			    @Column(name = "EVENT_NUMBER")
			    private Integer eventNumber;
			
			    private transient «aggregate.idTypeNullsafe.name» id;
			
			    /**
			     * Protected default constructor only required for JPA.
			     */
			    protected «aggregate.name»Event() {
					super();
			  }
			
			    /**
			     * Constructor with all mandatory data.
			     * 
			     * @param «aggregate.idTypeNullsafe.name.toFirstLower»
			     *            Unique aggregate identifier.
			     * @param version
			     *            Version.
			     * @param eventEntry
			     *            Event entry to connect.
			     */
			    public «aggregate.name»Event(@NotNull final «aggregate.idTypeNullsafe.name» «aggregate.idTypeNullsafe.name.toFirstLower»,
			     @NotNull final Integer version, final EventEntry eventEntry) {
					super(eventEntry);
					Contract.requireArgNotNull("«aggregate.idTypeNullsafe.name.toFirstLower»", «aggregate.idTypeNullsafe.name.toFirstLower»);
					Contract.requireArgNotNull("version", version);
					this.«aggregate.idTypeNullsafe.name.toFirstLower» = «aggregate.idTypeNullsafe.name.toFirstLower».asString();
					this.eventNumber = version;
					this.id = «aggregate.idTypeNullsafe.name.toFirstLower»;
			  }
			
			    /**
			     * Returns the unique aggregate identifier.
			     * 
			     * @return Aggregate identifier.
			     */
			    public final String get«aggregate.idTypeNullsafe.name»() {
					return «aggregate.idTypeNullsafe.name.toFirstLower»;
			  }
			
			    /**
			     * Returns the aggregate identifier.
			     * 
			     * @return Name converted into a «aggregate.name.toFirstLower» ID.
			     */
			    public final «aggregate.idTypeNullsafe.name» getId() {
					if (id == null) {
			  id = «aggregate.idTypeNullsafe.name».valueOf(«aggregate.idTypeNullsafe.name.toFirstLower»);
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
					result = prime * result	+ ((«aggregate.idTypeNullsafe.name.toFirstLower» === null) ? 0 : «aggregate.idTypeNullsafe.name.toFirstLower».hashCode());
					result = prime * result	+ ((eventNumber == null) ? 0 : eventNumber.hashCode());
					return result;
			  }
			
			    @Override
			    public final boolean equals(final Object obj) {
					if (this == obj)
			  return true;
					if (obj == null)
			  return false;
					if (getClass() !== obj.getClass())
			  return false;
					«aggregate.name»Event other = («aggregate.name»Event) obj;
					if («aggregate.idTypeNullsafe.name.toFirstLower» == null) {
			  if (other.«aggregate.idTypeNullsafe.name.toFirstLower» != null)
				return false;
					} else if (!«aggregate.idTypeNullsafe.name.toFirstLower».equals(other.«aggregate.idTypeNullsafe.name.toFirstLower»))
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
					return «aggregate.idTypeNullsafe.name.toFirstLower» + "-" + eventNumber;
			  }
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString 

	}

}
