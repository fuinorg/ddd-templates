package org.fuin.dsl.ddd.gen.except

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

class ExceptionArtifactFactory extends AbstractSource<Exception> {

	override getModelType() {
		typeof(Exception)
	}

	override create(Exception ex, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = ex.getName()
		val Namespace ns = ex.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + ex.getName()
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(ex.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(ex)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, ex, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.objects4j.vo.KeyValue")
	}

	def addReferences(CodeSnippetContext ctx, Exception ex) {
	}

	def create(SimpleCodeSnippetContext ctx, Exception ex, String pkg, String className) {
		val String src = ''' 
			/**
			 * «ex.doc.text»
			 */
			public final class «className» extends «_uniquelyNumberedException(ex)» {
			
				private static final long serialVersionUID = 1000L;
			
				«new SrcVarsDecl(ctx, "private", false, ex)»
			
				/**
				 * Constructs a new instance of the exception.
				 *
				«FOR v : ex.variables»
					* @param «v.name» «v.superDoc» 
				«ENDFOR»
				*/
				public «ex.name»(«_paramsDecl(ctx, ex.variables)») {
					super(«IF ex.cid > 0»«ex.cid», «ENDIF»
					    KeyValue.replace("«ex.message»",
					«FOR v : ex.variables SEPARATOR ','»
						new KeyValue("«v.name»", «v.name»)
					«ENDFOR» 
					));
					«new SrcParamsAssignment(ctx, ex.variables)»
				}
			
				«new SrcGetters(ctx, "public final", ex.variables)»
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
