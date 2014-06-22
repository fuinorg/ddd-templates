package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for value objects that have an external 'base' of type 'Number'.
 */
@SuppressWarnings("all")
public class SrcVoBaseMethodsNumber implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String typeName;
  
  private final String baseName;
  
  /**
   * Constructor with value object.
   * 
   * @param ctx Context.
   * @param vo Value object.
   */
  public SrcVoBaseMethodsNumber(final CodeSnippetContext ctx, final AbstractVO vo) {
    this.ctx = ctx;
    boolean _equals = Objects.equal(vo, null);
    if (_equals) {
      throw new IllegalArgumentException("vo cannot be null");
    }
    ExternalType _baseType = AbstractVOExtensions.baseType(vo);
    boolean _equals_1 = Objects.equal(_baseType, null);
    if (_equals_1) {
      throw new IllegalArgumentException("vo.base cannot be null");
    }
    String _name = vo.getName();
    this.typeName = _name;
    ExternalType _baseType_1 = AbstractVOExtensions.baseType(vo);
    String _name_1 = _baseType_1.getName();
    this.baseName = _name_1;
    String _uniqueName = AbstractElementExtensions.uniqueName(vo);
    ctx.requiresReference(_uniqueName);
    ExternalType _baseType_2 = AbstractVOExtensions.baseType(vo);
    String _uniqueName_1 = AbstractElementExtensions.uniqueName(_baseType_2);
    ctx.requiresReference(_uniqueName_1);
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns the information if a given ");
    _builder.append(this.baseName, " ");
    _builder.append(" can be converted into");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("* an instance of ");
    _builder.append(this.typeName, " ");
    _builder.append(". A <code>null</code> value returns <code>true</code>.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to check.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return TRUE if it\'s a valid ");
    _builder.append(this.baseName, " ");
    _builder.append(", else FALSE.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static boolean isValid(final ");
    _builder.append(this.baseName, "");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("try {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append(this.baseName, "\t\t");
    _builder.append(".valueOf(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("} catch (final NumberFormatException ex) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given ");
    _builder.append(this.baseName, " ");
    _builder.append(" and returns a new instance of ");
    _builder.append(this.typeName, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(this.typeName, "");
    _builder.append(" valueOf(final ");
    _builder.append(this.baseName, "");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return new ");
    _builder.append(this.typeName, "\t");
    _builder.append("(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("public Integer asBaseType() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return val;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("public String asString() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return \"\" + val;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given String and returns a new instance of ");
    _builder.append(this.typeName, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(this.typeName, "");
    _builder.append(" valueOf(final String value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return new ");
    _builder.append(this.typeName, "\t");
    _builder.append("(");
    _builder.append(this.baseName, "\t");
    _builder.append(".valueOf(value));");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    return _builder.toString();
  }
}
