package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.Collections
import java.util.HashSet
import java.util.List
import java.util.Set
import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.StringLiteral
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import java.util.StringTokenizer

abstract class AbstractSource {

	/**
	 * Returns the pure doc message
	 * 
	 * without slashes and stars in one
	 * line.
	 */
	def String text(String str) {
		var StringBuilder sb = new StringBuilder();
		var StringTokenizer tok = new StringTokenizer(str, "\r\n");
		while (tok.hasMoreTokens) {
			var String line = tok.nextToken();
			line = line.replace("/**", "");
			line = line.replace(" * ", "");
			line = line.replace("*/", "");
			sb.append(line);
			sb.append(" ");
		}
		var String result = sb.toString().replace("  ", " ").trim();
		return result;
	}

	def Set<String> createImportSet(EObject el) {
		var Set<String> types = new HashSet<String>();
		addJavaImport(types, el);		
		for (variable : el.eAllContents.toIterable.filter(typeof(Variable))) {
			if (variable.invariants != null) {
				for (call : variable.invariants.calls) {
					types.add(call.constraint.fqn);
				}
			}
			addJavaImport(types, variable.type);
			if (variable.multiplicity != null) {
				types.add(typeof(List).name);
			}
		}
		for (constraints : el.eAllContents.toIterable.filter(typeof(Constraints))) {
			if (constraints.calls != null) {
				for (call : constraints.calls) {
					var Constraint constraint = call.constraint;
					if (constraint.exception != null) {
						var Namespace ns = constraint.eContainer as Namespace;
						types.add(ns.name + "." + constraint.exception);
					}			
				}
				
			}
		}
		for (method : el.eAllContents.toIterable.filter(typeof(Method))) {
			if (method.refMethod != null) {
				types.addAll(createImportSet(method.refMethod));
			}
		}
		return types;
	}

	def String fqn(AbstractElement el) {
		var Namespace ns = el.eContainer as Namespace;
		return ns.name + "." + el.name;
	}

	def addJavaImport(Set<String> imports, EObject obj) {
		if (!(obj instanceof AbstractElement)) {
			return null;
		}
		var AbstractElement type = obj as AbstractElement;
		var String name = type.name;
		switch name {
			case 'UUID': imports.add('java.util.UUID')
			case 'Date': imports.add('org.joda.time.LocalDate')
			case 'Time': imports.add('org.joda.time.LocalTime')
			case 'Timestamp': imports.add('org.joda.time.LocalDateTime')
			case 'Currency': imports.add('java.util.Currency')
			case 'BigDecimal': imports.add('java.math.BigDecimal')
			case 'Byte': null
			case 'Short': null 
			case 'Integer': null
			case 'Long': null
			case 'Float': null
			case 'Double': null
			case 'Boolean': null
			case 'Character': null
			case 'String': null
			default: imports.add(fqn(type))
		}
	}

	def String asJavaType(Variable variable) {
		var String name = variable.type.name;		
		switch name {
			case 'Date': name = 'LocalDate'
			case 'Time': name = 'LocalTime'
			case 'Timestamp': name = 'LocalDateTime'
		}
		if (variable.multiplicity == null) {
			return name;
		}
		return "List<" + name + ">";
	}
	
	def String asJavaPrimitive(Variable variable) {
		var String name = variable.type.name;
		switch name {
			case 'Byte': name = 'byte'
			case 'Short': name = 'short'
			case 'Integer': name = 'int'
			case 'Long': name = 'long'
			case 'Float': name = 'float'
			case 'Double': name = 'double'
			case 'Boolean': name = 'boolean'
			case 'Character': name = 'char'
		}
		if (variable.multiplicity == null) {
			return name;
		}
		return name + "[]";
	}

	def _imports(EObject... elements) {
		if ((elements == null) || (elements.length == 0)) {
			return "";
		}
		var Set<String> imports = new HashSet<String>();
		for (el : elements) {
			imports.addAll(createImportSet(el));
		}
		'''
«FOR imp : imports»
import «imp»;
«ENDFOR»
'''
	}

	def _varsDecl(List<Variable> vars) {
		'''
«FOR variable : vars»
«_varDecl(variable)»

«ENDFOR»
'''
	}

	def _varDecl(Variable v) {
		if (v.invariants != null) {
			'''
«FOR cc : v.invariants.calls SEPARATOR ' '»
«_constraintCall(cc)»	
«ENDFOR»
private «asJavaType(v)» «v.name»;
'''
		} else {
			'''
private «asJavaType(v)» «v.name»;
'''
		}
	}

	def _constraintCall(ConstraintCall cc) {
		var constraint = cc.constraint;
		var vars = constraint.variables;
		var params = cc.params;

		if (vars.size == 0) {
			return '''@«constraint.name»''';
		} else if (vars.size == 1) {
			return '''@«constraint.name»(«str(params.last)»)''';
		} else if (vars.size() > 1) {
			var List<String> list = new ArrayList<String>();
			var int i = 0;
			do {
				var String name = vars.get(i).name;
				var String value = str(params.get(i));
				list.add(name + " = " + value);
				i = i + 1;
			} while (i < vars.size());
			return '''@«constraint.name»(«FOR str : list SEPARATOR ', '»«str»«ENDFOR»)''';
		}

	}

	def _constructorsDecl(AbstractEntity entity, List<Constructor> constructors) {
		'''
«FOR constructor : constructors»
«_constructorDecl(entity, constructor)»

«ENDFOR»
'''
	}

	def _constructorDecl(AbstractEntity entity, Constructor constructor) {
		'''
public «entity.name»(«_paramsDecl(constructor.variables)») «_exceptions(constructor)»{
	// TODO Implement	
}
'''
	}

	def _methodsDecl(List<Method> methods) {
		'''
«FOR method : methods»
«_methodDecl(method)»

«ENDFOR»
'''
	}

	def _methodDecl(Method method) {
		'''
public void «method.name»(«_paramsDecl(method.allVariables)») «_exceptions(method)»{
	// TODO Implement	
}
'''
	}

	def _abstractMethodsDecl(List<Method> methods) {
		'''
«FOR method : methods»
«_abstractMethodDecl(method)»

«ENDFOR»
'''
	}

	def _abstractMethodDecl(Method method) {
		'''
«method.doc»
public abstract void «method.name»(«_paramsDecl(method.allVariables)») «_exceptions(method)»;
'''
	}

	def _methodCall(List<Variable> vars, List<Literal> params) {
		if (vars.size == 0) {
			return "";
		} else if (vars.size == 1) {
			return str(params.last);
		} else if (vars.size() > 1) {
			return '''«FOR p : params SEPARATOR ', '»«str(p)»«ENDFOR»''';
		}
	}

	def _superCall(List<Variable> vars) {
		if (vars.size == 0) {
			return "super();";
		} else {
			return '''super(«FOR v : vars SEPARATOR ', '»«v.name»«ENDFOR»);''';
		}
	}

	def _paramsDecl(List<Variable> vars) {
		if (vars == null) {
			return "";
		}
		'''«FOR variable : vars SEPARATOR ', '»«_paramDecl(variable)»«ENDFOR»'''
	}

	def _paramDecl(Variable v) {
		if ((v.invariants != null) && (v.invariants.calls != null) && (v.invariants.calls.size > 0)) { 
			'''«FOR cc : v.invariants.calls SEPARATOR ' '»«_constraintCall(cc)»«ENDFOR» final «asJavaType(v)» «v.name»'''		
		} else {
			'''final «asJavaType(v)» «v.name»'''
		}
	}

	def _paramsAssignment(List<Variable> vars) {
		'''	
«FOR v : vars»	
this.«v.name» = «v.name»;
«ENDFOR»
'''
	}

	def _paramAssignment(Variable v) {
		'''	
this.«v.name» = «v.name»;
'''
	}

	def _settersGetters(String visibility, List<Variable> vars) {
		'''	
«FOR v : vars»
«_setter(visibility, v)»

«_getter(visibility, v)»

«ENDFOR»
'''
	}

	def _getters(String visibility, List<Variable> vars) {
		'''	
«FOR v : vars»
«_getter(visibility, v)»
«ENDFOR»
'''
	}

	def _getter(String visibility, Variable v) {
		'''	
«v.doc»
«visibility» «asJavaType(v)» get«v.name.toFirstUpper»() {
	return «v.name»;
}
'''
	}

	def _setters(String visibility, List<Variable> vars) {
		'''	
«FOR variable : vars»
«_setter(visibility, variable)»
«ENDFOR»
'''
	}

	def _setter(String visibility, Variable variable) {
		'''	
«variable.doc»
«visibility» void set«variable.name.toFirstUpper»(«asJavaType(variable)» «variable.name») {
	this.«variable.name» = «variable.name»;
}
'''
	}

	def String str(Literal literal) {
		if (literal instanceof StringLiteral) {
			return "\"" + literal.value + "\"";
		}
		return literal.value;
	}

	def  _exceptions(List<String> exceptions) {
		if ((exceptions == null) || (exceptions.size == 0)) {
			return ""		
		}
		'''throws «FOR ex : exceptions SEPARATOR ', '»«ex»«ENDFOR»'''				
	}

	def _exceptions(Constructor constructor) {
		_exceptions(exceptionList(constructor));
	}

	def _exceptions(Method method) {
		_exceptions(exceptionList(method));
	}

	def List<String> exceptionList(Constructor constructor) {
		exceptionList(constructor.constraints)
	}
	
	def List<String> exceptionList(Method method) {
		exceptionList(method.constraints)
	}

	def List<String> exceptionList(Constraints constraints) {
		if (constraints == null) {
			return Collections::emptyList;
		}
		var List<String> list = new ArrayList<String>();
		for (call : constraints.calls) {
			if (call.constraint != null)  {
				var String exception = call.constraint.exception;
				if (exception != null) {
					list.add(exception);
				}
			}
		} 
		return list;
	}

	def List<Variable> allVariables(Constraint constr) {
		var List<Variable> list = new ArrayList<Variable>();
		if (constr.variables != null) {
			list.addAll(constr.variables);
		}
		if ((constr.message != null) && (constr.message.variables != null)) {
			list.addAll(constr.message.variables);
		}
		return list;
	}

	def List<Variable> allVariables(Method method) {
		var List<Variable> list = new ArrayList<Variable>();
		if (method.refMethod != null) {
			var Variable parentVar = createVariableForParentType(method.refMethod);
			if (parentVar != null) {
				list.add(parentVar);
			}
			list.addAll(method.refMethod.allVariables);
		}
		list.addAll(method.variables);
		return list; 
	}
	
	def List<String> allExceptions(Method method) {
		var List<String> list = new ArrayList<String>();
		if (method.refMethod != null) {
			list.addAll(method.refMethod.allExceptions);
		}
		list.addAll(method.exceptionList);
		return list; 
	}

	def Variable createVariableForParentType(Method method) {
		if (method.eContainer instanceof AbstractVO) {
			var AbstractVO vo = method.eContainer as AbstractVO;
			var Variable v = DomainDrivenDesignDslFactory::eINSTANCE.createVariable();
			v.setName(vo.name.toFirstLower);
			v.setType(vo);
			return v;
		} else if (method.eContainer instanceof AbstractEntity) {
			var AbstractEntity entity = method.eContainer as AbstractEntity;
			var Variable v = DomainDrivenDesignDslFactory::eINSTANCE.createVariable();
			v.setName(entity.name.toFirstLower);
			v.setType(entity);
			return v;
		}
		return null;
	}

	def _eventAbstractMethodsDecl(List<Method> methods) {
		if (methods == null) {
			return "";
		}
'''
«FOR method : methods»
«_eventAbstractMethods(method.events)»
«ENDFOR»
'''
	}

	def _eventAbstractMethods(List<Event> events) {
		if (events == null) {
			return "";
		}
'''
«FOR event : events»
«_eventAbstractMethod(event)»

«ENDFOR»
'''
	}

	def _eventAbstractMethod(Event event) {
'''
protected abstract void handle(final «event.name» event);
'''
	}

	def _eventMethodsDecl(List<Method> methods) {
		if (methods == null) {
			return "";
		}
'''
«FOR method : methods»
«_eventMethods(method.events)»
«ENDFOR»
'''
	}

	def _eventMethods(List<Event> events) {
		if (events == null) {
			return "";
		}
'''
«FOR event : events»
«_eventMethod(event)»

«ENDFOR»
'''
	}

	def _eventMethod(Event event) {
'''
protected final void handle(final «event.name» event) {
	// TODO Handle event!
}
'''
	}

}
