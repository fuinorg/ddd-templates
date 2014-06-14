package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*

class ValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		
		val className = valueObject.getName()
		val Namespace ns = valueObject.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + valueObject.getName()
		val filename = fqn.replace('.', '/') + ".java";
		
		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(valueObject.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}
		
		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext()
		ctx.addImports
		ctx.resolve(refReg)
		
		return new GeneratedArtifact(artifactName, filename, create(ctx, valueObject, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.objects4j.vo.ValueObject")
	}

	def create(CodeSnippetContext ctx, ValueObject vo, String pkg, String className) {
		''' 
			«copyrightHeader»
			package «pkg»;
			
			«_imports(vo)»
			
			«_typeDoc(vo)»
			
			«IF vo.base == null»
				«_xmlRootElement(vo.name)»
			«ENDIF»
			public final class «className» «optionalExtendsForBase(vo.name, vo.base)»implements ValueObject {
			
				private static final long serialVersionUID = 1000L;
				
				«_varsDecl(vo, (vo.base == null))»
			
				«_optionalDeserializationConstructor(vo)»
			
				«_constructorsDecl(ctx, vo)»
				
				«new SrcGetters(ctx, "public final", vo.variables)»
				
				«_optionalBaseMethods(vo.name, vo.base)»
				
			}
		'''
	}

}
