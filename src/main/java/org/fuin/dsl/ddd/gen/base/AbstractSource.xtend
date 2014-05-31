package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.Collections
import java.util.HashSet
import java.util.List
import java.util.Map
import java.util.Set
import java.util.StringTokenizer
import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractMethod
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.StringLiteral
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig

abstract class AbstractSource<T> implements ArtifactFactory<T> {

	String artifactName;

	Map<String, String> varMap;

	override init(ArtifactFactoryConfig config) {
		artifactName = config.getArtifact()
		varMap = config.varMap;
	}

	override isIncremental() {
		true
	}

	def String getArtifactName() {
		return artifactName
	}

	def String getBasePkg() {
		return varMap.nullSafe.get("basepkg")
	}

	def String getPkg() {
		return varMap.nullSafe.get("pkg")
	}

	def String getCopyrightHeader() {
		val String header = varMap.nullSafe.get("copyrightHeader")
		if (header == null) {
			return ""
		}
		return header
	}

	/**
	 * Returns the pure doc message without slashes and stars in one line.
	 * 
	 * @param str JavaDoc comment. 
	 * 
	 * @return Plain single line text.
	 */
	def String text(String str) {
		if (str == null) {
			return "";
		}
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
		types.add('org.fuin.ddd4j.ddd.*')
		types.add('org.fuin.objects4j.vo.*')
		types.add('java.util.List')
		types.add('java.util.Locale') // TODO Workaround 
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
						types.add(ns.asPackage + "." + constraint.exception.name);
					}
				}

			}
		}
		for (method : el.eAllContents.toIterable.filter(typeof(Method))) {
			if (method.refMethod != null) {
				types.addAll(createImportSet(method.refMethod));
			}
		}
		for (constraintTarget : el.eAllContents.toIterable.filter(typeof(ConstraintTarget))) {
			addJavaImport(types, constraintTarget);
		}
		return types;
	}

	def String fqn(Event event) {
		var Namespace ns = event.namespace;
		return ns.asPackage + "." + event.name;
	}

	def String fqn(AbstractElement el) {
		var Namespace ns = el.namespace;
		return ns.asPackage + "." + el.name;
	}

	def Namespace getNamespace(EObject obj) {
		if (obj instanceof Namespace) {
			return obj
		}
		return getNamespace(obj.eContainer)
	}

	def Context getContext(EObject obj) {
		if (obj instanceof Context) {
			return obj
		}
		return getContext(obj.eContainer)
	}

	def String asPackage(Namespace ns) {
		if (getPkg() == null) {
			return getBasePkg() + "." + ns.context.name + "." + ns.name;
		}
		return getBasePkg() + "." + ns.context.name + "." + getPkg() + "." + ns.name;
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
			case 'Locale': imports.add('java.util.Locale')
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

	def String str(Literal literal) {
		if (literal instanceof StringLiteral) {
			return "\"" + literal.value + "\"";
		}
		return literal.value;
	}

	def List<String> exceptionList(Constraints constraints) {
		if (constraints == null) {
			return Collections::emptyList;
		}
		var List<String> list = new ArrayList<String>();
		for (call : constraints.calls) {
			if (call.constraint != null) {
				var String exception = call.constraint.exception.name;
				if (exception != null) {
					list.add(exception);
				}
			}
		}
		return list;
	}

	def Variable copyRenamed(Variable v, String name) {
		var Variable vv = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
		vv.setName(name);
		vv.setDoc(v.doc);
		vv.setNullable(v.nullable);
		vv.setType(v.type);
		vv.setMultiplicity(v.multiplicity);
		vv.setInvariants(v.invariants);
		vv.setOverridden(v.overridden);
		return vv;
	}

	def List<Variable> allVariables(Constraint constr) {
		var List<Variable> list = new ArrayList<Variable>();
		if (constr.variables != null) {
			list.addAll(constr.variables);
		}
		var ConstraintTarget target = constr.target;
		if (target instanceof ExternalType) {
			var ExternalType et = (target as ExternalType)
			var Variable vv = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
			vv.setName("vv");
			vv.setDoc("/** The validated value. */");
			vv.setType(et);
			list.add(vv);
		} else {
			var ValueObject vo = (target as ValueObject);
			if (vo.variables != null) {
				for (v : vo.variables) {
					var Variable vv = copyRenamed(v, "vv_" + v.name);
					list.add(vv);
				}
			}
		}
		return list;
	}

	def List<Variable> allVariables(Method method) {
		var List<Variable> list = new ArrayList<Variable>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			var Variable refVar = createVariableForRef(method.refMethod);
			if (refVar != null) {
				list.add(refVar);
			}
			list.addAll(method.refMethod.allVariables);
		}
		list.addAll(method.variables);
		return list;
	}

	def List<String> allExceptions(Method method) {
		var List<String> list = new ArrayList<String>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allExceptions);
		}
		if (method.constraints != null) {
			list.addAll(method.constraints.exceptionList);
		}
		return list;
	}

	def List<String> allExceptions(Constructor constructor) {
		var List<String> list = new ArrayList<String>();
		if (constructor.constraints != null) {
			list.addAll(constructor.constraints.exceptionList);
		}
		return list;
	}

	def Variable createVariableForRef(AbstractMethod method) {
		if (method.eContainer instanceof AbstractVO) {
			var AbstractVO vo = method.eContainer as AbstractVO;
			var Variable v = DomainDrivenDesignDslFactory::eINSTANCE.createVariable();
			v.setName(vo.name.toFirstLower);
			v.setType(vo);
			return v;
		} else if (method.eContainer instanceof AbstractEntity) {
			var ExternalType et = DomainDrivenDesignDslFactory::eINSTANCE.createExternalType();
			et.setName("EntityIdPath");
			var Variable v = DomainDrivenDesignDslFactory::eINSTANCE.createVariable();
			v.setName("entityIdPath");
			v.setType(et);
			return v;
		}
		return null;
	}

	def Variable first(List<Variable> variables) {
		if ((variables == null) || (variables.size() == 0)) {
			return null;
		}
		return variables.get(0);
	}

	def List<Variable> withoutFirst(List<Variable> variables) {
		var List<Variable> rest = new ArrayList<Variable>();
		if ((variables != null) && (variables.size() > 0)) {
			var count = 0;
			for (Variable v : variables) {
				if (count > 0) {
					rest.add(v);
				}
				count = count + 1;
			}
		}
		return rest;
	}

	def AbstractEntityId getEntityIdType(Event event) {
		var AbstractEntity abstractEntity = (event.eContainer.eContainer as AbstractEntity);
		if (abstractEntity instanceof Aggregate) {
			var Aggregate aggregate = (abstractEntity as Aggregate);
			return aggregate.idType;
		} else {
			var Entity entity = (abstractEntity as Entity);
			return entity.idType;
		}
	}

	def toXmlName(String name) {
		name.replaceAll('(.)(\\p{Upper})', '$1-$2').toLowerCase;
	}

	def toSqlUpper(String name) {
		name.replaceAll('(.)(\\p{Upper})', '$1_$2').toUpperCase;
	}

	def toSqlLower(String name) {
		name.replaceAll('(.)(\\p{Upper})', '$1_$2').toLowerCase;
	}

	def toSqlInitials(String name) {
		if (name == null || name.length == 0) {
			return name
		}
		val sb = new StringBuilder();
		val lname = toSqlLower(name)
		for (i : 0 .. lname.length - 1) {
			val ch = lname.charAt(i)
			if (i == 0) {
				sb.append(ch)
			} else if ((ch.compareTo('_') == 0) && (i < lname.length - 1)) {
				sb.append('_')
				sb.append(lname.charAt(i + 1))
			}
		}
		return sb.toString();
	}

	def String superDoc(Variable variable) {
		if (variable.doc == null) {
			variable.type.doc.text
		} else {
			return variable.doc.text
		}
	}

	def String doc(Type type) {
		if (type instanceof AbstractEntity) {
			return (type as AbstractEntity).doc
		} else if (type instanceof AbstractVO) {
			return (type as AbstractVO).doc
		}
		return type.name;
	}

	private def Set<Entity> childEntities(AbstractEntity parent) {
		var Set<Entity> childs = new HashSet<Entity>();
		for (v : parent.variables) {
			if (v.type instanceof Entity) {
				childs.add(v.type as Entity);
			}
		}
		return childs;
	}

	def <T> List<T> nullSafe(List<T> list) {
		if (list == null) {
			return Collections.emptyList;
		}
		return list
	}

	def <K, V> Map<K, V> nullSafe(Map<K, V> map) {
		if (map == null) {
			return Collections.emptyMap;
		}
		return map
	}

	def List<AbstractMethod> constructorsAndMethods(AbstractEntity entity) {
		val List<AbstractMethod> methods = new ArrayList<AbstractMethod>()
		methods.addAll(entity.constructors)
		methods.addAll(entity.methods)
		return methods
	}

	def List<Constraint> allConstraints(Method method) {
		val List<Constraint> list = new ArrayList<Constraint>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allConstraints);
		}
		if (method.constraints != null) {
			for (ConstraintCall cc : method.constraints.calls) {
				list.add(cc.constraint);
			}
		}
		return list;
	}

	def List<Constraint> allConstraints(Constructor constructor) {
		val List<Constraint> list = new ArrayList<Constraint>();
		if (constructor.constraints != null) {
			for (ConstraintCall cc : constructor.constraints.calls) {
				list.add(cc.constraint);
			}
		}
		return list;
	}

	// --- Source code fragments (Method names should start with an underscore '_') ---
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

	def _methodDoc(Constructor constructor) {
		return _methodDoc(constructor.doc, constructor.variables, constructor.allConstraints)
	}

	def _methodDoc(Method method) {
		return _methodDoc(method.doc, method.allVariables, method.allConstraints)
	}

	def _methodDoc(String doc, List<Variable> variables, List<Constraint> constraints) {
		'''
			/**
			 * «doc.text»
			 *
			«FOR v : variables.nullSafe»
				* @param «v.name» «v.superDoc» 
			«ENDFOR»
			 *
			«FOR constraint : constraints.nullSafe»
				«IF constraint.exception != null»
					* @throws «constraint.exception.name» Thrown if the constraint was violated: «constraint.doc.text» 
				«ENDIF»
			«ENDFOR»
			 */
		'''
	}

	def _typeDoc(InternalType internalType) {
		'''
			/**
			 * «internalType.doc.text»
			 */
		'''
	}

	def _varsDecl(InternalType internalType) {
		_varsDecl(internalType, false)
	}

	def _varsDecl(InternalType internalType, boolean xml) {
		'''
			«FOR variable : internalType.variables.nullSafe»
				«_varDecl(variable, xml)»
				
			«ENDFOR»
		'''
	}

	def _varDecl(Variable v) {
		_varDecl(v, false)
	}

	def _varDecl(Variable v, boolean xml) {
		if (v.invariants != null) {
			'''
				«FOR cc : v.invariants.calls SEPARATOR ' '»
					«_constraintCall(cc)»	
				«ENDFOR»
				«IF v.nullable == null»
					@NotNull
				«ENDIF»
				«IF xml»
					«_xmlAttributeOrElement(v)»			
				«ENDIF»
				private «asJavaType(v)» «v.name»;
			'''
		} else {
			'''
				«IF v.nullable == null»
					@NotNull
				«ENDIF»
				«IF xml»
					«_xmlAttributeOrElement(v)»			
				«ENDIF»
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

	def _constructorsDecl(InternalType internalType) {
		'''
			«FOR constructor : internalType.constructors.nullSafe»
				«_constructorDecl(internalType.name, constructor.variables, constructor.constraints)»
				
			«ENDFOR»
		'''
	}

	def _constructorsDecl(AbstractVO vo) {
		if (vo.constructors.nullSafe.size == 0) {
			_constructorDecl(vo.name, vo.variables, null)
		} else {
			_constructorsDecl(vo as InternalType)
		}
	}

	def _constructorDecl(String internalTypeName, List<Variable> variables, Constraints constraints) {
		'''
			«_methodDoc("Constructor with all data.", variables, null)»
			public «internalTypeName»(«_paramsDecl(variables.nullSafe)») «_exceptions(exceptionList(constraints))»{
				super();
				«_paramsAssignment(variables.nullSafe)»	
			}
		'''
	}

	def _methodsDecl(InternalType internalType) {
		'''
			«FOR method : internalType.methods.nullSafe»
				«_methodDecl(method)»
				
			«ENDFOR»
		'''
	}

	def _methodDecl(Method method) {
		'''
			«_methodDoc(method)»
			public final void «method.name»(«_paramsDecl(method.allVariables)») «_exceptions(method.allExceptions)»{
				// TODO Implement	
			}
		'''
	}

	def _methodCall(List<Variable> vars) {
		var List<Literal> params = new ArrayList<Literal>();
		for (v : vars) {
			var Literal name = DomainDrivenDesignDslFactory.eINSTANCE.createLiteral();
			name.setValue(v.name)
			params.add(name);
		}
		_methodCall(vars, params)
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
			'''«FOR cc : v.invariants.calls SEPARATOR ' '»«_constraintCall(cc)»«ENDFOR» «IF v.nullable == null»@NotNull	«ENDIF»final «asJavaType(
				v)» «v.name»'''
		} else {
			'''«IF v.nullable == null»@NotNull «ENDIF»final «asJavaType(v)» «v.name»'''
		}
	}

	def _paramsAssignment(List<Variable> vars) {
		'''	
			«FOR v : vars»	
				«IF v.nullable == null»
					Contract.requireArgNotNull("«v.name»", «v.name»);
				«ENDIF»
			«ENDFOR»
			«FOR v : vars»	
				«_paramAssignment(v)»
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
			/**
			 * Returns: «v.superDoc.text»
			 *
			 * @return Current value.
			 */
			 «IF v.nullable == null»@NeverNull«ENDIF»
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
			/**
			 * Sets: «variable.doc.text»
			 *
			 * @param «variable.name» Value to set.
			 */
			«visibility» void set«variable.name.toFirstUpper»(«IF variable.nullable == null»@NotNull «ENDIF»final «asJavaType(
				variable)» «variable.name») {
				«IF variable.nullable == null»
					Contract.requireArgNotNull("«variable.name»", «variable.name»);
				«ENDIF»
				this.«variable.name» = «variable.name»;
			}
		'''
	}

	def _exceptions(List<String> exceptions) {
		if ((exceptions == null) || (exceptions.size == 0)) {
			return ""
		}
		'''throws «FOR ex : exceptions SEPARATOR ', '»«ex»«ENDFOR»'''
	}

	def _eventAbstractMethodsDecl(AbstractEntity entity) {
		'''
			«FOR method : entity.constructorsAndMethods»
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
			/**
			 * Handles: «event.name».
			 *
			 * @param event Event to handle.
			 */
			protected abstract void handle(final «event.name» event);
		'''
	}

	def _eventMethodsDecl(AbstractEntity entity) {
		'''
			«FOR method : entity.constructorsAndMethods»
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
			@Override
			@EventHandler
			protected final void handle(final «event.name» event) {
				// TODO Handle event!
			}
		'''
	}

	def optionalExtendsForBase(String typeName, ExternalType base) {
		if (base == null) {
			return ""
		}
		if (base.name.equals("String")) {
			return "extends AbstractStringValueObject "
		}
		if (base.name.equals("UUID")) {
			return "extends AbstractUUIDVO "
		}
		if (base.name.equals("Integer")) {
			return "extends AbstractIntegerValueObject "
		}
		if (base.name.equals("Long")) {
			return "extends AbstractLongValueObject "
		}
		return ""
	}

	def _optionalBaseMethods(String typeName, ExternalType base) {
		if (base == null) {
			return ""
		}
		if (base.name.equals("String")) {
			return _optionalBaseMethodsString(typeName)
		}
		if (base.name.equals("UUID")) {
			return _optionalBaseMethodsUUID(typeName)
		}
		if (base.name.equals("Integer") || base.name.equals("Long")) {
			return _optionalBaseMethodsNumber(typeName, base.name)
		}
		return ""
	}

	def _optionalBaseMethodsNumber(String typeName, String baseName) {
		'''	
			/**
			 * Returns the information if a given «baseName» can be converted into
			 * an instance of this class. A <code>null</code> value returns <code>true</code>.
			 * 
			 * @param value
			 *            Value to check.
			 * 
			 * @return TRUE if it's a valid «baseName», else FALSE.
			 */
			public static boolean isValid(final «baseName» value) {
				if (value == null) {
					return true;
				}
				try {
					«baseName».valueOf(value);
				} catch (final NumberFormatException ex) {
					return false;
				}
				return true;
			}
			
			/**
			 * Parses a given «baseName» and returns a new instance of this class.
			 * 
			 * @param value
			 *            Value to convert. A <code>null</code> value returns
			 *            <code>null</code>.
			 * 
			 * @return Converted value.
			 */
			public static «typeName» valueOf(final «baseName» value) {
				if (value == null) {
					return null;
				}
				return new «typeName»(value);
			}
			
			@Override
			public Integer asBaseType() {
				return val;
			}
			
			@Override
			public String asString() {
				return "" + val;
			}
			
			/**
			 * Parses a given String and returns a new instance of this class.
			 * 
			 * @param value
			 *            Value to convert. A <code>null</code> value returns
			 *            <code>null</code>.
			 * 
			 * @return Converted value.
			 */
			public static «typeName» valueOf(final String value) {
				if (value == null) {
					return null;
				}
				return new «typeName»(«baseName».valueOf(value));
			}
			
		'''
	}

	def _optionalBaseMethodsString(String typeName) {
		'''	
			/**
			 * Returns the information if a given string can be converted into
			 * an instance of this class. A <code>null</code> value returns <code>true</code>.
			 * 
			 * @param value
			 *            Value to check.
			 * 
			 * @return TRUE if it's a valid string, else FALSE.
			 */
			public static boolean isValid(final String value) {
				if (value == null) {
					return true;
				}
				// TODO Verify the value is valid!
				return true;
			}
			
			/**
			 * Parses a given string and returns a new instance of this class.
			 * 
			 * @param value
			 *            Value to convert. A <code>null</code> value returns
			 *            <code>null</code>.
			 * 
			 * @return Converted value.
			 */
			public static «typeName» valueOf(final String value) {
				if (value == null) {
					return null;
				}
				// TODO Parse string value and return new instance! 
				// return new «typeName»(value);
				return null;
			}
		'''
	}

	def _optionalBaseMethodsUUID(String typeName) {
		'''	
			/**
			 * Returns the information if a given string can be converted into
			 * an instance of this class. A <code>null</code> value returns <code>true</code>.
			 * 
			 * @param value
			 *            Value to check.
			 * 
			 * @return TRUE if it's a valid string, else FALSE.
			 */
			public static boolean isValid(final String value) {
				return UUIDStrValidator.isValid(value);
			}
			
			/**
			 * Parses a given string and returns a new instance of this class.
			 * 
			 * @param value
			 *            Value to convert. A <code>null</code> value returns
			 *            <code>null</code>.
			 * 
			 * @return Converted value.
			 */
			public static «typeName» valueOf(final String value) {
				if (value == null) {
					return null;
				}
				return new «typeName»(UUID.fromString(value));
			}
		'''
	}

	/** 
	 * Generates source for a protected default constructor
	 * if no other constructor with no arguments exists.
	 * 
	 * @param internalType Type to optionally generate the default constructor for.
	 */
	def String _optionalDeserializationConstructor(InternalType internalType) {
		for (constructor : internalType.constructors.nullSafe) {
			if ((constructor == null) || (constructor.variables.nullSafe.size == 0)) {
				return ""
			}
		}
		'''	
			/**
			 * Default constructor only for de-serialization.
			 */
			protected «internalType.name»() {
				super();
			}
		'''
	}

	def String _valueObjectConverterSource(Namespace ns, String voTypeName, String targetTypeName,
		boolean implementsSingleEntityIdFactory) {
		'''	
			«copyrightHeader»
			package «ns.asPackage»;
			
			import javax.enterprise.context.ApplicationScoped;
			import javax.persistence.AttributeConverter;
			import javax.persistence.Converter;
			import org.fuin.objects4j.common.ThreadSafe;
			import org.fuin.objects4j.vo.AbstractValueObjectConverter;
			
			/**
			 * Converts «voTypeName» from/to «targetTypeName».
			 */
			@ThreadSafe
			@ApplicationScoped
			@Converter(autoApply = true)
			public final class «voTypeName»Converter extends
					AbstractValueObjectConverter<«targetTypeName», «voTypeName»> implements
					AttributeConverter<«voTypeName», «targetTypeName»>«IF implementsSingleEntityIdFactory», SingleEntityIdFactory«ENDIF» {
			
				@Override
				public Class<«targetTypeName»> getBaseTypeClass() {
					return «targetTypeName».class;
				}
			
				@Override
				public final Class<«voTypeName»> getValueObjectClass() {
					return «voTypeName».class;
				}
			
				@Override
				public final boolean isValid(final «targetTypeName» value) {
					return «voTypeName».isValid(value);
				}
			
				@Override
				public final «voTypeName» toVO(final «targetTypeName» value) {
					return «voTypeName».valueOf(value);
				}
			
				@Override
				public final «targetTypeName» fromVO(final «voTypeName» value) {
					if (value == null) {
						return null;
					}
					return value.asBaseType();
				}
			
			«IF implementsSingleEntityIdFactory»
				@Override
				public final EntityId createEntityId(final String id) {
					return «voTypeName».valueOf(id);
				}
			«ENDIF»
			
			}
		'''

	}

	def _xmlRootElement(String name) {
		'''
			@XmlRootElement(name = "«name.toXmlName»")
		'''
	}

	def _xmlAttributeOrElement(Variable v) {
		if (v.type instanceof ValueObject) {
			val ValueObject vo = (v.type as ValueObject);
			if (vo.base != null) {
				return _xmlAttribute(v)
			}
		} else if (v.type instanceof EntityId) {
			val EntityId id = (v.type as EntityId);
			if (id.base != null) {
				return _xmlAttribute(v)
			}
		} else if (v.type instanceof AggregateId) {
			val AggregateId id = (v.type as AggregateId);
			if (id.base != null) {
				return _xmlAttribute(v)
			}
		}
		return _xmlElement(v)
	}

	def _xmlElement(Variable v) {
		'''
			@XmlElement(name = "«v.name.toXmlName»")
		'''
	}

	def _xmlAttribute(Variable v) {
		'''
			@XmlAttribute(name = "«v.name.toXmlName»")
		'''
	}

	def _abstractChildEntityLocatorMethods(AbstractEntity parent) {
		'''
			«FOR child : parent.childEntities»
				«_abstractChildEntityLocatorMethod(child)»
				
			«ENDFOR»
		'''
	}

	def _abstractChildEntityLocatorMethod(AbstractEntity entity) {
		'''
			/**
			 * Locates the child entity of type «entity.name».
			 *
			 * @param «entity.idType.name.toFirstLower» Unique identifier of the child entity to find.
			 *
			 * @return Child entity or NULL if no entity with the given identifier was found.
			 */
			protected abstract «entity.name» find«entity.name»(final «entity.idType.name» «entity.idType.name.toFirstLower»);
			
		'''
	}

	def _childEntityLocatorMethods(AbstractEntity parent) {
		'''
			«FOR child : parent.childEntities»
				«_childEntityLocatorMethod(child)»
				
			«ENDFOR»
		'''
	}

	def _childEntityLocatorMethod(AbstractEntity entity) {
		'''
			@Override
			@ChildEntityLocator
			protected final «entity.name» find«entity.name»(final «entity.idType.name» «entity.idType.name.toFirstLower») {
				// TODO Implement!
				return null;
			}
			
		'''
	}

	def _get(String objName, Variable v) {
		if (objName == null) {
			'''get«v.name.toFirstUpper»()'''
		} else {
			'''«objName».get«v.name.toFirstUpper»()'''
		}
	}

	def _uniquelyNumberedIntf(Exception ex) {
		if (ex.cid > 0) {
			'''implements UniquelyNumbered '''
		}

	}

}
