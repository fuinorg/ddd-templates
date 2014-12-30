package org.fuin.dsl.ddd.gen.base

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*

abstract class AbstractSource<T> implements ArtifactFactory<T> {

	public val static KEY_COPYRIGHT_HEADER = "copyrightHeader"

	public val static KEY_BASE_PKG = "basepkg"
	
	public val static KEY_PKG = "pkg"

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
		return varMap.nullSafe.get("basepkg")
	}

	private def String getPkg() {
		return varMap.nullSafe.get("pkg")
	}

	def String getCopyrightHeader() {
		val String header = varMap.nullSafe.get("copyrightHeader")
		if (header == null) {
			return ""
		}
		return header
	}

	protected def String getVar(String key, String defaultVal) {
		val str = this.varMap.nullSafe.get(key)
		if (str == null) {
			return defaultVal
		}
		return str
	}

	def String contextPkg(String ctxName) {
		return getBasePkg() + "." + ctxName + "." + getPkg()
	}

	def String asPackage(Namespace ns) {
		if (getPkg() == null) {
			return getBasePkg() + "." + ns.context.name + "." + ns.name;
		}
		return getBasePkg() + "." + ns.context.name + "." + getPkg() + "." + ns.name;
	}

}
