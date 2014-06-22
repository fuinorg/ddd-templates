package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcAbstractChildEntityLocatorMethod;
import org.fuin.dsl.ddd.gen.base.SrcChildEntityLocatorMethod;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethodsNumber;
import org.fuin.dsl.ddd.gen.extensions.AbstractEntityExtensions;
import org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions;
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
  
  public CharSequence _optionalBaseMethods(final CodeSnippetContext ctx, final AbstractVO vo) {
    boolean _equals = Objects.equal(vo, null);
    if (_equals) {
      return "";
    }
    ExternalType _baseType = AbstractVOExtensions.baseType(vo);
    boolean _equals_1 = Objects.equal(_baseType, null);
    if (_equals_1) {
      return "";
    }
    final String typeName = vo.getName();
    final ExternalType base = AbstractVOExtensions.baseType(vo);
    String _name = base.getName();
    boolean _equals_2 = _name.equals("String");
    if (_equals_2) {
      return this._optionalBaseMethodsString(typeName);
    }
    String _name_1 = base.getName();
    boolean _equals_3 = _name_1.equals("UUID");
    if (_equals_3) {
      return this._optionalBaseMethodsUUID(typeName);
    }
    boolean _or = false;
    String _name_2 = base.getName();
    boolean _equals_4 = _name_2.equals("Integer");
    if (_equals_4) {
      _or = true;
    } else {
      String _name_3 = base.getName();
      boolean _equals_5 = _name_3.equals("Long");
      _or = _equals_5;
    }
    if (_or) {
      SrcVoBaseMethodsNumber _srcVoBaseMethodsNumber = new SrcVoBaseMethodsNumber(ctx, vo);
      return _srcVoBaseMethodsNumber.toString();
    }
    return "";
  }
  
  public CharSequence _optionalBaseMethodsString(final String typeName) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns the information if a given string can be converted into");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* an instance of this class. A <code>null</code> value returns <code>true</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to check.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return TRUE if it\'s a valid string, else FALSE.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static boolean isValid(final String value) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// TODO Verify the value is valid!");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given string and returns a new instance of this class.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(typeName, "");
    _builder.append(" valueOf(final String value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// TODO Parse string value and return new instance! ");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// return new ");
    _builder.append(typeName, "\t");
    _builder.append("(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _optionalBaseMethodsUUID(final String typeName) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns the information if a given string can be converted into");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* an instance of this class. A <code>null</code> value returns <code>true</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to check.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return TRUE if it\'s a valid string, else FALSE.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static boolean isValid(final String value) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return UUIDStrValidator.isValid(value);");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given string and returns a new instance of this class.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(typeName, "");
    _builder.append(" valueOf(final String value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return new ");
    _builder.append(typeName, "\t");
    _builder.append("(UUID.fromString(value));");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  /**
   * Generates source for a protected default constructor
   * if no other constructor with no arguments exists.
   * 
   * @param internalType Type to optionally generate the default constructor for.
   */
  public String _optionalDeserializationConstructor(final InternalType internalType) {
    String _xblockexpression = null;
    {
      EList<Constructor> _constructors = internalType.getConstructors();
      List<Constructor> _nullSafe = CollectionExtensions.<Constructor>nullSafe(_constructors);
      for (final Constructor constructor : _nullSafe) {
        boolean _or = false;
        boolean _equals = Objects.equal(constructor, null);
        if (_equals) {
          _or = true;
        } else {
          EList<Variable> _variables = constructor.getVariables();
          List<Variable> _nullSafe_1 = CollectionExtensions.<Variable>nullSafe(_variables);
          int _size = _nullSafe_1.size();
          boolean _equals_1 = (_size == 0);
          _or = _equals_1;
        }
        if (_or) {
          return "";
        }
      }
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/**");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("* Default constructor only for de-serialization.");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("protected ");
      String _name = internalType.getName();
      _builder.append(_name, "");
      _builder.append("() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("super();");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
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
