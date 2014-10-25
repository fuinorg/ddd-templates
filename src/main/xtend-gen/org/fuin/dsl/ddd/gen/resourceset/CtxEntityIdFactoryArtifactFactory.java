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
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class CtxEntityIdFactoryArtifactFactory extends AbstractSource<ResourceSet> {
  public Class<? extends ResourceSet> getModelType() {
    return ResourceSet.class;
  }
  
  public boolean isIncremental() {
    return false;
  }
  
  public GeneratedArtifact create(final ResourceSet resourceSet, final Map<String, Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final Map<String, List<AbstractEntityId>> contextEntityIds = this.contextEntityIdMap(resourceSet);
      Set<String> _keySet = contextEntityIds.keySet();
      final Iterator<String> ctxIt = _keySet.iterator();
      while (ctxIt.hasNext()) {
        {
          final String ctx = ctxIt.next();
          final List<AbstractEntityId> entityIds = contextEntityIds.get(ctx);
          String _firstUpper = StringExtensions.toFirstUpper(ctx);
          final String className = (_firstUpper + "EntityIdFactory");
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
          this.addReferences(sctx, entityIds);
          String _artifactName = this.getArtifactName();
          String _create = this.create(sctx, ctx, pkg, className, entityIds, resourceSet);
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
    ctx.requiresImport("java.util.Map");
    ctx.requiresImport("java.util.HashMap");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdFactory");
    ctx.requiresImport("org.fuin.ddd4j.ddd.SingleEntityIdFactory");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityId");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final List<AbstractEntityId> entityIds) {
    for (final AbstractEntityId entityId : entityIds) {
      {
        String _uniqueName = AbstractElementExtensions.uniqueName(entityId);
        ctx.requiresReference(_uniqueName);
        String _uniqueName_1 = AbstractElementExtensions.uniqueName(entityId);
        String _plus = (_uniqueName_1 + "Converter");
        ctx.requiresReference(_plus);
      }
    }
  }
  
  public Map<String, List<AbstractEntityId>> contextEntityIdMap(final ResourceSet resourceSet) {
    final Map<String, List<AbstractEntityId>> contextEntityIds = new HashMap<String, List<AbstractEntityId>>();
    TreeIterator<Notifier> _allContents = resourceSet.getAllContents();
    final Iterator<AbstractEntityId> iter = Iterators.<AbstractEntityId>filter(_allContents, AbstractEntityId.class);
    while (iter.hasNext()) {
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
    }
    return contextEntityIds;
  }
  
  public String create(final SimpleCodeSnippetContext sctx, final String ctx, final String pkg, final String className, final List<AbstractEntityId> entityIds, final ResourceSet resourceSet) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
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
      _builder.append(className, "");
      _builder.append(" implements EntityIdFactory {");
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
      _builder.append("public ");
      _builder.append(className, "    ");
      _builder.append("() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("super();");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("map = new HashMap<String, SingleEntityIdFactory>();");
      _builder.newLine();
      {
        for(final AbstractEntityId entityId : entityIds) {
          _builder.append("\t\t");
          _builder.append("map.put(");
          String _name = entityId.getName();
          _builder.append(_name, "\t\t");
          _builder.append(".TYPE.asString(), new ");
          String _name_1 = entityId.getName();
          _builder.append(_name_1, "\t\t");
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
      _builder.append("  \t\t\t");
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
      final String src = _builder.toString();
      String _copyrightHeader = this.getCopyrightHeader();
      Set<String> _imports = sctx.getImports();
      SrcAll _srcAll = new SrcAll(_copyrightHeader, pkg, _imports, src);
      _xblockexpression = _srcAll.toString();
    }
    return _xblockexpression;
  }
}
