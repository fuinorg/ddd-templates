package org.fuin.dsl.ddd.gen.valueobject

import java.io.Serializable
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcMetaAnnotations
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.dsl.ddd.gen.base.SrcVoBaseOptionalExtends
import org.fuin.dsl.ddd.gen.base.SrcXmlRootElement
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class ValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = valueObject.name
		val Namespace ns = valueObject.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(valueObject.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(valueObject)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, ns, valueObject, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, ValueObject vo) {
		ctx.requiresImport(Serializable.name)
		ctx.requiresImport(org.fuin.objects4j.vo.ValueObject.name)
	}

	def create(SimpleCodeSnippetContext ctx, Namespace ns, ValueObject vo, String pkg, String className) {
		val GenerateOptions localOptions = new GenerateOptions.Builder()
			.withJaxb(vo.base === null && options.jaxb)
			.withJaxbElements(options.jaxbElements)
			.withJsonb((vo.base === null && options.jsonb))
			.create();
		val String src = ''' 
			«new SrcJavaDocType(vo)»
			«new SrcMetaAnnotations(ctx, vo.metaInfo, vo.context.name, ns.name + "." + className)»
			«IF vo.base === null»
				«new SrcXmlRootElement(ctx, vo)»
			«ENDIF»
			public final class «className» «new SrcVoBaseOptionalExtends(ctx, vo.base)»implements ValueObject, Serializable {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcVarsDecl(ctx, "private", localOptions, vo)»
				«new SrcConstructorsWithParamsAssignment(ctx, GenerateOptions.empty(), vo, false)»
				«new SrcGetters(ctx, GenerateOptions.empty(), "public final", vo.attributes)»
				«new SrcVoBaseMethods(ctx, vo)»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
