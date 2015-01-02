package org.fuin.dsl.ddd.gen.except

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcKeyValueReplace
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import org.fuin.dsl.ddd.gen.base.SrcJavaDocMethod

class ExceptionArtifactFactory extends AbstractSource<Exception> {

	override getModelType() {
		typeof(Exception)
	}

	override create(Exception ex, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = ex.getName()
		val Namespace ns = ex.namespace
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(ex.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(ex)
		ctx.addReferences(ex)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, ex, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, Exception ex) {
		if (ex.cid > 0) {
			ctx.requiresImport("org.fuin.objects4j.common.UniquelyNumberedException")
		}
	}

	def addReferences(CodeSnippetContext ctx, Exception ex) {
		for (v : ex.variables) {
			ctx.requiresReference(v.type.uniqueName)
		}
	}

	def create(SimpleCodeSnippetContext ctx, Exception ex, String pkg, String className) {
		val String src = ''' 
			/**
			 * «ex.doc.text»
			 */
			public final class «className» extends «_uniquelyNumberedException(ex)» {
			
				private static final long serialVersionUID = 1000L;
			
				«new SrcVarsDecl(ctx, "private", false, ex)»
			
				«new SrcJavaDocMethod(ctx, "Constructs a new instance of the exception.", null, ex.variables, null)»
				public «ex.name»(«new SrcParamsDecl(ctx, ex.variables)») {
					super(«IF ex.cid > 0»«ex.cid», «ENDIF»«new SrcKeyValueReplace(ctx, ex.message, ex.variables.varNames)»);
					«new SrcParamsAssignment(ctx, ex.variables)»
				}
			
				«new SrcGetters(ctx, "public final", ex.variables)»
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def _uniquelyNumberedException(Exception ex) {
		if (ex.cid > 0) {
			'''UniquelyNumberedException'''
		} else {
			'''Exception'''
		}
	}

}
