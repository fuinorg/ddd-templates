package org.fuin.dsl.ddd.gen.extensions

import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.ConstructorParam

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Provides extension methods for AbstractVO.
 */
class AbstractVOExtensions {

	/**
	 * Returns the base type for a value object.
	 * 
	 * @param vo Value object.
	 * 
	 * @return Base type or null.
	 */	
	def static ExternalType baseType(AbstractVO vo) {
		if (vo instanceof AggregateId) {
			return vo.base
		}
		if (vo instanceof EntityId) {
			return vo.base
		}
		if (vo instanceof ValueObject) {
			return vo.base
		}
		return null
	}
	
	
	/**
	 * Returns the base type name for a value object.
	 * 
	 * @param vo Value object.
	 * 
	 * @return Name or null.
	 */	
	def static String baseTypeName(AbstractVO vo) {
		if (vo.baseType == null) {
			return null
		} else {
			return vo.baseType.name
		}
	}

	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param constructor Constructor with list of variables.
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(AbstractVO constructor) {
		return parameters(constructor, false)
	}

	/**
	 * Creates a new constructor parameter list from the variables.
	 * 
	 * @param constructor Constructor with list of variables.
	 * @param passToSuper Defines if all variables should be passed to the super call
	 * 
	 * @return Constructor parameter list
	 */
	def static List<ConstructorParam> parameters(AbstractVO constructor, boolean passToSuper) {
		return constructor.variables.parameters(passToSuper)
	}
	
}
