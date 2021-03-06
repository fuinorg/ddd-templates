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
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.base.SrcVoBaseOptionalExtends
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class AbstractValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = valueObject.abstractName
		val Namespace ns = valueObject.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(valueObject.uniqueAbstractName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(valueObject)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, valueObject, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport(org.fuin.objects4j.vo.ValueObject.name)
		ctx.requiresImport(Serializable.name)
	}

	def addReferences(CodeSnippetContext ctx, ValueObject valueObject) {
		// Not needed
	}

	def create(SimpleCodeSnippetContext ctx, ValueObject vo, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDocType(vo)»
			public abstract class «className» «new SrcVoBaseOptionalExtends(ctx, vo.base)»implements ValueObject, Serializable {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcVarsDecl(ctx, "private", GenerateOptions.empty(), vo)»
				«new SrcConstructorsWithParamsAssignment(ctx, GenerateOptions.empty(), vo, true)»
				«new SrcGetters(ctx, GenerateOptions.empty(), "public final", vo.attributes)»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
