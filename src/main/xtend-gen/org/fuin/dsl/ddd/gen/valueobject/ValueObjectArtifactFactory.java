package org.fuin.dsl.ddd.gen.valueobject;

import com.google.common.base.Objects;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
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
  
  public GeneratedArtifact create(final ValueObject valueObject, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final String className = valueObject.getName();
      EObject _eContainer = valueObject.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      String _name = valueObject.getName();
      final String fqn = ((pkg + ".") + _name);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(valueObject);
      refReg.putReference(_uniqueName, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
      this.addImports(ctx);
      ctx.resolve(refReg);
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
      _builder.append(className, "");
      _builder.append(" ");
      String _name_1 = vo.getName();
      ExternalType _base_1 = vo.getBase();
      String _optionalExtendsForBase = this.optionalExtendsForBase(_name_1, _base_1);
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
      CharSequence __varsDecl = this._varsDecl(ctx, vo, _equals_1);
      _builder.append(__varsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      String __optionalDeserializationConstructor = this._optionalDeserializationConstructor(vo);
      _builder.append(__optionalDeserializationConstructor, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      CharSequence __constructorsDecl = this._constructorsDecl(ctx, vo);
      _builder.append(__constructorsDecl, "\t");
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
      String _name_2 = vo.getName();
      ExternalType _base_3 = vo.getBase();
      CharSequence __optionalBaseMethods = this._optionalBaseMethods(_name_2, _base_3);
      _builder.append(__optionalBaseMethods, "\t");
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
