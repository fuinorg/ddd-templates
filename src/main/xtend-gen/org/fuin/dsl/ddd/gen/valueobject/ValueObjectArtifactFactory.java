package org.fuin.dsl.ddd.gen.valueobject;

import com.google.common.base.Objects;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment;
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseOptionalExtends;
import org.fuin.dsl.ddd.gen.base.SrcXmlRootElement;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class ValueObjectArtifactFactory extends AbstractSource<ValueObject> {
  public Class<? extends ValueObject> getModelType() {
    return ValueObject.class;
  }
  
  public GeneratedArtifact create(final ValueObject valueObject, final Map<String, Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final String className = valueObject.getName();
      final Namespace ns = EObjectExtensions.getNamespace(valueObject);
      final String pkg = this.asPackage(ns);
      final String fqn = ((pkg + ".") + className);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(valueObject);
      refReg.putReference(_uniqueName, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
      this.addImports(ctx);
      String _artifactName = this.getArtifactName();
      String _create = this.create(ctx, valueObject, pkg, className);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("org.fuin.objects4j.vo.ValueObject");
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final ValueObject vo, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      SrcJavaDoc _srcJavaDoc = new SrcJavaDoc(vo);
      _builder.append(_srcJavaDoc, "");
      _builder.newLineIfNotEmpty();
      {
        ExternalType _base = vo.getBase();
        boolean _equals = Objects.equal(_base, null);
        if (_equals) {
          SrcXmlRootElement _srcXmlRootElement = new SrcXmlRootElement(ctx, vo);
          _builder.append(_srcXmlRootElement, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append("public final class ");
      _builder.append(className, "");
      _builder.append(" ");
      ExternalType _base_1 = vo.getBase();
      SrcVoBaseOptionalExtends _srcVoBaseOptionalExtends = new SrcVoBaseOptionalExtends(ctx, _base_1);
      _builder.append(_srcVoBaseOptionalExtends, "");
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
      SrcVarsDecl _srcVarsDecl = new SrcVarsDecl(ctx, "private", _equals_1, vo);
      _builder.append(_srcVarsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      SrcConstructorsWithParamsAssignment _srcConstructorsWithParamsAssignment = new SrcConstructorsWithParamsAssignment(ctx, vo);
      _builder.append(_srcConstructorsWithParamsAssignment, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      EList<Variable> _variables = vo.getVariables();
      SrcGetters _srcGetters = new SrcGetters(ctx, "public final", _variables);
      _builder.append(_srcGetters, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      SrcVoBaseMethods _srcVoBaseMethods = new SrcVoBaseMethods(ctx, vo);
      _builder.append(_srcVoBaseMethods, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
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
