package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintInstance
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
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
	var List<Attribute> vars
	var List<Literal> params

	new(CodeSnippetContext ctx, ConstraintInstance ci) {
		this.ctx = ctx
		constraint = ci.constraint;
		vars = constraint.attributes;
		params = ci.params;
		
		if (constraint.uniqueName.startsWith("org.fuin.constr")) {
			for (String pkg : constraint.pkg) {
				ctx.requiresReference(pkg)
			}			
		} else {
			ctx.requiresReference(constraint.uniqueName)
			if (vars !== null) {
				for (Attribute v : vars) {
					ctx.requiresReference(v.type.uniqueName)
				}
			}
		}
	}

	override toString() {
		if (constraint.uniqueName.startsWith("org.fuin.constr")) {
			return constraint.annotation
		} else {	
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

	def Literal findParamByName(String nameToFind) {
		for (var i = 0 ; i < vars.size(); i++) {
			val String nameFound = vars.get(i).name;
			if (nameFound.equals(nameToFind)) {
				return params.get(i)
			}
		}
		throw new IllegalStateException("Cannot find parameter '" + nameToFind + "' in constraint '" + constraint.name + "' instance")
	}


	def String annotation(Constraint constr) {
		switch constr.name {
  			case "MinValue"       : '''@DecimalMin(«findParamByName("expected").str»)'''
  			case "MaxValue"       : '''@DecimalMax(«findParamByName("expected").str»)'''
  			case "ValueRange"     : '''
  									@DecimalMin(«findParamByName("min").str»)
  									@DecimalMax(«findParamByName("max").str»)
  									'''
  			case "Pattern"        : '''@Pattern(regexp=«findParamByName("expression").str»)'''
  			case "MinLength"      : '''@Size(min=«findParamByName("expected").value»)'''
  			case "MaxLength"      : '''@Size(max=«findParamByName("expected").value»)'''
  			case "ExactLength"    : '''@Size(min=«findParamByName("expected").value», max=«findParamByName("expected").value»)'''
  			case "Length"         : '''@Size(min=«findParamByName("min").value», max=«findParamByName("max").value»)'''
  			default               : '''@«constr.name»'''
		}
	}

	def List<String> pkg(Constraint constr) {
		val list = new ArrayList<String>()
		val p = "javax.validation.constraints."
		switch constr.name {
  			case "MaxValue"    : list.add(p + "DecimalMax")
  			case "MinValue"    : list.add(p + "DecimalMin")
  			case "ValueRange"  : { list.add(p + "DecimalMin"); list.add(p + "DecimalMax") }  				                 
  			case "MaxLength"   : list.add(p + "Size")
  			case "MinLength"   : list.add(p + "Size")
  			case "ExactLength" : list.add(p + "Size")
  			case "Length"      : list.add(p + "Size")
  			default            : list.add(p + constr.name)
		} 
		return list
	}

}
