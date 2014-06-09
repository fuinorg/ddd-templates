package org.fuin.dsl.ddd.gen.entity

import java.util.List
import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions.*

class EntityArtifactFactory extends AbstractSource<Entity> {

	override getModelType() {
		typeof(Entity)
	}

	override create(Entity entity, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		val Namespace ns = entity.eContainer() as Namespace;
		val filename = (ns.asPackage + '.' + entity.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(entity, ns).toString().getBytes("UTF-8"));
	}

	def create(Entity entity, Namespace ns) {
		''' 
			«copyrightHeader»
			package «ns.asPackage»;
			
			«_imports(entity)»
			
			«_typeDoc(entity)»
			public final class «entity.name» extends Abstract«entity.name» {
			
				«_constructorsDecl(entity, entity.constructors)»
			
				«_childEntityLocatorMethods(entity)»
				
				«_methodsDecl(entity)»
			
				«_eventMethodsDecl(entity)»
			
			}
		'''
	}

	def _constructorsDecl(Entity entity, List<Constructor> constructors) {
		'''
			«FOR constructor : constructors»
				«_constructorDecl(entity, constructor)»
				
			«ENDFOR»
		'''
	}

	def _constructorDecl(Entity entity, Constructor constructor) {
		'''
			/**
			 * «constructor.doc.text»
			 *
			 * @param rootAggregate The root aggregate of this entity.
			«FOR v : constructor.variables»
				* @param «v.name» «v.superDoc» 
			«ENDFOR»
			 */
			public «entity.name»(final «entity.root.name» rootAggregate, «_paramsDecl(constructor.variables)») «_exceptions(
				constructor.allExceptions)»{
				«_superCall(constructor.variables)»	
			}
		'''
	}

	override _superCall(List<Variable> vars) {
		if (vars.size == 0) {
			return "super(rootAggregate);";
		} else {
			return '''super(rootAggregate, «FOR v : vars SEPARATOR ', '»«v.name»«ENDFOR»);''';
		}
	}

}
