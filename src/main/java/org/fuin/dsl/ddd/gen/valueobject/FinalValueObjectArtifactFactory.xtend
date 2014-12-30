package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class FinalValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject vo, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = vo.name
		val abstractClassName = vo.abstractName
		val Namespace ns = vo.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(vo.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(vo)
		ctx.addReferences(vo)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, vo, pkg, className, abstractClassName).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, ValueObject vo) {
		if (vo.base != null) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")			
		}
		ctx.requiresImport("org.fuin.objects4j.common.Immutable")
	}

	def addReferences(CodeSnippetContext ctx, ValueObject vo) {
		if (vo.base != null) {
			ctx.requiresReference(vo.uniqueName + "Converter")			
		}
		ctx.requiresReference(vo.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, ValueObject id, String pkg, String className, String abstractClassName) {
		val String src = ''' 
			«new SrcJavaDoc(id)»
			@Immutable
			«IF id.base != null»
			@XmlJavaTypeAdapter(«id.name»Converter.class)
			«ENDIF»
			public final class «className» extends «abstractClassName» {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcVoBaseMethods(ctx, id)»
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
