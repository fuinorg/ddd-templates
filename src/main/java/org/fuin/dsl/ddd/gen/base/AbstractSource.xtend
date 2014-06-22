package org.fuin.dsl.ddd.gen.base

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*

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

	def _optionalBaseMethods(CodeSnippetContext ctx, AbstractVO vo) {
		if (vo == null) {
			return ""
		}
		if (vo.baseType == null) {
			return ""
		}
		val String typeName = vo.name
		val ExternalType base = vo.baseType
		
		if (base.name.equals("String")) {
			return _optionalBaseMethodsString(typeName)
		}
		if (base.name.equals("UUID")) {
			return _optionalBaseMethodsUUID(typeName)
		}
		if (base.name.equals("Integer") || base.name.equals("Long")) {
			return new SrcVoBaseMethodsNumber(ctx, vo).toString()
		}
		return ""
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

	def _abstractChildEntityLocatorMethods(CodeSnippetContext ctx, AbstractEntity parent) {
		'''
			«FOR child : parent.childEntities»
				«new SrcAbstractChildEntityLocatorMethod(ctx, child)»
				
			«ENDFOR»
		'''
	}

	def _childEntityLocatorMethods(CodeSnippetContext ctx, AbstractEntity parent) {
		'''
			«FOR child : parent.childEntities»
				«new SrcChildEntityLocatorMethod(ctx, child)»
				
			«ENDFOR»
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
