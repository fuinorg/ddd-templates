package org.fuin.dsl.ddd.gen.aggregate

import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcImports
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions.*

class AggregateArtifactFactory extends AbstractSource<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregate.getName()
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + aggregate.getName()
		val filename = fqn.replace('.', '/') + ".java";
		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(aggregate.uniqueName, fqn)

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext()
		ctx.addImports
		ctx.addReferences(aggregate)
		ctx.resolve(refReg)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, aggregate, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate) {
		ctx.requiresReference(aggregate.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		''' 
			«copyrightHeader» 
			package «pkg»;
			
			«new SrcImports(ctx.imports)»
			
			«_typeDoc(aggregate)»
			public final class «className» extends Abstract«aggregate.name» {
			
				/**
				 * Default constructor for loading the aggregate root from history. 
				 */
				public «aggregate.name»() {
					super();
				}
			
				«_constructorsDecl(ctx, aggregate)»
			
				«_childEntityLocatorMethods(aggregate)»
				
				«_methodsDecl(ctx, aggregate)»
			
				«_eventMethodsDecl(aggregate)»
			
			}
		'''
	}

	override _constructorDecl(CodeSnippetContext ctx, String internalTypeName, List<Variable> variables,
		Constraints constraints) {
		'''
			«_methodDoc("Constructor with all data.", variables, null)»
			public «internalTypeName»(«_paramsDecl(variables.nullSafe)») «new SrcThrowsExceptions(ctx, constraints.exceptionList)»{
				super();
				// TODO Implement!
			}
		'''
	}

}
