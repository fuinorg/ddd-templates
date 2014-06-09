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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class CtxEntityIdFactoryArtifactFactory extends AbstractSource<ResourceSet> {
  public Class<? extends ResourceSet> getModelType() {
    return ResourceSet.class;
  }
  
  public boolean isIncremental() {
    return false;
  }
  
  public GeneratedArtifact create(final ResourceSet resourceSet, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final Map<String,List<AbstractEntityId>> contextEntityIds = this.contextEntityIdMap(resourceSet);
      Set<String> _keySet = contextEntityIds.keySet();
      final Iterator<String> ctxIt = _keySet.iterator();
      boolean _hasNext = ctxIt.hasNext();
      boolean _while = _hasNext;
      while (_while) {
        {
          final String ctx = ctxIt.next();
          final List<AbstractEntityId> entityIds = contextEntityIds.get(ctx);
          String _basePkg = this.getBasePkg();
          String _plus = (_basePkg + ".");
          String _plus_1 = (_plus + ctx);
          String _plus_2 = (_plus_1 + ".");
          String _pkg = this.getPkg();
          final String pkg = (_plus_2 + _pkg);
          String _firstUpper = StringExtensions.toFirstUpper(ctx);
          String _plus_3 = ((pkg + ".") + _firstUpper);
          String _plus_4 = (_plus_3 + "EntityIdFactory");
          String _replace = _plus_4.replace(".", "/");
          final String filename = (_replace + ".java");
          String _artifactName = this.getArtifactName();
          CharSequence _create = this.create(pkg, ctx, entityIds, resourceSet);
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
  
  public Map<String,List<AbstractEntityId>> contextEntityIdMap(final ResourceSet resourceSet) {
    final Map<String,List<AbstractEntityId>> contextEntityIds = new HashMap<String, List<AbstractEntityId>>();
    TreeIterator<Notifier> _allContents = resourceSet.getAllContents();
    final Iterator<AbstractEntityId> iter = Iterators.<AbstractEntityId>filter(_allContents, AbstractEntityId.class);
    boolean _hasNext = iter.hasNext();
    boolean _while = _hasNext;
    while (_while) {
      {
        final AbstractEntityId entityId = iter.next();
        Context _context = EObjectExtensions.getContext(entityId);
        String _name = _context.getName();
        List<AbstractEntityId> entityIds = contextEntityIds.get(_name);
        boolean _equals = Objects.equal(entityIds, null);
        if (_equals) {
          ArrayList<AbstractEntityId> _arrayList = new ArrayList<AbstractEntityId>();
          entityIds = _arrayList;
          Context _context_1 = EObjectExtensions.getContext(entityId);
          String _name_1 = _context_1.getName();
          contextEntityIds.put(_name_1, entityIds);
        }
        entityIds.add(entityId);
      }
      boolean _hasNext_1 = iter.hasNext();
      _while = _hasNext_1;
    }
    return contextEntityIds;
  }
  
  public CharSequence create(final String pkg, final String ctx, final List<AbstractEntityId> entityIds, final ResourceSet resourceSet) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    _builder.append(pkg, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("import java.util.*;");
    _builder.newLine();
    _builder.append("import javax.enterprise.context.*;");
    _builder.newLine();
    _builder.append("import org.fuin.ddd4j.ddd.*;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Creates entity identifier instanced based on the type.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("@ApplicationScoped");
    _builder.newLine();
    _builder.append("public final class ");
    String _firstUpper = StringExtensions.toFirstUpper(ctx);
    _builder.append(_firstUpper, "");
    _builder.append("EntityIdFactory implements EntityIdFactory {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("private Map<String, SingleEntityIdFactory> map;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* Default constructor.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public EmsEntityIdFactory() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("map = new HashMap<String, SingleEntityIdFactory>();");
    _builder.newLine();
    {
      for(final AbstractEntityId entityId : entityIds) {
        _builder.append("map.put(");
        String _name = entityId.getName();
        _builder.append(_name, "");
        _builder.append(".TYPE.asString(), new ");
        String _name_1 = entityId.getName();
        _builder.append(_name_1, "");
        _builder.append("Converter());");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public EntityId createEntityId(final String type, final String id) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("final SingleEntityIdFactory factory = map.get(type);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("if (factory == null) {");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("throw new IllegalArgumentException(\"Unknown type: \" + type);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return factory.createEntityId(id);");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public boolean containsType(final String type) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return map.containsKey(type);");
    _builder.newLine();
    _builder.append("  ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
