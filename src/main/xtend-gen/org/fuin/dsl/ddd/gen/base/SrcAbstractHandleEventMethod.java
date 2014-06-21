package org.fuin.dsl.ddd.gen.base;

import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.gen.extensions.EventExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates an abstract event handler method.
 */
@SuppressWarnings("all")
public class SrcAbstractHandleEventMethod implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String name;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param event Event.
   */
  public SrcAbstractHandleEventMethod(final CodeSnippetContext ctx, final Event event) {
    this.ctx = ctx;
    String _name = event.getName();
    this.name = _name;
    String _uniqueName = EventExtensions.uniqueName(event);
    ctx.requiresReference(_uniqueName);
    ctx.requiresImport("javax.validation.constraints.NotNull");
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Handles: ");
    _builder.append(this.name, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param event Event to handle.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("protected abstract void handle(@NotNull final ");
    _builder.append(this.name, "");
    _builder.append(" event);");
    _builder.newLineIfNotEmpty();
    return _builder.toString();
  }
}
