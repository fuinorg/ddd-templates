package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.gen.base.SrcImports;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

/**
 * Creates the source code for a value object converter.
 */
@SuppressWarnings("all")
public class SrcValueObjectConverter implements CodeSnippet {
  private final CodeReferenceRegistry refReg;
  
  private final String copyrightHeader;
  
  private final String pkg;
  
  private final String voTypeName;
  
  private final String targetTypeName;
  
  private final boolean implementsSingleEntityIdFactory;
  
  private final String className;
  
  private final SimpleCodeSnippetContext ctx;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param refReg Registry to use for resolving references to other generated artifacts.
   * @param copyrightHeader Header with copyright for the source.
   * @param pkg Package where the converter is located.
   * @param vo Value object to generate the converter for.
   * @param targetType External base type.
   * @param implementsSingleEntityIdFactory TRUE if this is a converter for an entity ID.
   */
  public SrcValueObjectConverter(final CodeReferenceRegistry refReg, final String copyrightHeader, final String pkg, final AbstractVO vo, final ExternalType targetType, final boolean implementsSingleEntityIdFactory) {
    this.refReg = refReg;
    this.copyrightHeader = copyrightHeader;
    this.pkg = pkg;
    String _name = vo.getName();
    this.voTypeName = _name;
    this.targetTypeName = this.targetTypeName;
    this.implementsSingleEntityIdFactory = implementsSingleEntityIdFactory;
    this.className = (this.voTypeName + "Converter");
    SimpleCodeSnippetContext _simpleCodeSnippetContext = new SimpleCodeSnippetContext();
    this.ctx = _simpleCodeSnippetContext;
    this.ctx.requiresImport("javax.enterprise.context.ApplicationScoped");
    this.ctx.requiresImport("javax.persistence.AttributeConverter");
    this.ctx.requiresImport("javax.persistence.Converter");
    this.ctx.requiresImport("org.fuin.objects4j.common.ThreadSafe");
    this.ctx.requiresImport("org.fuin.objects4j.vo.AbstractValueObjectConverter");
    if (implementsSingleEntityIdFactory) {
      this.ctx.requiresImport("org.fuin.ddd4j.ddd.EntityId");
    }
    String _uniqueName = AbstractElementExtensions.uniqueName(vo);
    this.ctx.requiresReference(_uniqueName);
    String _uniqueName_1 = AbstractElementExtensions.uniqueName(targetType);
    this.ctx.requiresReference(_uniqueName_1);
    this.ctx.resolve(refReg);
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append(this.copyrightHeader, "");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    _builder.append(this.pkg, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    Set<String> _imports = this.ctx.getImports();
    SrcImports _srcImports = new SrcImports(_imports);
    String _string = _srcImports.toString();
    _builder.append(_string, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Converts ");
    _builder.append(this.voTypeName, " ");
    _builder.append(" from/to ");
    _builder.append(this.targetTypeName, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("@ThreadSafe");
    _builder.newLine();
    _builder.append("@ApplicationScoped");
    _builder.newLine();
    _builder.append("@Converter(autoApply = true)");
    _builder.newLine();
    _builder.append("public final class ");
    _builder.append(this.className, "");
    _builder.append(" extends");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("AbstractValueObjectConverter<");
    _builder.append(this.targetTypeName, "\t\t");
    _builder.append(", ");
    _builder.append(this.voTypeName, "\t\t");
    _builder.append("> implements");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("AttributeConverter<");
    _builder.append(this.voTypeName, "\t\t");
    _builder.append(", ");
    _builder.append(this.targetTypeName, "\t\t");
    _builder.append(">");
    {
      if (this.implementsSingleEntityIdFactory) {
        _builder.append(", SingleEntityIdFactory");
      }
    }
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public Class<");
    _builder.append(this.targetTypeName, "\t");
    _builder.append("> getBaseTypeClass() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(this.targetTypeName, "\t\t");
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
    _builder.append("public final Class<");
    _builder.append(this.voTypeName, "\t");
    _builder.append("> getValueObjectClass() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(this.voTypeName, "\t\t");
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
    _builder.append("public final boolean isValid(final ");
    _builder.append(this.targetTypeName, "\t");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(this.voTypeName, "\t\t");
    _builder.append(".isValid(value);");
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
    _builder.append(this.voTypeName, "\t");
    _builder.append(" toVO(final ");
    _builder.append(this.targetTypeName, "\t");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(this.voTypeName, "\t\t");
    _builder.append(".valueOf(value);");
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
    _builder.append(this.targetTypeName, "\t");
    _builder.append(" fromVO(final ");
    _builder.append(this.voTypeName, "\t");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return value.asBaseType();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    {
      if (this.implementsSingleEntityIdFactory) {
        _builder.append("\t");
        _builder.append("@Override");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("public final EntityId createEntityId(final String id) {");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("\t");
        _builder.append("return ");
        _builder.append(this.voTypeName, "\t\t");
        _builder.append(".valueOf(id);");
        _builder.newLineIfNotEmpty();
        _builder.append("\t");
        _builder.append("}");
        _builder.newLine();
      }
    }
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder.toString();
  }
}
