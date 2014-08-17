package org.fuin.dsl.ddd.gen.resourceset;

import com.google.common.base.Objects;
import com.google.common.collect.Iterators;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.notify.Notifier;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.dsl.ddd.gen.extensions.EventExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class CtxEventRegistryArtifactFactory extends AbstractSource<ResourceSet> {
  public Class<? extends ResourceSet> getModelType() {
    return ResourceSet.class;
  }
  
  public boolean isIncremental() {
    return false;
  }
  
  public GeneratedArtifact create(final ResourceSet resourceSet, final Map<String, Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final Map<String, List<Event>> contextEvents = this.contextEventMap(resourceSet);
      Set<String> _keySet = contextEvents.keySet();
      final Iterator<String> ctxIt = _keySet.iterator();
      boolean _hasNext = ctxIt.hasNext();
      boolean _while = _hasNext;
      while (_while) {
        {
          final String ctx = ctxIt.next();
          final List<Event> events = contextEvents.get(ctx);
          String _firstUpper = StringExtensions.toFirstUpper(ctx);
          final String className = (_firstUpper + "EventRegistry");
          final String pkg = this.contextPkg(ctx);
          final String fqn = ((pkg + ".") + className);
          String _replace = fqn.replace(".", "/");
          final String filename = (_replace + ".java");
          final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
          refReg.putReference(className, fqn);
          if (preparationRun) {
            return null;
          }
          final SimpleCodeSnippetContext sctx = new SimpleCodeSnippetContext(refReg);
          this.addImports(sctx);
          this.addReferences(sctx, events);
          String _artifactName = this.getArtifactName();
          String _create = this.create(sctx, ctx, pkg, className, events, resourceSet);
          String _string = _create.toString();
          byte[] _bytes = _string.getBytes("UTF-8");
          return new GeneratedArtifact(_artifactName, filename, _bytes);
        }
      }
      return null;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("javax.enterprise.context.ApplicationScoped");
    ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter");
    ctx.requiresImport("java.nio.charset.Charset");
    ctx.requiresImport("javax.inject.Inject");
    ctx.requiresImport("javax.annotation.PostConstruct");
    ctx.requiresImport("org.fuin.ddd4j.ddd.SerializerDeserializerRegistry");
    ctx.requiresImport("org.fuin.ddd4j.ddd.Deserializer");
    ctx.requiresImport("org.fuin.ddd4j.ddd.Serializer");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdFactory");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPathConverter");
    ctx.requiresImport("org.fuin.ddd4j.ddd.BasicEventMetaData");
    ctx.requiresImport("org.fuin.ddd4j.ddd.XmlDeSerializer");
    ctx.requiresImport("org.fuin.ddd4j.ddd.SimpleSerializerDeserializerRegistry");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final List<Event> events) {
    for (final Event event : events) {
      String _uniqueName = EventExtensions.uniqueName(event);
      ctx.requiresReference(_uniqueName);
    }
  }
  
  public Map<String, List<Event>> contextEventMap(final ResourceSet resourceSet) {
    final Map<String, List<Event>> contextEvents = new HashMap<String, List<Event>>();
    TreeIterator<Notifier> _allContents = resourceSet.getAllContents();
    final Iterator<Event> iter = Iterators.<Event>filter(_allContents, Event.class);
    boolean _hasNext = iter.hasNext();
    boolean _while = _hasNext;
    while (_while) {
      {
        final Event event = iter.next();
        Context _context = EObjectExtensions.getContext(event);
        String _name = _context.getName();
        List<Event> events = contextEvents.get(_name);
        boolean _equals = Objects.equal(events, null);
        if (_equals) {
          ArrayList<Event> _arrayList = new ArrayList<Event>();
          events = _arrayList;
          Context _context_1 = EObjectExtensions.getContext(event);
          String _name_1 = _context_1.getName();
          contextEvents.put(_name_1, events);
        }
        events.add(event);
      }
      boolean _hasNext_1 = iter.hasNext();
      _while = _hasNext_1;
    }
    return contextEvents;
  }
  
  public String create(final SimpleCodeSnippetContext sctx, final String ctx, final String pkg, final String className, final List<Event> events, final ResourceSet resourceSet) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/**");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("* Contains a list of all events defined by this package.");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("@ApplicationScoped");
      _builder.newLine();
      _builder.append("public class ");
      _builder.append(className, "");
      _builder.append(" implements SerializerDeserializerRegistry {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("private SimpleSerializerDeserializerRegistry registry;");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("@Inject");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("private EntityIdFactory entityIdFactory;");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@PostConstruct");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("protected void init() {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(entityIdFactory);");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final XmlAdapter<?, ?>[] adapters = new XmlAdapter<?, ?>[] { entityIdPathConverter };");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("registry = new SimpleSerializerDeserializerRegistry();");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("registry.add(new XmlDeSerializer(\"BasicEventMetaData\", BasicEventMetaData.class));");
      _builder.newLine();
      {
        for(final Event event : events) {
          _builder.append("\t\t");
          _builder.append("registry.add(new XmlDeSerializer(");
          String _name = event.getName();
          _builder.append(_name, "\t\t");
          _builder.append(".EVENT_TYPE.asBaseType(), adapters, ");
          String _name_1 = event.getName();
          _builder.append(_name_1, "\t\t");
          _builder.append(".class));");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("  \t");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("  \t ");
      _builder.append("public Serializer getSerializer(final String type) {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return registry.getSerializer(type);");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("public Deserializer getDeserializer(final String type, final int version, final String mimeType, final Charset encoding) {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return registry.getDeserializer(type, version, mimeType, encoding);");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      final String src = _builder.toString();
      String _copyrightHeader = this.getCopyrightHeader();
      Set<String> _imports = sctx.getImports();
      SrcAll _srcAll = new SrcAll(_copyrightHeader, pkg, _imports, src);
      _xblockexpression = _srcAll.toString();
    }
    return _xblockexpression;
  }
}
