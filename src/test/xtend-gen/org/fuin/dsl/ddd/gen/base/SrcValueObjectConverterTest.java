package org.fuin.dsl.ddd.gen.base;

import javax.inject.Inject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcValueObjectConverterTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testNullObjName() {
  }
}
