package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractMethod
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity

/**
 * Provides extension methods for AbstractEntity.
 */
class AbstractEntityExtensions {

	/**
	 * Returns a list of all constructors and methods.
	 * 
	 * @param entity Entity to return all constructors and methods for.
	 * 
	 * @return List of all constructors and methods.
	 */
	def static List<AbstractMethod> constructorsAndMethods(AbstractEntity entity) {
		val List<AbstractMethod> methods = new ArrayList<AbstractMethod>()
		methods.addAll(entity.constructors)
		methods.addAll(entity.methods)
		return methods
	}

	/**
	 * Returns a list of all direct child entities for an entity.
	 * 
	 * @param parent Direct parent with references to entities.
	 * 
	 * @return List of directly referenced child entities.
	 */
	def static Set<Entity> childEntities(AbstractEntity parent) {
		var Set<Entity> childs = new HashSet<Entity>();
		for (v : parent.variables) {
			if (v.type instanceof Entity) {
				childs.add(v.type as Entity);
			}
		}
		return childs;
	}

}
