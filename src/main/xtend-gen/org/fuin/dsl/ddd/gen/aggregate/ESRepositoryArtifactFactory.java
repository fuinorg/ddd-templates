package org.fuin.dsl.ddd.gen.aggregate;

import java.util.Map;
import java.util.Set;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class ESRepositoryArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      String _name = aggregate.getName();
      final String className = (_name + "Repository");
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      String _name_1 = aggregate.getName();
      final String fqn = ((pkg + ".") + _name_1);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(aggregate);
      String _plus = (_uniqueName + "Event");
      refReg.putReference(_plus, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
      this.addImports(ctx);
      this.addReferences(ctx, aggregate);
      String _artifactName = this.getArtifactName();
      String _create = this.create(ctx, aggregate, pkg, className);
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
  
  public void addReferences(final CodeSnippetContext ctx, final Aggregate aggregate) {
    String _uniqueName = AbstractElementExtensions.uniqueName(aggregate);
    ctx.requiresReference(_uniqueName);
    AggregateId _idType = aggregate.getIdType();
    String _uniqueName_1 = AbstractElementExtensions.uniqueName(_idType);
    ctx.requiresReference(_uniqueName_1);
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final Aggregate aggregate, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/**");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("* Repository that is capable of storing a {@link ");
      String _name = aggregate.getName();
      _builder.append(_name, " ");
      _builder.append("}.");
      _builder.newLineIfNotEmpty();
      _builder.append(" ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("public final class ");
      String _name_1 = aggregate.getName();
      _builder.append(_name_1, "");
      _builder.append("Repository extends EventStoreRepository<");
      AggregateId _idType = aggregate.getIdType();
      String _name_2 = _idType.getName();
      _builder.append(_name_2, "");
      _builder.append(", ");
      String _name_3 = aggregate.getName();
      _builder.append(_name_3, "");
      _builder.append("> {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("/**");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* Constructor with event store to use as storage.");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* ");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* @param eventStore Event store.");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* @param serRegistry Registry used to locate serializers.");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* @param desRegistry Registry used to locate deserializers.");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public ");
      _builder.append(className, "\t");
      _builder.append("(final EventStore eventStore,");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t\t");
      _builder.append("final SerializerRegistry serRegistry, final DeserializerRegistry desRegistry) {");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("super(eventStore, serRegistry, desRegistry);");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public Class<");
      String _name_4 = aggregate.getName();
      _builder.append(_name_4, "\t");
      _builder.append("> getAggregateClass() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("return ");
      String _name_5 = aggregate.getName();
      _builder.append(_name_5, "\t\t");
      _builder.append(".class;");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public final EntityType getAggregateType() {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return ");
      AggregateId _idType_1 = aggregate.getIdType();
      String _name_6 = _idType_1.getName();
      _builder.append(_name_6, "\t\t");
      _builder.append(".TYPE;");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public final ");
      String _name_7 = aggregate.getName();
      _builder.append(_name_7, "\t");
      _builder.append(" create() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("return new ");
      String _name_8 = aggregate.getName();
      _builder.append(_name_8, "\t\t");
      _builder.append("();");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("protected final String getIdParamName() {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return \"");
      AggregateId _idType_2 = aggregate.getIdType();
      String _name_9 = _idType_2.getName();
      String _firstLower = StringExtensions.toFirstLower(_name_9);
      _builder.append(_firstLower, "\t\t");
      _builder.append("\";");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
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
