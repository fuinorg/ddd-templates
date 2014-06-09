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
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class CtxEventRegistryArtifactFactory extends AbstractSource<ResourceSet> {
  public Class<? extends ResourceSet> getModelType() {
    return ResourceSet.class;
  }
  
  public boolean isIncremental() {
    return false;
  }
  
  public GeneratedArtifact create(final ResourceSet resourceSet, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final Map<String,List<Event>> contextEvents = this.contextEventMap(resourceSet);
      Set<String> _keySet = contextEvents.keySet();
      final Iterator<String> ctxIt = _keySet.iterator();
      boolean _hasNext = ctxIt.hasNext();
      boolean _while = _hasNext;
      while (_while) {
        {
          final String ctx = ctxIt.next();
          final List<Event> events = contextEvents.get(ctx);
          String _basePkg = this.getBasePkg();
          String _plus = (_basePkg + ".");
          String _plus_1 = (_plus + ctx);
          String _plus_2 = (_plus_1 + ".");
          String _pkg = this.getPkg();
          final String pkg = (_plus_2 + _pkg);
          String _firstUpper = StringExtensions.toFirstUpper(ctx);
          String _plus_3 = ((pkg + ".") + _firstUpper);
          String _plus_4 = (_plus_3 + "EventRegistry");
          String _replace = _plus_4.replace(".", "/");
          final String filename = (_replace + ".java");
          String _artifactName = this.getArtifactName();
          CharSequence _create = this.create(pkg, ctx, events, resourceSet);
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
  
  public Map<String,List<Event>> contextEventMap(final ResourceSet resourceSet) {
    final Map<String,List<Event>> contextEvents = new HashMap<String, List<Event>>();
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
  
  public CharSequence create(final String pkg, final String ctx, final List<Event> events, final ResourceSet resourceSet) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    _builder.append(pkg, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import java.nio.charset.Charset;");
    _builder.newLine();
    _builder.append("import javax.enterprise.context.ApplicationScoped;");
    _builder.newLine();
    _builder.append("import org.fuin.ddd4j.ddd.*;");
    _builder.newLine();
    _builder.newLine();
    {
      for(final Event event : events) {
        _builder.append("import ");
        String _fqn = this.fqn(event);
        _builder.append(_fqn, "");
        _builder.append(";");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.newLine();
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
    String _firstUpper = StringExtensions.toFirstUpper(ctx);
    _builder.append(_firstUpper, "");
    _builder.append("EventRegistry implements SerializerDeserializerRegistry {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("private SerializerDeserializerRegistry registry;");
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
    _builder.append("registry = new SerializerDeserializerRegistry();");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("registry.add(new XmlDeSerializer(\"BasicEventMetaData\", BasicEventMetaData.class));");
    _builder.newLine();
    {
      for(final Event event_1 : events) {
        _builder.append("\t\t");
        _builder.append("registry.add(new XmlDeSerializer(");
        String _name = event_1.getName();
        _builder.append(_name, "\t\t");
        _builder.append(".EVENT_TYPE.asBaseType(), adapters, ");
        String _name_1 = event_1.getName();
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
    return _builder;
  }
}
