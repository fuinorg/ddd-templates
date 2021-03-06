package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.SrcAbstractChildEntityLocatorMethods
import org.fuin.dsl.ddd.gen.base.SrcAbstractHandleEventMethods
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcSetters
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.service.SrcServices
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAggregateExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

/**
 * Generates an abstract aggregate Java class.
 */
class AbstractAggregateArtifactFactory extends AbstractSource<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregate.abstractName
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(aggregate.uniqueAbstractName, fqn)

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
		ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractAggregateRoot")
		ctx.requiresImport("javax.validation.constraints.NotNull")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
		ctx.requiresImport("org.fuin.objects4j.common.Contract")
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate) {
		ctx.requiresReference(aggregate.idTypeNullsafe.uniqueName)
	}

	/**
	 * Creates the actual source code.
	 */
	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDocType(aggregate)»
			public abstract class «className» extends AbstractAggregateRoot<«aggregate.idTypeNullsafe.name»> {
			
				@NotNull
				private «aggregate.idTypeNullsafe.name» id;
			
				«new SrcVarsDecl(ctx, "private", GenerateOptions.empty(), aggregate)»
				@Override
				public final EntityType getType() {
					return «aggregate.idTypeNullsafe.name».TYPE;
				}
			
				@Override
				public final «aggregate.idTypeNullsafe.name» getId() {
					return id;
				}
			
				/**
				 * Sets the aggregate identifier.
				 * 
				 * @param id Unique aggregate identifier.
				 */
				protected final void setId(@NotNull final «aggregate.idTypeNullsafe.name» id) {
					Contract.requireArgNotNull("id", id);
					this.id = id;
				}
				
				«new SrcGetters(ctx, GenerateOptions.empty(), "protected final", aggregate.attributes)»
				«new SrcSetters(ctx, GenerateOptions.empty(), "protected final", aggregate.attributes)»
				«new SrcAbstractChildEntityLocatorMethods(ctx, GenerateOptions.empty(), aggregate)»
				«new SrcAbstractHandleEventMethods(ctx, aggregate.allEvents)»
				«new SrcServices(ctx, aggregate.services)»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
