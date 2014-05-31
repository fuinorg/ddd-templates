package org.fuin.dsl.ddd.gen.valueobject;

import com.google.common.base.Objects;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ValueObjectArtifactFactory extends AbstractSource<ValueObject> {
  public Class<? extends ValueObject> getModelType() {
    return ValueObject.class;
  }
  
  public GeneratedArtifact create(final ValueObject valueObject) throws GenerateException {
    try {
      EObject _eContainer = valueObject.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = valueObject.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(valueObject, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final ValueObject vo, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    String _asPackage = this.asPackage(ns);
    _builder.append(_asPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __imports = this._imports(vo);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __typeDoc = this._typeDoc(vo);
    _builder.append(__typeDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    {
      ExternalType _base = vo.getBase();
      boolean _equals = Objects.equal(_base, null);
      if (_equals) {
        String _name = vo.getName();
        CharSequence __xmlRootElement = this._xmlRootElement(_name);
        _builder.append(__xmlRootElement, "");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("public final class ");
    String _name_1 = vo.getName();
    _builder.append(_name_1, "");
    _builder.append(" ");
    String _name_2 = vo.getName();
    ExternalType _base_1 = vo.getBase();
    String _optionalExtendsForBase = this.optionalExtendsForBase(_name_2, _base_1);
    _builder.append(_optionalExtendsForBase, "");
    _builder.append("implements ValueObject {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private static final long serialVersionUID = 1000L;");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    ExternalType _base_2 = vo.getBase();
    boolean _equals_1 = Objects.equal(_base_2, null);
    CharSequence __varsDecl = this._varsDecl(vo, _equals_1);
    _builder.append(__varsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    String __optionalDeserializationConstructor = this._optionalDeserializationConstructor(vo);
    _builder.append(__optionalDeserializationConstructor, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __constructorsDecl = this._constructorsDecl(vo);
    _builder.append(__constructorsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = vo.getVariables();
    CharSequence __getters = this._getters("public final", _variables);
    _builder.append(__getters, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    String _name_3 = vo.getName();
    ExternalType _base_3 = vo.getBase();
    CharSequence __optionalBaseMethods = this._optionalBaseMethods(_name_3, _base_3);
    _builder.append(__optionalBaseMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
