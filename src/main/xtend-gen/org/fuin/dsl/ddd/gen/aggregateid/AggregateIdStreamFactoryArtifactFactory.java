package org.fuin.dsl.ddd.gen.aggregateid;

import com.google.common.base.Objects;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AggregateIdStreamFactoryArtifactFactory extends AbstractSource<AggregateId> {
  public Class<? extends AggregateId> getModelType() {
    return AggregateId.class;
  }
  
  public GeneratedArtifact create(final AggregateId aggregateId) throws GenerateException {
    try {
      Aggregate _entity = aggregateId.getEntity();
      boolean _equals = Objects.equal(_entity, null);
      if (_equals) {
        return null;
      }
      EObject _eContainer = aggregateId.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = aggregateId.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + "StreamFactory.java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(aggregateId, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final AggregateId id, final Namespace ns) {
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
    _builder.append("import org.fuin.ddd4j.eventstore.intf.*;");
    _builder.newLine();
    _builder.append("import org.fuin.ddd4j.eventstore.jpa.*;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Creates a ");
    Aggregate _entity = id.getEntity();
    String _name = _entity.getName();
    _builder.append(_name, " ");
    _builder.append("Stream based on a AggregateStreamId.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public class ");
    String _name_1 = id.getName();
    _builder.append(_name_1, "");
    _builder.append("StreamFactory implements IdStreamFactory {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final Stream createStream(final StreamId streamId) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("final String id = streamId.getSingleParamValue();");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return new ");
    Aggregate _entity_1 = id.getEntity();
    String _name_2 = _entity_1.getName();
    _builder.append(_name_2, "\t\t");
    _builder.append("Stream(");
    String _name_3 = id.getName();
    _builder.append(_name_3, "\t\t");
    _builder.append(".valueOf(id));");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public boolean containsType(final StreamId streamId) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return streamId.getName().equals(");
    String _name_4 = id.getName();
    _builder.append(_name_4, "\t\t");
    _builder.append(".TYPE.asString());");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
