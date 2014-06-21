package org.fuin.dsl.ddd.gen.aggregate;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcConstructorSignature;
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcMethodJavaDoc;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class AggregateArtifactFactory extends AbstractSource<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final String className = aggregate.getName();
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      String _name = aggregate.getName();
      final String fqn = ((pkg + ".") + _name);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(aggregate);
      refReg.putReference(_uniqueName, fqn);
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
    String _uniqueAbstractName = AbstractElementExtensions.uniqueAbstractName(aggregate);
    ctx.requiresReference(_uniqueAbstractName);
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final Aggregate aggregate, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      SrcJavaDoc _srcJavaDoc = new SrcJavaDoc(aggregate);
      _builder.append(_srcJavaDoc, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public final class ");
      _builder.append(className, "");
      _builder.append(" extends Abstract");
      String _name = aggregate.getName();
      _builder.append(_name, "");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("/**");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* Default constructor for loading the aggregate root from history. ");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public ");
      String _name_1 = aggregate.getName();
      _builder.append(_name_1, "\t");
      _builder.append("() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("super();");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      {
        EList<Constructor> _constructors = aggregate.getConstructors();
        List<Constructor> _nullSafe = CollectionExtensions.<Constructor>nullSafe(_constructors);
        for(final Constructor constructor : _nullSafe) {
          SrcMethodJavaDoc _srcMethodJavaDoc = new SrcMethodJavaDoc(ctx, constructor);
          _builder.append(_srcMethodJavaDoc, "");
          _builder.newLineIfNotEmpty();
          SrcConstructorSignature _srcConstructorSignature = new SrcConstructorSignature(ctx, "public", className, constructor);
          _builder.append(_srcConstructorSignature, "");
          _builder.append(" {");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("super();");
          _builder.newLine();
          _builder.append("\t");
          _builder.append("// TODO Implement!");
          _builder.newLine();
          _builder.append("}");
          _builder.newLine();
          _builder.newLine();
        }
      }
      _builder.newLine();
      _builder.append("\t");
      CharSequence __childEntityLocatorMethods = this._childEntityLocatorMethods(aggregate);
      _builder.append(__childEntityLocatorMethods, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence __methodsDecl = this._methodsDecl(ctx, aggregate);
      _builder.append(__methodsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      CharSequence __eventMethodsDecl = this._eventMethodsDecl(aggregate);
      _builder.append(__eventMethodsDecl, "\t");
      _builder.newLineIfNotEmpty();
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
  
  public CharSequence _constructors(final CodeSnippetContext ctx, final Aggregate aggregate, final String className) {
    StringConcatenation _builder = new StringConcatenation();
    {
      EList<Constructor> _constructors = aggregate.getConstructors();
      List<Constructor> _nullSafe = CollectionExtensions.<Constructor>nullSafe(_constructors);
      for(final Constructor constructor : _nullSafe) {
        SrcMethodJavaDoc _srcMethodJavaDoc = new SrcMethodJavaDoc(ctx, constructor);
        _builder.append(_srcMethodJavaDoc, "");
        _builder.newLineIfNotEmpty();
        SrcConstructorSignature _srcConstructorSignature = new SrcConstructorSignature(ctx, "public", className, constructor);
        _builder.append(_srcConstructorSignature, "");
        _builder.append(" {");
        _builder.newLineIfNotEmpty();
        _builder.append("\t");
        _builder.append("super();");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("// TODO Implement!");
        _builder.newLine();
        _builder.append("}");
        _builder.newLine();
        _builder.newLine();
      }
    }
    return _builder;
  }
}
