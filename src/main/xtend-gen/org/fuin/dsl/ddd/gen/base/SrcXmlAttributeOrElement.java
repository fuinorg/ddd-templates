package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcXmlAttribute;
import org.fuin.dsl.ddd.gen.base.SrcXmlElement;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a JAXB attribute annotation.
 */
@SuppressWarnings("all")
public class SrcXmlAttributeOrElement implements CodeSnippet {
  private final CodeSnippet codeSnippet;
  
  public SrcXmlAttributeOrElement(final CodeSnippetContext ctx, final Variable variable) {
    Type _type = variable.getType();
    if ((_type instanceof ValueObject)) {
      Type _type_1 = variable.getType();
      final ValueObject vo = ((ValueObject) _type_1);
      ExternalType _base = vo.getBase();
      boolean _notEquals = (!Objects.equal(_base, null));
      if (_notEquals) {
        SrcXmlAttribute _srcXmlAttribute = new SrcXmlAttribute(ctx, variable);
        this.codeSnippet = _srcXmlAttribute;
        return;
      }
    } else {
      Type _type_2 = variable.getType();
      if ((_type_2 instanceof AbstractEntityId)) {
        Type _type_3 = variable.getType();
        final AbstractEntityId id = ((AbstractEntityId) _type_3);
        ExternalType _base_1 = id.getBase();
        boolean _notEquals_1 = (!Objects.equal(_base_1, null));
        if (_notEquals_1) {
          SrcXmlAttribute _srcXmlAttribute_1 = new SrcXmlAttribute(ctx, variable);
          this.codeSnippet = _srcXmlAttribute_1;
          return;
        }
      }
    }
    SrcXmlElement _srcXmlElement = new SrcXmlElement(ctx, variable);
    this.codeSnippet = _srcXmlElement;
  }
  
  public String toString() {
    return this.codeSnippet.toString();
  }
}
