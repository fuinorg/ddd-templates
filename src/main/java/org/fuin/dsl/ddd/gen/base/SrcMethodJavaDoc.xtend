package org.fuin.dsl.ddd.gen.base

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

/**
 * Creates source code for the JavaDoc of a constructor or method.
 */
class SrcMethodJavaDoc implements CodeSnippet {

	val CodeSnippetContext ctx
	val String doc
	val List<Variable> variables
	val List<Constraint> constraints

	/**
	 * Constructor with constructor.
	 * 
	 * @param ctx Context.
	 * @param constructor Constructor.
	 */
	new(CodeSnippetContext ctx, Constructor constructor) {
		this(ctx, constructor.doc, constructor.variables, constructor.allConstraints)
	}

	/**
	 * Constructor with method.
	 * 
	 * @param ctx Context.
	 * @param method method.
	 */
	new(CodeSnippetContext ctx, Method method) {
		this(ctx, method.doc, method.allVariables, method.allConstraints)
	}

	/**
	 * Constructor with mandatory data.
	 * 
	 * @param ctx Context.
	 * @param doc Original doc.
	 * @param variables Variables.
	 * @param constraints Constraints.
	 */
	new(CodeSnippetContext ctx, String doc, List<Variable> variables, List<Constraint> constraints) {
		this.ctx = ctx
		this.doc = doc
		this.variables = variables
		this.constraints = constraints
	}

	def sp() {
		" "
	}

	override toString() {
		'''
			/*
			 * «doc.text»
			 *
			«FOR v : variables.nullSafe»
				«sp»* @param «v.name» «v.superDoc»
			«ENDFOR»
			 *
			«FOR constraint : constraints.nullSafe»
				«IF constraint.exception != null»
					«sp»* @throws «constraint.exception.name» Thrown if the constraint was violated: «constraint.doc.text» 
				«ENDIF»
			«ENDFOR»
			 */
		'''
	}

}
