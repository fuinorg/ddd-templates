package org.fuin.dsl.ddd.gen.entity

import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcChildEntityLocatorMethods
import org.fuin.dsl.ddd.gen.base.SrcHandleEventMethods
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcMethods
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

class EntityArtifactFactory extends AbstractSource<Entity> {

	override getModelType() {
		typeof(Entity)
	}

	override create(Entity entity, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entity.getName()
		val Namespace ns = entity.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(entity.uniqueName, fqn)

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
	}

	def addReferences(CodeSnippetContext ctx, Entity entity) {
		ctx.requiresReference(entity.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, Entity entity, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(entity)»
			public final class «entity.name» extends Abstract«entity.name» {
			
				«_constructorsDecl(ctx, entity, entity.constructors)»
			
				«new SrcChildEntityLocatorMethods(ctx, entity)»
				
				«new SrcMethods(ctx, entity)»
			
				«new SrcHandleEventMethods(ctx, entity.events)»
			
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
			public «entity.name»(final «entity.root.name» rootAggregate, «new SrcParamsDecl(ctx, constructor.variables)») «new SrcThrowsExceptions(
				ctx, constructor.allExceptions)»{
				«new SrcInvokeMethod(ctx, "super", union("rootAggregate", constructor.variables.varNames))»	
			}
		'''
	}

}
