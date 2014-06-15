package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.LiteralExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MethodExtensions.*

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

	def String asPackage(Namespace ns) {
		if (getPkg() == null) {
			return getBasePkg() + "." + ns.context.name + "." + ns.name;
		}
		return getBasePkg() + "." + ns.context.name + "." + getPkg() + "." + ns.name;
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
	def _constructorsDecl(CodeSnippetContext ctx, InternalType internalType) {
		'''
			«FOR constructor : internalType.constructors.nullSafe»
				«_constructorDecl(ctx, internalType.name, constructor.variables, constructor.constraints)»
				
			«ENDFOR»
		'''
	}

	def _constructorsDecl(CodeSnippetContext ctx, AbstractVO vo) {
		if (vo.constructors.nullSafe.size == 0) {
			_constructorDecl(ctx, vo.name, vo.variables, null)
		} else {
			_constructorsDecl(ctx, vo as InternalType)
		}
	}

	def _constructorDecl(CodeSnippetContext ctx, String internalTypeName, List<Variable> variables,
		Constraints constraints) {
		'''
			«new SrcMethodJavaDoc(ctx, "Constructor with all data.", variables, constraints.list)»
			public «internalTypeName»(«_paramsDecl(ctx, variables.nullSafe)») «new SrcThrowsExceptions(ctx,
				constraints.exceptionList)»{
				super();
				«new SrcParamsAssignment(ctx, variables.nullSafe)»	
			}
		'''
	}

	def _methodsDecl(CodeSnippetContext ctx, InternalType internalType) {
		'''
			«FOR method : internalType.methods.nullSafe»
				«_methodDecl(ctx, method)»
				
			«ENDFOR»
		'''
	}

	def _methodDecl(CodeSnippetContext ctx, Method method) {
		'''
			«new SrcMethodJavaDoc(ctx, method)»
			public final void «method.name»(«_paramsDecl(ctx, method.allVariables)») «new SrcThrowsExceptions(ctx,
				method.allExceptions)»{
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

	def _paramsDecl(CodeSnippetContext ctx, List<Variable> vars) {
		if (vars == null) {
			return "";
		}
		'''«FOR variable : vars SEPARATOR ', '»«_paramDecl(ctx, variable)»«ENDFOR»'''
	}

	def _paramDecl(CodeSnippetContext ctx, Variable v) {
		if ((v.invariants != null) && (v.invariants.calls != null) && (v.invariants.calls.size > 0)) {
			'''«FOR cc : v.invariants.calls SEPARATOR ' '»«new SrcValidationAnnotation(ctx, cc)»«ENDFOR» «IF v.nullable ==
				null»@NotNull	«ENDIF»final «asJavaType(v)» «v.name»'''
		} else {
			'''«IF v.nullable == null»@NotNull «ENDIF»final «asJavaType(v)» «v.name»'''
		}
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
