package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintInstance
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddLiteralExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*

/**
 * Creates source code for a validation annotation.
 */
class SrcValidationAnnotation implements CodeSnippet {

	val CodeSnippetContext ctx
	var Constraint constraint
	var List<Variable> vars
	var List<Literal> params

	new(CodeSnippetContext ctx, ConstraintInstance ci) {
		this.ctx = ctx
		constraint = ci.constraint;
		vars = constraint.variables;
		params = ci.params;
		
		ctx.requiresReference(constraint.uniqueName)
		if (vars != null) {
			for (Variable v : vars) {
				ctx.requiresReference(v.type.uniqueName)
			}
		}
		
	}

	override toString() {
		if (vars.size == 0) {
			return '''@«constraint.name»''';
		} else if (vars.size == 1) {
			return '''@«constraint.name»(«params.last.str»)''';
		} else if (vars.size() > 1) {
			var List<String> list = new ArrayList<String>();
			var int i = 0;
			do {
				var String name = vars.get(i).name;
				var String value = params.get(i).str;
				list.add(name + " = " + value);
				i = i + 1;
			} while (i < vars.size());
			return '''@«constraint.name»(«FOR str : list SEPARATOR ', '»«str»«ENDFOR»)''';
		}
	}

}
