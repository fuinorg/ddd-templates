package org.fuin.dsl.ddd.gen.base;

import com.google.common.collect.Lists;
import java.util.Collections;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.MethodData;
import org.fuin.dsl.ddd.gen.base.SrcMethod;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.DomainDrivenDesignDslFactoryExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single abstract child entity locator method.
 */
@SuppressWarnings("all")
public class SrcAbstractChildEntityLocatorMethod implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final Entity entity;
  
  private final List<String> annotations = null;
  
  private final List<Variable> variables;
  
  private final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions = null;
  
  public SrcAbstractChildEntityLocatorMethod(final CodeSnippetContext ctx, final Entity entity) {
    this.ctx = ctx;
    this.entity = entity;
    EntityId _idType = entity.getIdType();
    EntityId _idType_1 = entity.getIdType();
    String _name = _idType_1.getName();
    String _firstLower = StringExtensions.toFirstLower(_name);
    final Variable variable = DomainDrivenDesignDslFactoryExtensions.createVariable(DomainDrivenDesignDslFactory.eINSTANCE, "Unique identifier of the child entity to find.", _idType, _firstLower, false);
    this.variables = Collections.<Variable>unmodifiableList(Lists.<Variable>newArrayList(variable));
    String _uniqueName = AbstractElementExtensions.uniqueName(entity);
    ctx.requiresReference(_uniqueName);
    EntityId _idType_2 = entity.getIdType();
    String _uniqueName_1 = AbstractElementExtensions.uniqueName(_idType_2);
    ctx.requiresReference(_uniqueName_1);
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    String _name = this.entity.getName();
    String _plus = ("Locates a child entity of type " + _name);
    String _plus_1 = (_plus + ".");
    String _name_1 = this.entity.getName();
    String _plus_2 = ("find" + _name_1);
    MethodData _methodData = new MethodData(_plus_1, this.annotations, "protected", true, 
      this.entity, _plus_2, this.variables, this.exceptions);
    SrcMethod _srcMethod = new SrcMethod(this.ctx, _methodData);
    _builder.append(_srcMethod, "");
    return _builder.toString();
  }
}
