package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.Map;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcAbstractChildEntityLocatorMethod;
import org.fuin.dsl.ddd.gen.base.SrcChildEntityLocatorMethod;
import org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

@SuppressWarnings("all")
public abstract class AbstractSource<T extends Object> implements ArtifactFactory<T> {
  private String artifactName;
  
  private Map<String,String> varMap;
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
    Map<String,String> _varMap = config.getVarMap();
    this.varMap = _varMap;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public String getArtifactName() {
    return this.artifactName;
  }
  
  public String getBasePkg() {
    Map<String,String> _nullSafe = CollectionExtensions.<String, String>nullSafe(this.varMap);
    return _nullSafe.get("basepkg");
  }
  
  public String getPkg() {
    Map<String,String> _nullSafe = CollectionExtensions.<String, String>nullSafe(this.varMap);
    return _nullSafe.get("pkg");
  }
  
  public String getCopyrightHeader() {
    Map<String,String> _nullSafe = CollectionExtensions.<String, String>nullSafe(this.varMap);
    final String header = _nullSafe.get("copyrightHeader");
    boolean _equals = Objects.equal(header, null);
    if (_equals) {
      return "";
    }
    return header;
  }
  
  public String asPackage(final Namespace ns) {
    String _pkg = this.getPkg();
    boolean _equals = Objects.equal(_pkg, null);
    if (_equals) {
      String _basePkg = this.getBasePkg();
      String _plus = (_basePkg + ".");
      Context _context = EObjectExtensions.getContext(ns);
      String _name = _context.getName();
      String _plus_1 = (_plus + _name);
      String _plus_2 = (_plus_1 + ".");
      String _name_1 = ns.getName();
      return (_plus_2 + _name_1);
    }
    String _basePkg_1 = this.getBasePkg();
    String _plus_3 = (_basePkg_1 + ".");
    Context _context_1 = EObjectExtensions.getContext(ns);
    String _name_2 = _context_1.getName();
    String _plus_4 = (_plus_3 + _name_2);
    String _plus_5 = (_plus_4 + ".");
    String _pkg_1 = this.getPkg();
    String _plus_6 = (_plus_5 + _pkg_1);
    String _plus_7 = (_plus_6 + ".");
    String _name_3 = ns.getName();
    return (_plus_7 + _name_3);
  }
  
  public String asJavaType(final Variable variable) {
    Type _type = variable.getType();
    String name = _type.getName();
    boolean _matched = false;
    if (!_matched) {
      if (Objects.equal(name,"Date")) {
        _matched=true;
        name = "LocalDate";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Time")) {
        _matched=true;
        name = "LocalTime";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Timestamp")) {
        _matched=true;
        name = "LocalDateTime";
      }
    }
    String _multiplicity = variable.getMultiplicity();
    boolean _equals = Objects.equal(_multiplicity, null);
    if (_equals) {
      return name;
    }
    return (("List<" + name) + ">");
  }
  
  public String asJavaPrimitive(final Variable variable) {
    Type _type = variable.getType();
    String name = _type.getName();
    boolean _matched = false;
    if (!_matched) {
      if (Objects.equal(name,"Byte")) {
        _matched=true;
        name = "byte";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Short")) {
        _matched=true;
        name = "short";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Integer")) {
        _matched=true;
        name = "int";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Long")) {
        _matched=true;
        name = "long";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Float")) {
        _matched=true;
        name = "float";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Double")) {
        _matched=true;
        name = "double";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Boolean")) {
        _matched=true;
        name = "boolean";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Character")) {
        _matched=true;
        name = "char";
      }
    }
    String _multiplicity = variable.getMultiplicity();
    boolean _equals = Objects.equal(_multiplicity, null);
    if (_equals) {
      return name;
    }
    return (name + "[]");
  }
  
  public CharSequence _abstractChildEntityLocatorMethods(final CodeSnippetContext ctx, final AbstractEntity parent) {
    StringConcatenation _builder = new StringConcatenation();
    {
      Set<Entity> _childEntities = AbstractEntityExtensions.childEntities(parent);
      for(final Entity child : _childEntities) {
        SrcAbstractChildEntityLocatorMethod _srcAbstractChildEntityLocatorMethod = new SrcAbstractChildEntityLocatorMethod(ctx, child);
        _builder.append(_srcAbstractChildEntityLocatorMethod, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _childEntityLocatorMethods(final CodeSnippetContext ctx, final AbstractEntity parent) {
    StringConcatenation _builder = new StringConcatenation();
    {
      Set<Entity> _childEntities = AbstractEntityExtensions.childEntities(parent);
      for(final Entity child : _childEntities) {
        SrcChildEntityLocatorMethod _srcChildEntityLocatorMethod = new SrcChildEntityLocatorMethod(ctx, child);
        _builder.append(_srcChildEntityLocatorMethod, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _uniquelyNumberedException(final org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception ex) {
    CharSequence _xifexpression = null;
    int _cid = ex.getCid();
    boolean _greaterThan = (_cid > 0);
    if (_greaterThan) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("UniquelyNumberedException");
      _xifexpression = _builder;
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      _builder_1.append("Exception");
      _xifexpression = _builder_1;
    }
    return _xifexpression;
  }
}
