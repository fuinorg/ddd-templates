package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAbstractHandleEventMethods
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcSetters
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*


/**
 * Generates an abstract aggregate Java class.
 */
class AbstractAggregateArtifactFactory extends AbstractSource<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = "Abstract" + aggregate.getName()
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
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
		ctx.requiresReference(aggregate.idType.uniqueName)
	}

	/**
	 * Creates the actual source code.
	 */
	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(aggregate)»
			public abstract class «className» extends AbstractAggregateRoot<«aggregate.idType.name»> {
			
				@NotNull
				private «aggregate.idType.name» id;
			
				«new SrcVarsDecl(ctx, "private", false, aggregate)»
			
				@Override
				public final EntityType getType() {				
					return «aggregate.idType.name».TYPE;
				}
			
				@Override
				public final «aggregate.idType.name» getId() {
					return id;
				}
			
				/**
				 * Sets the aggregate identifier.
				 * 
				 * @param id Unique aggregate identifier.
				 */
				protected final void setId(@NotNull final «aggregate.idType.name» id) {
					Contract.requireArgNotNull("id", id);
					this.id = id;
				}
				
				«new SrcGetters(ctx, "protected final", aggregate.variables)»				
				«new SrcSetters(ctx, "protected final", aggregate.variables)»
				«_abstractChildEntityLocatorMethods(ctx, aggregate)»
			
				«new SrcAbstractHandleEventMethods(ctx, aggregate.allEvents)»
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString
		 
	}

}
