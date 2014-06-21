package org.fuin.dsl.ddd.gen.base;

import com.google.common.collect.Lists;
import java.util.Collections;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.MethodData;
import org.fuin.dsl.ddd.gen.base.SrcMethod;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.DomainDrivenDesignDslFactoryExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single child entity locator method.
 */
@SuppressWarnings("all")
public class SrcChildEntityLocatorMethod implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final ReturnType returnType;
  
  private final List<String> annotations;
  
  private final List<Variable> variables;
  
  private final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions = null;
  
  public SrcChildEntityLocatorMethod(final CodeSnippetContext ctx, final Entity entity) {
    this.ctx = ctx;
    ReturnType _createReturnType = DomainDrivenDesignDslFactory.eINSTANCE.createReturnType();
    this.returnType = _createReturnType;
    this.returnType.setType(entity);
    this.annotations = Collections.<String>unmodifiableList(Lists.<String>newArrayList("@Override", "@ChildEntityLocator"));
    EntityId _idType = entity.getIdType();
    EntityId _idType_1 = entity.getIdType();
    String _name = _idType_1.getName();
    String _firstLower = StringExtensions.toFirstLower(_name);
    Variable _createVariable = DomainDrivenDesignDslFactoryExtensions.createVariable(DomainDrivenDesignDslFactory.eINSTANCE, _idType, _firstLower, false);
    this.variables = Collections.<Variable>unmodifiableList(Lists.<Variable>newArrayList(_createVariable));
    String _uniqueName = AbstractElementExtensions.uniqueName(entity);
    ctx.requiresReference(_uniqueName);
    EntityId _idType_2 = entity.getIdType();
    String _uniqueName_1 = AbstractElementExtensions.uniqueName(_idType_2);
    ctx.requiresReference(_uniqueName_1);
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    Type _type = this.returnType.getType();
    String _name = _type.getName();
    String _plus = ("find" + _name);
    MethodData _methodData = new MethodData(null, this.annotations, 
      "protected final", false, this.returnType, _plus, this.variables, this.exceptions);
    SrcMethod _srcMethod = new SrcMethod(this.ctx, _methodData);
    _builder.append(_srcMethod, "");
    return _builder.toString();
  }
}
