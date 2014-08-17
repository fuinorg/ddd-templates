package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code 'extends X' where X is the
 * appropriate base class for the value object.
 */
@SuppressWarnings("all")
public class SrcVoBaseOptionalExtends implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String baseName;
  
  /**
   * Constructor with value object.
   * 
   * @param ctx Context.
   * @param base External base type: "String", "UUID", "Integer" or "Long" are currently supported.
   */
  public SrcVoBaseOptionalExtends(final CodeSnippetContext ctx, final ExternalType base) {
    this.ctx = ctx;
    boolean _equals = Objects.equal(base, null);
    if (_equals) {
      this.baseName = null;
    } else {
      String _name = base.getName();
      this.baseName = _name;
      final String baseName = this.baseName;
      boolean _matched = false;
      if (!_matched) {
        if (Objects.equal(baseName, "String")) {
          _matched=true;
          ctx.requiresImport("org.fuin.objects4j.vo.AbstractStringValueObject");
        }
      }
      if (!_matched) {
        if (Objects.equal(baseName, "UUID")) {
          _matched=true;
          ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractUUIDVO");
        }
      }
      if (!_matched) {
        if (Objects.equal(baseName, "Integer")) {
          _matched=true;
          ctx.requiresImport("org.fuin.objects4j.vo.AbstractIntegerValueObject");
        }
      }
      if (!_matched) {
        if (Objects.equal(baseName, "Long")) {
          _matched=true;
          ctx.requiresImport("org.fuin.objects4j.vo.AbstractLongValueObject");
        }
      }
    }
  }
  
  public String toString() {
    boolean _equals = Objects.equal(this.baseName, null);
    if (_equals) {
      return "";
    }
    final String baseName = this.baseName;
    boolean _matched = false;
    if (!_matched) {
      if (Objects.equal(baseName, "String")) {
        _matched=true;
        return "extends AbstractStringValueObject ";
      }
    }
    if (!_matched) {
      if (Objects.equal(baseName, "UUID")) {
        _matched=true;
        return "extends AbstractUUIDVO ";
      }
    }
    if (!_matched) {
      if (Objects.equal(baseName, "Integer")) {
        _matched=true;
        return "extends AbstractIntegerValueObject ";
      }
    }
    if (!_matched) {
      if (Objects.equal(baseName, "Long")) {
        _matched=true;
        return "extends AbstractLongValueObject ";
      }
    }
    return "";
  }
}
