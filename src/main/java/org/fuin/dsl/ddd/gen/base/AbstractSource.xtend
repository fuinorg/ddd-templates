package org.fuin.dsl.ddd.gen.base

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*

abstract class AbstractSource<T> implements ArtifactFactory<T> {

	public val static KEY_COPYRIGHT_HEADER = "copyrightHeader"

	public val static KEY_BASE_PKG = "basepkg"
	
	public val static KEY_PKG = "pkg"

	public val static KEY_JPA = "jpa"

	public val static KEY_JAXB = "jaxb"

	public val static KEY_JSONB = "jsonb"

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

	private def String getBasePkg() {
		return varMap.nullSafe.get(KEY_BASE_PKG)
	}

	private def String getPkg() {
		return varMap.nullSafe.get(KEY_PKG)
	}

	def boolean getJpa() {		
		return Boolean.valueOf(varMap.nullSafe.get(KEY_JPA))
	}

	def boolean getJaxb() {
		return Boolean.valueOf(varMap.nullSafe.get(KEY_JAXB))
	}

	def boolean getJsonb() {
		return Boolean.valueOf(varMap.nullSafe.get(KEY_JSONB))
	}
	
	def String getCopyrightHeader() {
		val String header = varMap.nullSafe.get(KEY_COPYRIGHT_HEADER)
		if (header === null) {
			return ""
		}
		return header
	}

	protected def String getVar(String key, String defaultVal) {
		val str = this.varMap.nullSafe.get(key)
		if (str === null) {
			return defaultVal
		}
		return str
	}

	def String contextPkg(String ctxName) {
		if (getPkg() === null) {
			return getBasePkg() + "." + ctxName
		}
		return getBasePkg() + "." + ctxName + "." + getPkg()
	}

	def String asPackage(Namespace ns) {
		if (getPkg() === null) {
			return getBasePkg() + "." + ns.context.name + "." + ns.name;
		}
		return getBasePkg() + "." + ns.context.name + "." + getPkg() + "." + ns.name;
	}

}
