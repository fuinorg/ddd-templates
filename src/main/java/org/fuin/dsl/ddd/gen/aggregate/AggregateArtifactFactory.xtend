package org.fuin.dsl.ddd.gen.aggregate

import org.fuin.dsl.ddd.gen.base.AbstractSource
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AggregateArtifactFactory extends AbstractSource<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + aggregate.getName()).replace('.', '/') + ".java"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	def create(Aggregate aggregate, Namespace ns) {
		''' 
		«copyrightHeader» 
		package «ns.asPackage»;
		
		«_imports(aggregate)»
		
		«_typeDoc(aggregate)»
		public final class «aggregate.name» extends Abstract«aggregate.name» {
		
			/**
			 * Default constructor for loading the aggregate root from history. 
			 */
			public «aggregate.name»() {
				super();
			}
		
			«_constructorsDecl(aggregate)»
		
			«_childEntityLocatorMethods(aggregate)»
			
			«_methodsDecl(aggregate)»
		
			«_eventMethodsDecl(aggregate)»
		
		}
		'''	
	}

	override _constructorDecl(String internalTypeName, List<Variable> variables, Constraints constraints) {
		'''
		«_methodDoc("Constructor with all data.", variables, null)»
		public «internalTypeName»(«_paramsDecl(variables.nullSafe)») «_exceptions(exceptionList(constraints))»{
			super();
			// TODO Implement!
		}
		'''
	}
	
}