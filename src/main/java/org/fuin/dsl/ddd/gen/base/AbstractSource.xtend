package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Map
import java.util.Set
import org.eclipse.emf.ecore.EObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.LiteralExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

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
			public «internalTypeName»(«_paramsDecl(variables.nullSafe)») «_exceptions(constraints.exceptionList)»{
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
			return params.last.str;
		} else if (vars.size() > 1) {
			return '''«FOR p : params SEPARATOR ', '»«p.str»«ENDFOR»''';
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

	def _settersGetters(CodeSnippetContext ctx, String visibility, List<Variable> vars) {
		'''	
			«FOR v : vars»
				«new SrcSetter(ctx, visibility, v)»
				
				«new SrcGetter(ctx, visibility, v)»
				
			«ENDFOR»
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

	def _uniquelyNumberedException(Exception ex) {
		if (ex.cid > 0) {
			'''UniquelyNumberedException'''
		} else {
			'''Exception'''
		}

	}

}
