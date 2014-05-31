package org.fuin.dsl.ddd.gen.entityid;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class EntityIdArtifactFactory extends AbstractSource<EntityId> {
  public Class<? extends EntityId> getModelType() {
    return EntityId.class;
  }
  
  public GeneratedArtifact create(final EntityId entityId) throws GenerateException {
    try {
      EObject _eContainer = entityId.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = entityId.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(entityId, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final EntityId id, final Namespace ns) {
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
    CharSequence __imports = this._imports(id);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __typeDoc = this._typeDoc(id);
    _builder.append(__typeDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("@Immutable");
    _builder.newLine();
    _builder.append("@XmlJavaTypeAdapter(");
    String _name = id.getName();
    _builder.append(_name, "");
    _builder.append("Converter.class)");
    _builder.newLineIfNotEmpty();
    _builder.append("public final class ");
    String _name_1 = id.getName();
    _builder.append(_name_1, "");
    _builder.append(" ");
    String _name_2 = id.getName();
    ExternalType _base = id.getBase();
    String _optionalExtendsForBase = this.optionalExtendsForBase(_name_2, _base);
    _builder.append(_optionalExtendsForBase, "");
    _builder.append("implements EntityId, ValueObject {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private static final long serialVersionUID = 1000L;");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("/** Name that identifies the entity uniquely within the context. */\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public static final EntityType TYPE = new StringBasedEntityType(\"");
    Entity _entity = id.getEntity();
    String _name_3 = _entity.getName();
    _builder.append(_name_3, "\t");
    _builder.append("\");");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __varsDecl = this._varsDecl(id);
    _builder.append(__varsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    String __optionalDeserializationConstructor = this._optionalDeserializationConstructor(id);
    _builder.append(__optionalDeserializationConstructor, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __constructorsDecl = this._constructorsDecl(id);
    _builder.append(__constructorsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = id.getVariables();
    CharSequence __getters = this._getters("public final", _variables);
    _builder.append(__getters, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final EntityType getType() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return TYPE;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final String asTypedString() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return TYPE + \" \" + asString();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    String _name_4 = id.getName();
    ExternalType _base_1 = id.getBase();
    CharSequence __optionalBaseMethods = this._optionalBaseMethods(_name_4, _base_1);
    _builder.append(__optionalBaseMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
