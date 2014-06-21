package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.gen.base.SrcHandleEventMethod;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates multiple event handler methods.
 */
@SuppressWarnings("all")
public class SrcHandleEventMethods implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final List<Event> events;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param event Event.
   */
  public SrcHandleEventMethods(final CodeSnippetContext ctx, final List<Event> events) {
    this.ctx = ctx;
    this.events = events;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Event event : this.events) {
        SrcHandleEventMethod _srcHandleEventMethod = new SrcHandleEventMethod(this.ctx, event);
        _builder.append(_srcHandleEventMethod, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder.toString();
  }
}
