package org.fuin.dsl.ddd.gen.entity

import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcSetters
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc

class AbstractEntityArtifactFactory extends AbstractSource<Entity> {

	override getModelType() {
		typeof(Entity)
	}

	override create(Entity entity, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = "Abstract" + entity.getName()
		val Namespace ns = entity.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(entity.uniqueAbstractName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(entity)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, entity, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractEntity")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
	}

	def addReferences(CodeSnippetContext ctx, Entity entity) {
		ctx.requiresReference(entity.idType.uniqueName)
	}

	def create(SimpleCodeSnippetContext ctx, Entity entity, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(entity)»
			public abstract class «className» extends AbstractEntity<«entity.root.idType.name», «entity.root.name», «entity.
				idType.name»> {
			
				private «entity.idType.name» id;
			
				«_varsDecl(ctx, entity, false)»
			
				«_constructorsDecl(ctx, entity, entity.constructors)»
			
				@Override
				public final EntityType getType() {				
					return «entity.idType.name».TYPE;
				}
			
				@Override
				public final «entity.idType.name» getId() {
					return id;
				}
			
				«new SrcGetters(ctx, "protected final", entity.variables)»				
				«new SrcSetters(ctx, "protected final", entity.variables)»
				«_abstractChildEntityLocatorMethods(entity)»
				
				«_eventAbstractMethodsDecl(entity)»
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString
		
	}

	def _constructorsDecl(CodeSnippetContext ctx, Entity entity, List<Constructor> constructors) {
		'''
			«FOR constructor : constructors»
				«_constructorDecl(ctx, entity, constructor)»
				
			«ENDFOR»
		'''
	}

	def _constructorDecl(CodeSnippetContext ctx, Entity entity, Constructor constructor) {
		'''
			/**
			 * «constructor.doc.text»
			 *
			 * @param rootAggregate The root aggregate of this entity.
			«FOR v : constructor.variables»
				* @param «v.name» «v.superDoc» 
			«ENDFOR»
			 */
			public Abstract«entity.name»(@NotNull final «entity.root.name» rootAggregate, «_paramsDecl(ctx, constructor.variables)») «new SrcThrowsExceptions(
				ctx, constructor.allExceptions)»{
				super(rootAggregate);
				«_paramsAssignment(constructor.variables)»	
			}
		'''
	}

}
