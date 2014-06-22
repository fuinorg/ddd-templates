package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.gen.base.SrcAbstractChildEntityLocatorMethod;
import org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a multiple abstract child entity locator methods.
 */
@SuppressWarnings("all")
public class SrcAbstractChildEntityLocatorMethods implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final AbstractEntity entity;
  
  public SrcAbstractChildEntityLocatorMethods(final CodeSnippetContext ctx, final AbstractEntity entity) {
    this.ctx = ctx;
    this.entity = entity;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      Set<Entity> _childEntities = AbstractEntityExtensions.childEntities(this.entity);
      for(final Entity child : _childEntities) {
        SrcAbstractChildEntityLocatorMethod _srcAbstractChildEntityLocatorMethod = new SrcAbstractChildEntityLocatorMethod(this.ctx, child);
        _builder.append(_srcAbstractChildEntityLocatorMethod, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder.toString();
  }
}
