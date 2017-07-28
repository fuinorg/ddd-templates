package org.fuin.dsl.ddd.gen.constraint

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddStringExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddTypeExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class ValidatorArtifactFactory extends AbstractSource<Constraint> {

	override getModelType() {
		typeof(Constraint)
	}

	override create(Constraint constraint, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (constraint.input === null) {
			return null;
		}

		val className = constraint.getName() + "Validator"
		val Namespace ns = constraint.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";
		
		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(constraint.uniqueName + "Validator", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(constraint)
		ctx.addReferences(constraint)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, constraint, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, Constraint constraint) {
		ctx.requiresImport("javax.validation.ConstraintValidator")
		ctx.requiresImport("javax.validation.ConstraintValidatorContext")
		if ((constraint.exception !== null) && (constraint.input instanceof AbstractVO)) {
			ctx.requiresImport("javax.validation.Validator")
		}
	}

	def addReferences(CodeSnippetContext ctx, Constraint constraint) {
		ctx.requiresReference(constraint.uniqueName) 
		ctx.requiresReference(constraint.input.uniqueName) 
		if (constraint.exception !== null) {
			ctx.requiresReference(constraint.exception.uniqueName)
		}
	}

	def create(SimpleCodeSnippetContext ctx, Constraint c, String pkg, String className) {

		val targetName = c.input.name
		val variables = c.input.attributes

		val String src = ''' 
			/** «c.doc.text» */
			// CHECKSTYLE:OFF:LineLength
			public final class «className» implements ConstraintValidator<«c.name», «targetName»> {
				// CHECKSTYLE:ON:LineLength
			
				@Override
				public final void initialize(final «c.name» annotation) {
					// TODO Implement!
				}
			
				@Override
				public final boolean isValid(final «targetName» object, final ConstraintValidatorContext ctx) {
					// TODO Implement!
					return true;
				}
			
				«IF c.exception !== null»
					«IF c.input instanceof AbstractVO»
					/**
					 * Verifies that the argument is valid an throws an exception otherwise.
					 * 
					 * @param validator Validator to use.
					 * @param obj Object to validate.
					 * 
					 * @throws «c.exception.name» The constraint was violated.
					 */
					public static void requireValid(final Validator validator, final «targetName» obj) throws «c.exception.name» {
						if (validator.validate(obj).size() > 0) {
							throw new «c.exception.name»(«FOR v : variables SEPARATOR ', '»«new SrcInvokeGetter(ctx, "obj", v).toString»«ENDFOR»);
						}
					}
					«ELSE»
					/**
					 * Verifies that the argument is valid an throws an exception otherwise.
					 * 
					 * @param obj Object to validate.
					 * 
					 * @throws «c.exception.name» The constraint was violated.
					 */
					public static void requireValid(final «targetName» obj) throws «c.exception.name» {
						// TODO Implement!
						// if ( ... ) {
						//		throw new «c.exception.name»();
						// }
					}
					«ENDIF»

				«ENDIF»
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
