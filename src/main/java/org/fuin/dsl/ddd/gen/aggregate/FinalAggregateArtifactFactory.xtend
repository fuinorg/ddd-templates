package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcChildEntityLocatorMethods
import org.fuin.dsl.ddd.gen.base.SrcConstructorSignature
import org.fuin.dsl.ddd.gen.base.SrcHandleEventMethods
import org.fuin.dsl.ddd.gen.base.SrcJavaDocMethod
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcMethods
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class FinalAggregateArtifactFactory extends AbstractSource<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregate.getName()
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(aggregate.uniqueName, fqn)

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
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate) {
		ctx.requiresReference(aggregate.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDocType(aggregate)»
			public final class «className» extends Abstract«aggregate.name» {
			
				/**
				 * Default constructor for loading the aggregate root from history. 
				 */
				public «aggregate.name»() {
					super();
				}
			
				«FOR constructor : aggregate.constructors.nullSafe»
					«new SrcJavaDocMethod(ctx, constructor)»
					«new SrcConstructorSignature(ctx, "public", className, constructor)» {
						super();
						// TODO Implement!
					}
					
				«ENDFOR»
				«new SrcChildEntityLocatorMethods(ctx, aggregate)»
				«new SrcMethods(ctx, aggregate)»
				«new SrcHandleEventMethods(ctx, aggregate.allEvents)»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString
	}

	def _constructors(CodeSnippetContext ctx, Aggregate aggregate, String className) {
		'''
			«FOR constructor : aggregate.constructors.nullSafe»
				«new SrcJavaDocMethod(ctx, constructor)»
				«new SrcConstructorSignature(ctx, "public", className, constructor)» {
					super();
					// TODO Implement!
				}
				
			«ENDFOR»
		'''
	}

}
