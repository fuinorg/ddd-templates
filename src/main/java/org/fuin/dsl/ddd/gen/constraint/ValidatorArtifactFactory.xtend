package org.fuin.dsl.ddd.gen.constraint

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.base.Utils.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintTargetExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

class ValidatorArtifactFactory extends AbstractSource<Constraint> {

	override getModelType() {
		typeof(Constraint)
	}

	override create(Constraint constraint, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (constraint.target == null) {
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
		ctx.addImports
		ctx.addReferences(constraint)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, constraint, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.enterprise.context.ApplicationScoped")
		ctx.requiresImport("javax.validation.Validator")
		ctx.requiresImport("javax.validation.ConstraintValidator")
		ctx.requiresImport("javax.validation.ConstraintValidatorContext")
	}

	def addReferences(CodeSnippetContext ctx, Constraint constraint) {
		ctx.requiresReference(constraint.uniqueName) // Annotation
		ctx.requiresReference(constraint.target.uniqueName) // Type
		val variables = constraint.target.variables
		for (variable : variables) {
			ctx.requiresReference(variable.type.uniqueName)
		}
		if (constraint.exception != null) {
			ctx.requiresReference(constraint.exception.uniqueName)
		}
	}

	def create(SimpleCodeSnippetContext ctx, Constraint c, String pkg, String className) {

		val targetName = c.target.name
		val variables = c.target.variables

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
			
				«IF c.exception != null»
					/**
					 * Verifies if the argument is valid an throws an exception otherwise.
					 * 
					 * @param validator Validator to use.
					 * @param obj Object to validate.
					 * 
					 * @throws «c.exception.name» The constraint was violated.
					 */
					public static void requireValid(final Validator validator, final «targetName» obj) throws «c.exception.name» {
						if (validator .validate(obj).size() > 0) {
							throw new «c.exception.name»(«FOR v : variables SEPARATOR ', '»«new SrcInvokeGetter(ctx, "obj", v).toString»«ENDFOR»);
						}
					}
					
				«ENDIF»
			}
			
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	/**
	 * Returns the unique name of the constraint target.
	 * 
	 * @param target Target to return a unique name for.
	 * 
	 * @return Unique name in the context/namespace.
	 */
	def String uniqueName(ConstraintTarget target) {
		if (target == null) {
			throw new IllegalArgumentException("argument 'target' cannot be null")
		}
		return separated(".", target.context.name, target.namespace.name, target.name)
	}

}
