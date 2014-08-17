package org.fuin.dsl.ddd.gen.enumobject;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumInstance;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod;
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class EnumArtifactFactory extends AbstractSource<EnumObject> {
  public Class<? extends EnumObject> getModelType() {
    return EnumObject.class;
  }
  
  public GeneratedArtifact create(final EnumObject enu, final Map<String, Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final String className = enu.getName();
      final Namespace ns = EObjectExtensions.getNamespace(enu);
      final String pkg = this.asPackage(ns);
      final String fqn = ((pkg + ".") + className);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(enu);
      refReg.putReference(_uniqueName, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
      this.addImports(ctx);
      this.addReferences(ctx, enu);
      String _artifactName = this.getArtifactName();
      String _create = this.create(ctx, enu, pkg, className);
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
  
  public Object addReferences(final CodeSnippetContext ctx, final EnumObject enu) {
    return null;
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final EnumObject vo, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/** ");
      String _doc = vo.getDoc();
      String _text = StringExtensions.text(_doc);
      _builder.append(_text, "");
      _builder.append(" */");
      _builder.newLineIfNotEmpty();
      _builder.append("public enum ");
      String _name = vo.getName();
      _builder.append(_name, "");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      {
        EList<EnumInstance> _instances = vo.getInstances();
        boolean _hasElements = false;
        for(final EnumInstance in : _instances) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(",", "");
          }
          String _doc_1 = in.getDoc();
          _builder.append(_doc_1, "");
          _builder.newLineIfNotEmpty();
          String _name_1 = in.getName();
          EList<Literal> _params = in.getParams();
          List<String> _litNames = CollectionExtensions.litNames(_params);
          SrcInvokeMethod _srcInvokeMethod = new SrcInvokeMethod(ctx, _name_1, _litNames);
          _builder.append(_srcInvokeMethod, "");
          _builder.newLineIfNotEmpty();
          _builder.append("\t\t\t");
        }
      }
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      SrcVarsDecl _srcVarsDecl = new SrcVarsDecl(ctx, "private", false, vo);
      _builder.append(_srcVarsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("private ");
      String _name_2 = vo.getName();
      _builder.append(_name_2, "\t");
      _builder.append("(");
      EList<Variable> _variables = vo.getVariables();
      SrcParamsDecl _srcParamsDecl = new SrcParamsDecl(ctx, _variables);
      _builder.append(_srcParamsDecl, "\t");
      _builder.append(") {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      EList<Variable> _variables_1 = vo.getVariables();
      SrcParamsAssignment _srcParamsAssignment = new SrcParamsAssignment(ctx, _variables_1);
      _builder.append(_srcParamsAssignment, "\t\t");
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
