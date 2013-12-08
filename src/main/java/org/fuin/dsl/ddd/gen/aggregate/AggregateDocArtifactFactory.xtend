package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AggregateDocArtifactFactory extends AbstractSource implements ArtifactFactory<Aggregate> {

	String artifactName;

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override init(ArtifactFactoryConfig config) {
		artifactName = config.getArtifact()
	}
	
	override isIncremental() {
		true
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.getName() + "." + aggregate.getName()).replace('.', '/') + ".html"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	def create(Aggregate aggregate, Namespace ns) {
		'''
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>«ns.name».«aggregate.name»</title>
			</head>
			<body>
				«ns.name».«aggregate.name»
				<table border="1">
				«FOR variable : aggregate.variables»
					<tr><td>«variable.name»</td><td>«variable.type.name»</td><td>«variable.doc.text»</td></tr>
				«ENDFOR»
				</table>
			</body>
		</html>
		'''	
	}
	
}