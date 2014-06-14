package org.fuin.dsl.ddd.gen.constraint

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.base.Utils.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

class ValidatorAnnotationArtifactFactory extends AbstractSource<Constraint> {

	override getModelType() {
		typeof(Constraint)
	}

	override create(Constraint constraint, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (constraint.target == null) {
			return null;
		}

		val className = constraint.getName()
		val Namespace ns = constraint.eContainer() as Namespace;
		val fqn = ns.asPackage + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(constraint.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext()
		ctx.addImports
		ctx.addReferences(constraint)
		ctx.resolve(refReg)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, constraint, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("java.lang.annotation.Documented")
		ctx.requiresImport("java.lang.annotation.Retention")
		ctx.requiresImport("java.lang.annotation.Target")
		ctx.requiresImport("javax.validation.Constraint")
		ctx.requiresImport("javax.validation.Payload")

	}

	def addReferences(CodeSnippetContext ctx, Constraint constraint) {
		ctx.requiresReference(constraint.uniqueName + "Validator")
	}

	def String replaceValidatedValue(String msg) {
		var String newMsg = msg.replace("${vv_", "${validatedValue.");
		return newMsg.replace("${vv}", "${validatedValue}");
	}

	def create(SimpleCodeSnippetContext ctx, Constraint c, String pkg, String className) {
		val String src = ''' 
			/**
			 * «c.doc.text»
			 */
			@Target({ TYPE, METHOD, FIELD, ANNOTATION_TYPE, PARAMETER })
			@Retention(RUNTIME)
			@Constraint(validatedBy = «c.name»Validator.class)
			@Documented
			// CHECKSTYLE:OFF:LineLength
			public @interface «c.name» {
			
				/** Used to create an error message. */
				   String message() default "«c.message.replaceValidatedValue»";
			
				/** Processing groups with which the constraint declaration is associated. */		
				  Class<?>[] groups() default {};
			
				/** Payload with which the the constraint declaration is associated. */
				   Class<? extends Payload>[] payload() default {};
			
				«IF c.variables.size == 1»
					«c.variables.last.doc»
					«asJavaPrimitive(c.variables.last)» value();
					
				«ELSEIF c.variables.size > 1»
					«FOR v:c.variables»	
						«v.doc»
						«asJavaPrimitive(v)» «v.name»();
						
					«ENDFOR»
				«ENDIF»
			}
			//CHECKSTYLE:ON:LineLength
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString
		
	}

}
