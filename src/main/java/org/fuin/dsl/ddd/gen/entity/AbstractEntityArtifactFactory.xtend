package org.fuin.dsl.ddd.gen.entity

import java.util.ArrayList
import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.ConstructorData
import org.fuin.dsl.ddd.gen.base.ConstructorParam
import org.fuin.dsl.ddd.gen.base.SrcAbstractChildEntityLocatorMethods
import org.fuin.dsl.ddd.gen.base.SrcAbstractHandleEventMethods
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcSetters
import org.fuin.dsl.ddd.gen.base.SrcVarDecl
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory.eINSTANCE

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.DomainDrivenDesignDslFactoryExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class AbstractEntityArtifactFactory extends AbstractSource<Entity> {

	override getModelType() {
		typeof(Entity)
	}

	override create(Entity entity, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entity.abstractName
		val Namespace ns = entity.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(entity.uniqueAbstractName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(entity)

		val idVar = eINSTANCE.createVariable(null, entity.idType, "id", false)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, entity, pkg, className, idVar).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractEntity")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
	}

	def addReferences(CodeSnippetContext ctx, Entity entity) {
		ctx.requiresReference(entity.idType.uniqueName)
		ctx.requiresReference(entity.root.uniqueName)
		ctx.requiresReference(entity.root.idType.uniqueName)
	}

	def create(SimpleCodeSnippetContext ctx, Entity entity, String pkg, String className, Variable idVar) {
		val String src = ''' 
			«new SrcJavaDocType(entity)»
			public abstract class «className» extends AbstractEntity<«entity.root.idType.name», «entity.root.name», «entity.
				idType.name»> {
			
				«new SrcVarDecl(ctx, "private", false, idVar)»
			
				«new SrcVarsDecl(ctx, "private", false, entity)»
				«new SrcConstructorsWithParamsAssignment(ctx, constructorData(entity, className))»
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
				«new SrcAbstractChildEntityLocatorMethods(ctx, entity)»
				«new SrcAbstractHandleEventMethods(ctx, entity.allEvents)»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def constructorData(Entity entity, String className) {
		val List<ConstructorData> constructors = new ArrayList<ConstructorData>()
		val rootParam = new ConstructorParam(eINSTANCE.createVariable("The root aggregate of this entity.", entity.root, "rootAggregate",	false), true)
		val idParam = new ConstructorParam(eINSTANCE.createVariable("Unique entity identifier.", entity.idType, "id", false), false)
		if (entity.constructors == null || entity.constructors.size == 0) {
			val List<ConstructorParam> parameters = new ArrayList<ConstructorParam>()
			parameters.add(rootParam)
			parameters.add(idParam)
			val ConstructorData cd = new ConstructorData("/** Constructor with aggregate root identifier. /", null, "protected", className, parameters, null)
			constructors.add(cd)
		} else {
			for (constructor : entity.constructors) {
				val ConstructorData cd = new ConstructorData("public", className, constructor)
				cd.prepend(idParam)
				cd.prepend(rootParam)
				constructors.add(cd)
			}			
		}
		return constructors
	}

}
