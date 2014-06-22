package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethodsNumber;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethodsString;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethodsUUID;
import org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for value object methods that have an external 'base' type.
 */
@SuppressWarnings("all")
public class SrcVoBaseMethods implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final AbstractVO vo;
  
  private final String baseName;
  
  /**
   * Constructor with value object.
   * 
   * @param ctx Context.
   * @param vo Value object.
   */
  public SrcVoBaseMethods(final CodeSnippetContext ctx, final AbstractVO vo) {
    this.ctx = ctx;
    boolean _equals = Objects.equal(vo, null);
    if (_equals) {
      throw new IllegalArgumentException("vo cannot be null");
    }
    this.vo = vo;
    ExternalType _baseType = AbstractVOExtensions.baseType(vo);
    boolean _equals_1 = Objects.equal(_baseType, null);
    if (_equals_1) {
      this.baseName = null;
    } else {
      ExternalType _baseType_1 = AbstractVOExtensions.baseType(vo);
      String _name = _baseType_1.getName();
      this.baseName = _name;
    }
  }
  
  public String toString() {
    boolean _equals = Objects.equal(this.baseName, null);
    if (_equals) {
      return "";
    }
    boolean _equals_1 = this.baseName.equals("String");
    if (_equals_1) {
      SrcVoBaseMethodsString _srcVoBaseMethodsString = new SrcVoBaseMethodsString(this.ctx, this.vo);
      return _srcVoBaseMethodsString.toString();
    }
    boolean _equals_2 = this.baseName.equals("UUID");
    if (_equals_2) {
      SrcVoBaseMethodsUUID _srcVoBaseMethodsUUID = new SrcVoBaseMethodsUUID(this.ctx, this.vo);
      return _srcVoBaseMethodsUUID.toString();
    }
    boolean _or = false;
    boolean _equals_3 = this.baseName.equals("Integer");
    if (_equals_3) {
      _or = true;
    } else {
      boolean _equals_4 = this.baseName.equals("Long");
      _or = _equals_4;
    }
    if (_or) {
      SrcVoBaseMethodsNumber _srcVoBaseMethodsNumber = new SrcVoBaseMethodsNumber(this.ctx, this.vo);
      return _srcVoBaseMethodsNumber.toString();
    }
    return "";
  }
}
