package org.fuin.dsl.ddd.gen.base

import java.util.Map

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*

/**
 * Options used in the generation process. 
 */
class GenerateOptions {

	/** Key to retrieve the copyright header. */
	public val static KEY_COPYRIGHT_HEADER = "copyrightHeader"

	/** Key for the name of the base package to prepend right before the context from the DSL (Type: String). */
	public val static KEY_BASE_PKG = "basepkg"

	/** Key for the name of a package to insert right after the context from the DSL (Type: String). */
	public val static KEY_PKG = "pkg"

	/** Key if to generate JPA annotations (Type: Boolean). */
	public val static KEY_JPA = "jpa"

	/** Key if to generate JAX-B annotations (Type: Boolean). */
	public val static KEY_JAXB = "jaxb"

	/** Key if to generate JAX-B elements instead of attributes. Used to harmonize JSON and XML structures (Type: Boolean). */
	public val static KEY_JAXB_ELEMENTS = "jaxb_elements"

	/** Key if to generate JSON-B annotations (Type: Boolean). */
	public val static KEY_JSONB = "jsonb"

	var String basePkg

	var String pkg

	var boolean jpa

	var boolean jaxb

	var boolean jaxbElements

	var boolean jsonb

	var String copyrightHeader

	/**
	 * Default constructor.
	 */
	private new() {
		super()
	}

	/**
	 * Constructor with map to copy.
	 * 
	 * @param varMap Variables to use for retrieving the options.
	 */
	protected new(Map<String, String> varMap) {
		super()

		basePkg = varMap.nullSafe.get(KEY_BASE_PKG)
		pkg = varMap.nullSafe.get(KEY_PKG)
		jpa = Boolean.valueOf(varMap.nullSafe.get(KEY_JPA))
		jaxb = Boolean.valueOf(varMap.nullSafe.get(KEY_JAXB))
		jaxbElements = Boolean.valueOf(varMap.nullSafe.get(KEY_JAXB_ELEMENTS))
		jsonb = Boolean.valueOf(varMap.nullSafe.get(KEY_JSONB))

		val String header = varMap.nullSafe.get(KEY_COPYRIGHT_HEADER)
		if (header === null) {
			copyrightHeader = ""
		}
		copyrightHeader = header

	}

	/**
	 * Returns the name of the base package to prepend right before the context from the DSL.
	 * 
	 * @return Base package name.
	 */
	public def String getBasePkg() {
		return basePkg
	}

	/**
	 * Returns the name of a package to insert right after the context from the DSL.
	 * 
	 * @return Package name.
	 */
	public def String getPkg() {
		return pkg
	}

	/**
	 * Determines if JPA annotations should be generated.
	 * 
	 * @return {@code true} if JPA annotations should be generated.
	 */
	public def boolean getJpa() {
		return jpa
	}

	/**
	 * Determines if JAX-B annotations should be generated.
	 * 
	 * @return {@code true} if XML binding annotations should be generated.
	 */
	public def boolean getJaxb() {
		return jaxb
	}

	/**
	 * Determines if '@XmlElement' annotations should be generated instead of '@XmlAttribute' for JAX-B.
	 * 
	 * @return {@code true} if element annotations should be generated.
	 */
	public def boolean getJaxbElements() {
		return jaxbElements
	}

	/**
	 * Determines if JSON-B annotations should be generated.
	 * 
	 * @return {@code true} if JSON binding annotations should be generated.
	 */
	public def boolean getJsonb() {
		return jsonb
	}

	/**
	 * Returns the copyright header to use.
	 * 
	 * @return Copyright header for source files.
	 */
	public def String getCopyrightHeader() {
		return copyrightHeader
	}

	/** 
	 * Returns a new builder instance. Convenience method to shorten the builder creation in the code.
	 * 
	 * @return New builder instance.
	 */
	static def Builder builder() {
		return new Builder()
	}

	/** 
	 * Returns an empty instance.
	 * 
	 * @return New instance.
	 */
	static def GenerateOptions empty() {
		return new GenerateOptions()
	}

	static class Builder {

		GenerateOptions obj

		public new() {
			super();
			obj = GenerateOptions.empty()
		}

		public new(GenerateOptions other) {
			this();
			obj.basePkg = other.basePkg
			obj.pkg = other.pkg
			obj.jpa = other.jpa
			obj.jaxb = other.jaxb
			obj.jaxbElements = other.jaxbElements
			obj.jsonb = other.jsonb
			obj.copyrightHeader = other.copyrightHeader
		}

		public def Builder withBasePkg(String basePkg) {
			obj.basePkg = basePkg
			return this
		}

		public def Builder withPkg(String pkg) {
			obj.pkg = pkg
			return this
		}

		public def Builder withJpa(boolean jpa) {
			obj.jpa = jpa
			return this
		}

		public def Builder withJpa() {
			obj.jpa = true
			return this
		}

		public def Builder withJaxb(boolean jaxb) {
			obj.jaxb = jaxb
			return this
		}

		public def Builder withJaxb() {
			obj.jaxb = true
			return this
		}

		public def Builder withJaxbElements(boolean jaxbElements) {
			obj.jaxbElements = jaxbElements
			return this
		}

		public def Builder withJaxbElements() {
			obj.jaxbElements = true
			return this
		}

		public def Builder withJsonb(boolean jsonb) {
			obj.jsonb = jsonb
			return this
		}

		public def Builder withJsonb() {
			obj.jsonb = true
			return this
		}

		public def Builder withCopyrightHeader(String header) {
			obj.copyrightHeader = header
			return this
		}

		public def GenerateOptions create() {
			val GenerateOptions options = obj
			obj = GenerateOptions.empty()
			return options
		}

	}

}
