package org.fuin.dsl.ddd.gen.enumobject;

import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumInstance;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
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
  
  public GeneratedArtifact create(final EnumObject enu, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final String className = enu.getName();
      EObject _eContainer = enu.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      String _name = enu.getName();
      final String fqn = ((pkg + ".") + _name);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(enu);
      refReg.putReference(_uniqueName, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
      this.addImports(ctx);
      this.addReferences(ctx, enu);
      ctx.resolve(refReg);
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
          _builder.append(_name_1, "");
          _builder.append("(");
          EList<Variable> _variables = vo.getVariables();
          EList<Literal> _params = in.getParams();
          String __methodCall = this._methodCall(_variables, _params);
          _builder.append(__methodCall, "");
          _builder.append(")");
          _builder.newLineIfNotEmpty();
          _builder.append("\t\t\t");
        }
      }
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      CharSequence __varsDecl = this._varsDecl(vo);
      _builder.append(__varsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("private ");
      String _name_2 = vo.getName();
      _builder.append(_name_2, "\t");
      _builder.append("(");
      EList<Variable> _variables_1 = vo.getVariables();
      CharSequence __paramsDecl = this._paramsDecl(_variables_1);
      _builder.append(__paramsDecl, "\t");
      _builder.append(") {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      EList<Variable> _variables_2 = vo.getVariables();
      CharSequence __paramsAssignment = this._paramsAssignment(_variables_2);
      _builder.append(__paramsAssignment, "\t\t");
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
