package org.fuin.dsl.ddd.gen.aggregateid;

import com.google.common.base.Objects;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class AggregateIdStreamFactoryArtifactFactory extends AbstractSource<AggregateId> {
  public Class<? extends AggregateId> getModelType() {
    return AggregateId.class;
  }
  
  public GeneratedArtifact create(final AggregateId aggregateId, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      Aggregate _entity = aggregateId.getEntity();
      boolean _equals = Objects.equal(_entity, null);
      if (_equals) {
        return null;
      }
      String _name = aggregateId.getName();
      final String className = (_name + "StreamFactory");
      EObject _eContainer = aggregateId.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      String _name_1 = aggregateId.getName();
      final String fqn = ((pkg + ".") + _name_1);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(aggregateId);
      String _plus = (_uniqueName + "StreamFactory");
      refReg.putReference(_plus, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
      this.addImports(ctx);
      this.addReferences(ctx, aggregateId);
      String _artifactName = this.getArtifactName();
      String _create = this.create(ctx, aggregateId, pkg, className);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public Object addImports(final CodeSnippetContext ctx) {
    return null;
  }
  
  public Object addReferences(final CodeSnippetContext ctx, final AggregateId entityId) {
    return null;
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final AggregateId id, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
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
      _builder.append("  ");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public boolean containsType(final StreamId streamId) {");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("return streamId.getName().equals(");
      String _name_4 = id.getName();
      _builder.append(_name_4, "\t");
      _builder.append(".TYPE.asString());");
      _builder.newLineIfNotEmpty();
      _builder.append("  ");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      final String src = _builder.toString();
      String _copyrightHeader = this.getCopyrightHeader();
      Set<String> _imports = ctx.getImports();
      SrcAll _srcAll = new SrcAll(_copyrightHeader, pkg, _imports, src);
      _xblockexpression = _srcAll.toString();
    }
    return _xblockexpression;
  }
}
