package org.fuin.dsl.ddd.gen.extensions;

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;

/**
 * Provides extension methods for AbstractVO.
 */
@SuppressWarnings("all")
public class AbstractVOExtensions {
  /**
   * Returns the base type for a value object.
   * 
   * @param vo Value object.
   * 
   * @return Base type or null.
   */
  public static ExternalType baseType(final AbstractVO vo) {
    if ((vo instanceof AggregateId)) {
      return ((AggregateId) vo).getBase();
    }
    if ((vo instanceof EntityId)) {
      return ((EntityId) vo).getBase();
    }
    if ((vo instanceof ValueObject)) {
      return ((ValueObject) vo).getBase();
    }
    return null;
  }
}
