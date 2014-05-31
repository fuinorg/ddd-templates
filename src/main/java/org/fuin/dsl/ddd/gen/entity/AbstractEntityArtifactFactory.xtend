package org.fuin.dsl.ddd.gen.entity

import org.fuin.dsl.ddd.gen.base.AbstractSource
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AbstractEntityArtifactFactory extends AbstractSource<Entity> {

	override getModelType() {
		typeof(Entity)
	}
	
	override create(Entity entity) throws GenerateException {
        val Namespace ns = entity.eContainer() as Namespace;
        val filename = (ns.asPackage + ".Abstract" + entity.getName()).replace('.', '/') + ".java";
        return new GeneratedArtifact(artifactName, filename, create(entity, ns).toString().getBytes("UTF-8"));
	}

	def create(Entity entity, Namespace ns) {
		''' 
		«copyrightHeader»
		package «ns.asPackage»;
		
		«_imports(entity)»
		
		«_typeDoc(entity)»
		public abstract class Abstract«entity.name» extends AbstractEntity<«entity.root.idType.name», «entity.root.name», «entity.idType.name»> {

			private «entity.idType.name» id;

			«_varsDecl(entity)»
		
			«_constructorsDecl(entity, entity.constructors)»
		
			@Override
			public final EntityType getType() {				
				return «entity.idType.name».TYPE;
			}
		
			@Override
			public final «entity.idType.name» getId() {
				return id;
			}
		
			«_settersGetters("protected final", entity.variables)»
		
			«_abstractChildEntityLocatorMethods(entity)»
			
			«_eventAbstractMethodsDecl(entity)»
		
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
		public Abstract«entity.name»(@NotNull final «entity.root.name» rootAggregate, «_paramsDecl(constructor.variables)») «_exceptions(constructor.allExceptions)»{
			super(rootAggregate);
			«_paramsAssignment(constructor.variables)»	
		}
		'''
	}

}
