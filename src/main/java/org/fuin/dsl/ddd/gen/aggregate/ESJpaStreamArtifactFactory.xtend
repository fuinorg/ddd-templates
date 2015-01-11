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

class ESJpaStreamArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregate.getName() + "Stream"
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(aggregate.uniqueName + "Stream", fqn)

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
		ctx.requiresImport("javax.persistence.Entity")
		ctx.requiresImport("javax.persistence.Id")
		ctx.requiresImport("javax.persistence.Table")
		ctx.requiresImport("javax.persistence.Column")
		ctx.requiresImport("javax.validation.constraints.NotNull")
		ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.Stream")
		ctx.requiresImport("org.fuin.objects4j.common.Contract")
		ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.StreamEvent")
		ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.EventEntry")
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate) {
		ctx.requiresReference(aggregate.idType.uniqueName)
	}

	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		val String src = ''' 
			/**
			 * «aggregate.name» stream.
			 */
			@Table(name = "«aggregate.name.toSqlUpper»_STREAMS")
			@Entity
			public class «className» extends Stream {
			
			    @Id
			    @NotNull
			    @Column(name = "«aggregate.name.toSqlUpper»_ID")
			    private String «aggregate.name.toFirstLower»Id;
			
			    private transient «aggregate.name»Id id;
			
			    /**
			     * Protected default constructor for JPA.
			     */
			    protected «className»() {
					super();
			  	}
			
			    /**
			     * Constructor with mandatory data.
			     * 
			     * @param «aggregate.name.toFirstLower»Id
			     *            Unique «aggregate.name.toFirstLower» identifier.
			     */
			    public «className»(@NotNull final «aggregate.name»Id «aggregate.name.toFirstLower»Id) {
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

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
