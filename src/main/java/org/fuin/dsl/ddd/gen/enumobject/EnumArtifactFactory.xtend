package org.fuin.dsl.ddd.gen.enumobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod
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
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class EnumArtifactFactory extends AbstractSource<EnumObject> {

	override getModelType() {
		typeof(EnumObject)
	}

	override create(EnumObject enu, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = enu.getName()
		val Namespace ns = enu.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(enu.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(enu)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, enu, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
	}

	def addReferences(CodeSnippetContext ctx, EnumObject enu) {
	}

	def create(SimpleCodeSnippetContext ctx, EnumObject vo, String pkg, String className) {
		val String src = ''' 
			/** «vo.doc.text» */
			public enum «vo.name» {
			
			«FOR in : vo.instances SEPARATOR ','»
				«in.doc»
				«new SrcInvokeMethod(ctx, in.name, in.params.litNames)»
			«ENDFOR»;
			
				«new SrcVarsDecl(ctx, "private", false, vo)»
			
				private «vo.name»(«new SrcParamsDecl(ctx, vo.variables)») {
					«new SrcParamsAssignment(ctx, vo.variables)»
				}
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
