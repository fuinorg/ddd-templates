package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.dsl.ddd.gen.base.SrcVoBaseOptionalExtends
import org.fuin.dsl.ddd.gen.base.SrcXmlRootElement
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*

class ValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = valueObject.getName()
		val Namespace ns = valueObject.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(valueObject.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, valueObject, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.objects4j.vo.ValueObject")
	}

	def create(SimpleCodeSnippetContext ctx, ValueObject vo, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(vo)»
			«IF vo.base == null»
				«new SrcXmlRootElement(ctx, vo)»
			«ENDIF»
			public final class «className» «new SrcVoBaseOptionalExtends(ctx, vo.base)»implements ValueObject {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcVarsDecl(ctx, "private", (vo.base == null), vo)»
			
				«new SrcConstructorsWithParamsAssignment(ctx, vo)»
				
				«new SrcGetters(ctx, "public final", vo.variables)»
				
				«new SrcVoBaseMethods(ctx, vo)»
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
