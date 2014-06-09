package org.fuin.dsl.ddd.gen.aggregate;

import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.dsl.ddd.gen.base.SrcImports;
import org.fuin.dsl.ddd.gen.base.SrcSetters;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

/**
 * Generates an abstract aggregate Java class.
 */
@SuppressWarnings("all")
public class AbstractAggregateArtifactFactory extends AbstractSource<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      String _name = aggregate.getName();
      final String className = ("Abstract" + _name);
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      final String fqn = ((pkg + ".") + className);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueAbstractName = AbstractElementExtensions.uniqueAbstractName(aggregate);
      refReg.putReference(_uniqueAbstractName, fqn);
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
      this.addImports(ctx);
      this.addReferences(ctx, aggregate);
      ctx.resolve(refReg);
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(ctx, aggregate, pkg, className);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractAggregateRoot");
    ctx.requiresImport("javax.validation.constraints.NotNull");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType");
    ctx.requiresImport("org.fuin.objects4j.common.Contract");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final Aggregate aggregate) {
    AggregateId _idType = aggregate.getIdType();
    String _uniqueName = AbstractElementExtensions.uniqueName(_idType);
    ctx.requiresReference(_uniqueName);
  }
  
  /**
   * Creates the actual source code.
   */
  public CharSequence create(final SimpleCodeSnippetContext ctx, final Aggregate aggregate, final String pkg, final String className) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.append(" ");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    _builder.append(pkg, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    Set<String> _imports = ctx.getImports();
    SrcImports _srcImports = new SrcImports(_imports);
    _builder.append(_srcImports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __typeDoc = this._typeDoc(aggregate);
    _builder.append(__typeDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public abstract class ");
    _builder.append(className, "");
    _builder.append(" extends AbstractAggregateRoot<");
    AggregateId _idType = aggregate.getIdType();
    String _name = _idType.getName();
    _builder.append(_name, "");
    _builder.append("> {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private ");
    AggregateId _idType_1 = aggregate.getIdType();
    String _name_1 = _idType_1.getName();
    _builder.append(_name_1, "\t");
    _builder.append(" id;");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __varsDecl = this._varsDecl(aggregate);
    _builder.append(__varsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final EntityType getType() {\t\t\t\t");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return ");
    AggregateId _idType_2 = aggregate.getIdType();
    String _name_2 = _idType_2.getName();
    _builder.append(_name_2, "\t\t");
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
    AggregateId _idType_3 = aggregate.getIdType();
    String _name_3 = _idType_3.getName();
    _builder.append(_name_3, "\t");
    _builder.append(" getId() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return id;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* Sets the aggregate identifier.");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* @param id Unique aggregate identifier.");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("protected final void setId(@NotNull final ");
    AggregateId _idType_4 = aggregate.getIdType();
    String _name_4 = _idType_4.getName();
    _builder.append(_name_4, "\t");
    _builder.append(" id) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("Contract.requireArgNotNull(\"id\", id);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.id = id;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = aggregate.getVariables();
    SrcGetters _srcGetters = new SrcGetters(ctx, "protected final", _variables);
    _builder.append(_srcGetters, "\t");
    _builder.append("\t\t\t\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    EList<Variable> _variables_1 = aggregate.getVariables();
    SrcSetters _srcSetters = new SrcSetters(ctx, "protected final", _variables_1);
    _builder.append(_srcSetters, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    CharSequence __abstractChildEntityLocatorMethods = this._abstractChildEntityLocatorMethods(aggregate);
    _builder.append(__abstractChildEntityLocatorMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __eventAbstractMethodsDecl = this._eventAbstractMethodsDecl(aggregate);
    _builder.append(__eventAbstractMethodsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
