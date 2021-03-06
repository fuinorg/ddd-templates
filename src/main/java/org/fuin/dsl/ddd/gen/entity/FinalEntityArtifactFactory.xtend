package org.fuin.dsl.ddd.gen.entity

import java.util.ArrayList
import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.ConstructorData
import org.fuin.dsl.ddd.gen.base.ConstructorParameter
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcChildEntityLocatorMethods
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcHandleEventMethods
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcMethods
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory.eINSTANCE

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDslFactoryExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class FinalEntityArtifactFactory extends AbstractSource<Entity> {

	override getModelType() {
		typeof(Entity)
	}

	override create(Entity entity, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entity.getName()
		val Namespace ns = entity.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
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
			«new SrcJavaDocType(entity)»
			public final class «entity.name» extends Abstract«entity.name» {
			
				«new SrcConstructorsWithParamsAssignment(ctx, GenerateOptions.empty(), constructorData(entity, className))»
				«new SrcChildEntityLocatorMethods(ctx, GenerateOptions.empty(), entity)»
				«new SrcMethods(ctx, GenerateOptions.empty(), entity)»
				«new SrcHandleEventMethods(ctx, entity.allEvents)»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def constructorData(Entity entity, String className) {
		val List<ConstructorData> constructors = new ArrayList<ConstructorData>()
		val rootParam = new ConstructorParameter(eINSTANCE.createParameter("The root aggregate of this entity.", entity.rootNullsafe, "rootAggregate", false), true)
		val idParam = new ConstructorParameter(eINSTANCE.createParameter("Unique entity identifier.", entity.idTypeNullsafe, "id", false), true)
		if (entity.constructors === null || entity.constructors.size == 0) {
			val List<ConstructorParameter> parameters = new ArrayList<ConstructorParameter>()
			parameters.add(rootParam)
			parameters.add(idParam)
			val ConstructorData cd = new ConstructorData("/** Constructor with mandatory data. */", null, "public", className, parameters, null)
			constructors.add(cd)
		} else {
			for (constructor : entity.constructors) {
				val ConstructorData cd = new ConstructorData("public", className, constructor, true)
				cd.prepend(idParam)
				cd.prepend(rootParam)
				constructors.add(cd)
			}			
		}
		return constructors
	}

}
