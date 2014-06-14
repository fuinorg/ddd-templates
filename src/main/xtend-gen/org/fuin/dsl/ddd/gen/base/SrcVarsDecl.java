package org.fuin.dsl.ddd.gen.base;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcVarDecl;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a one or more variable declarations.
 */
@SuppressWarnings("all")
public class SrcVarsDecl implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String visibility;
  
  private final boolean xml;
  
  private final List<Variable> variables;
  
  /**
   * Constructor with list of variables.
   * 
   * @param ctx Context.
   * @param visibility Visibility for the variable.
   * @param xml Create XML annotation.
   * @param variables List.
   */
  public SrcVarsDecl(final CodeSnippetContext ctx, final String visibility, final boolean xml, final List<Variable> variables) {
    this.ctx = ctx;
    this.visibility = visibility;
    this.xml = xml;
    ArrayList<Variable> _arrayList = new ArrayList<Variable>(variables);
    this.variables = _arrayList;
  }
  
  /**
   * Constructor with internal type.
   * 
   * @param ctx Context.
   * @param visibility Visibility for the variable.
   * @param xml Create XML annotation.
   * @param internalType Type that has a list of variables.
   */
  public SrcVarsDecl(final CodeSnippetContext ctx, final String visibility, final boolean xml, final InternalType internalType) {
    this(ctx, visibility, xml, internalType.getVariables());
  }
  
  /**
   * Constructor with event.
   * 
   * @param ctx Context.
   * @param visibility Visibility for the variable.
   * @param xml Create XML annotation.
   * @param event Event that has a list of variables.
   */
  public SrcVarsDecl(final CodeSnippetContext ctx, final String visibility, final boolean xml, final Event event) {
    this(ctx, visibility, xml, event.getVariables());
  }
  
  /**
   * Constructor with exception.
   * 
   * @param ctx Context.
   * @param visibility Visibility for the variable.
   * @param xml Create XML annotation.
   * @param exception Event that has a list of variables.
   */
  public SrcVarsDecl(final CodeSnippetContext ctx, final String visibility, final boolean xml, final org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception ex) {
    this(ctx, visibility, xml, ex.getVariables());
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      List<Variable> _nullSafe = CollectionExtensions.<Variable>nullSafe(this.variables);
      for(final Variable variable : _nullSafe) {
        SrcVarDecl _srcVarDecl = new SrcVarDecl(this.ctx, "private", this.xml, variable);
        _builder.append(_srcVarDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder.toString();
  }
}
