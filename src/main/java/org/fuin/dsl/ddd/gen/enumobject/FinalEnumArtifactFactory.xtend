package org.fuin.dsl.ddd.gen.enumobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.LiteralExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

class FinalEnumArtifactFactory extends AbstractSource<EnumObject> {

	override getModelType() {
		typeof(EnumObject)
	}

	override create(EnumObject enu, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = enu.name
		val abstractClassName = enu.abstractName
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
			create(ctx, enu, pkg, className, abstractClassName).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
	}

	def addReferences(CodeSnippetContext ctx, EnumObject enu) {
		if (enu.variables.nullSafe.size > 0) {
			ctx.requiresReference(enu.uniqueAbstractName)
		}
	}

	def create(SimpleCodeSnippetContext ctx, EnumObject eo, String pkg, String className, String abstractClassName) {
		val String src = ''' 
			/** «eo.doc.text» */
			public final class «className» «IF eo.variables.nullSafe.size > 0»extends «abstractClassName» «ENDIF»{
				
				«FOR in : eo.instances»
					«in.doc»
					public static final «className» «in.name» = new «className»(«FOR lit : in.params SEPARATOR ', '»«lit.str»«ENDFOR»);
					
				«ENDFOR»
				«new SrcStaticEnumCode(ctx, eo)»
				«IF eo.variables.nullSafe.size > 0»
					private «className»(«new SrcParamsDecl(ctx, eo.variables)») {
						«new SrcInvokeMethod(ctx, "super", eo.variables.varNames)»
					}
					
				«ENDIF»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
