package org.fuin.dsl.ddd.gen.event;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.EventExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class EventArtifactFactory extends AbstractSource<Event> {
  public Class<? extends Event> getModelType() {
    return Event.class;
  }
  
  public GeneratedArtifact create(final Event event, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final EObject method = event.eContainer();
      final EObject container = method.eContainer();
      if ((container instanceof AbstractEntity)) {
        final AbstractEntity entity = ((AbstractEntity) container);
        final String className = event.getName();
        EObject _eContainer = entity.eContainer();
        final Namespace ns = ((Namespace) _eContainer);
        final String pkg = this.asPackage(ns);
        String _name = event.getName();
        final String fqn = ((pkg + ".") + _name);
        String _replace = fqn.replace(".", "/");
        final String filename = (_replace + ".java");
        final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
        String _uniqueName = EventExtensions.uniqueName(event);
        refReg.putReference(_uniqueName, fqn);
        if (preparationRun) {
          return null;
        }
        final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
        this.addImports(ctx);
        this.addReferences(ctx, event);
        ctx.resolve(refReg);
        String _artifactName = this.getArtifactName();
        String _create = this.create(ctx, event, pkg, className);
        String _string = _create.toString();
        byte[] _bytes = _string.getBytes("UTF-8");
        return new GeneratedArtifact(_artifactName, filename, _bytes);
      }
      return null;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public AbstractEntityId getEntityIdType(final Event event) {
    EObject _eContainer = event.eContainer();
    EObject _eContainer_1 = _eContainer.eContainer();
    AbstractEntity abstractEntity = ((AbstractEntity) _eContainer_1);
    return abstractEntity.getIdType();
  }
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter");
  }
  
  public Object addReferences(final CodeSnippetContext ctx, final Event event) {
    return null;
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final Event event, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/** ");
      String _doc = event.getDoc();
      String _text = StringExtensions.text(_doc);
      _builder.append(_text, "");
      _builder.append(" */");
      _builder.newLineIfNotEmpty();
      String _name = event.getName();
      CharSequence __xmlRootElement = this._xmlRootElement(_name);
      _builder.append(__xmlRootElement, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public final class ");
      _builder.append(className, "");
      _builder.append(" extends AbstractDomainEvent<");
      AbstractEntityId _entityIdType = this.getEntityIdType(event);
      String _name_1 = _entityIdType.getName();
      _builder.append(_name_1, "");
      _builder.append("> {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("private static final long serialVersionUID = 1000L;");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("/** Unique name used to store the event. */");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public static final EventType EVENT_TYPE = new EventType(\"");
      String _name_2 = event.getName();
      _builder.append(_name_2, "\t");
      _builder.append("\");");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence __varsDecl = this._varsDecl(event);
      _builder.append(__varsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("/**");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* Protected default constructor for deserialization.");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("protected ");
      String _name_3 = event.getName();
      _builder.append(_name_3, "\t");
      _builder.append("() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("super();");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("/**");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* ");
      String _doc_1 = event.getDoc();
      String _text_1 = StringExtensions.text(_doc_1);
      _builder.append(_text_1, "\t ");
      _builder.newLineIfNotEmpty();
      _builder.append("\t ");
      _builder.append("*");
      _builder.newLine();
      _builder.append("\t ");
      _builder.append("* @param entityIdPath Path from the aggregate root (first) to the entity that raised the event (last). ");
      _builder.newLine();
      {
        EList<Variable> _variables = event.getVariables();
        for(final Variable v : _variables) {
          _builder.append("\t");
          _builder.append("* @param ");
          String _name_4 = v.getName();
          _builder.append(_name_4, "\t");
          _builder.append(" ");
          String _superDoc = VariableExtensions.superDoc(v);
          _builder.append(_superDoc, "\t");
          _builder.append(" ");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append("\t");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public ");
      String _name_5 = event.getName();
      _builder.append(_name_5, "\t");
      _builder.append("(@NotNull final EntityIdPath entityIdPath, ");
      EList<Variable> _variables_1 = event.getVariables();
      CharSequence __paramsDecl = this._paramsDecl(_variables_1);
      _builder.append(__paramsDecl, "\t");
      _builder.append(") {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("super(entityIdPath);");
      _builder.newLine();
      _builder.append("\t\t");
      EList<Variable> _variables_2 = event.getVariables();
      CharSequence __paramsAssignment = this._paramsAssignment(_variables_2);
      _builder.append(__paramsAssignment, "\t\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public final EventType getEventType() {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return EVENT_TYPE;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      EList<Variable> _variables_3 = event.getVariables();
      SrcGetters _srcGetters = new SrcGetters(ctx, "public final", _variables_3);
      _builder.append(_srcGetters, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public final String toString() {");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("return KeyValue.replace(\"");
      String _message = event.getMessage();
      _builder.append(_message, "\t");
      _builder.append("\",");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("new KeyValue(\"#entityIdPath\", getEntityIdPath())");
      _builder.newLine();
      {
        EList<Variable> _variables_4 = event.getVariables();
        for(final Variable v_1 : _variables_4) {
          _builder.append("\t\t");
          _builder.append(", new KeyValue(\"");
          String _name_6 = v_1.getName();
          _builder.append(_name_6, "\t\t");
          _builder.append("\", ");
          String _name_7 = v_1.getName();
          _builder.append(_name_7, "\t\t");
          _builder.append(")");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append("\t");
      _builder.append(");");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
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
  
  public CharSequence _varsDecl(final Event event) {
    StringConcatenation _builder = new StringConcatenation();
    {
      EList<Variable> _variables = event.getVariables();
      List<Variable> _nullSafe = CollectionExtensions.<Variable>nullSafe(_variables);
      for(final Variable variable : _nullSafe) {
        CharSequence __varDecl = this._varDecl(variable, true);
        _builder.append(__varDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
}
