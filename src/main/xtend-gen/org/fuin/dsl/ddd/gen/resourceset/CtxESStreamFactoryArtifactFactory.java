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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
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
public class CtxESStreamFactoryArtifactFactory extends AbstractSource<ResourceSet> {
  public Class<? extends ResourceSet> getModelType() {
    return ResourceSet.class;
  }
  
  public boolean isIncremental() {
    return false;
  }
  
  public GeneratedArtifact create(final ResourceSet resourceSet, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final Map<String,List<AggregateId>> contextAggregateIds = this.contextAggregateIdMap(resourceSet);
      Set<String> _keySet = contextAggregateIds.keySet();
      final Iterator<String> ctxIt = _keySet.iterator();
      boolean _hasNext = ctxIt.hasNext();
      boolean _while = _hasNext;
      while (_while) {
        {
          final String ctx = ctxIt.next();
          final List<AggregateId> aggregateIds = contextAggregateIds.get(ctx);
          String _firstUpper = StringExtensions.toFirstUpper(ctx);
          final String className = (_firstUpper + "StreamFactory");
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
          this.addReferences(sctx, aggregateIds);
          String _artifactName = this.getArtifactName();
          String _create = this.create(sctx, ctx, pkg, className, aggregateIds, resourceSet);
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
    ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.IdStreamFactory");
    ctx.requiresImport("org.fuin.ddd4j.eventstore.jpa.Stream");
    ctx.requiresImport("org.fuin.ddd4j.eventstore.intf.StreamId");
    ctx.requiresImport("java.util.Map");
    ctx.requiresImport("java.util.HashMap");
    ctx.requiresImport("");
    ctx.requiresImport("");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final List<AggregateId> aggregateIds) {
    for (final AggregateId aggregateId : aggregateIds) {
      String _uniqueName = AbstractElementExtensions.uniqueName(aggregateId);
      ctx.requiresReference(_uniqueName);
    }
  }
  
  public Map<String,List<AggregateId>> contextAggregateIdMap(final ResourceSet resourceSet) {
    final Map<String,List<AggregateId>> contextEntityIds = new HashMap<String, List<AggregateId>>();
    TreeIterator<Notifier> _allContents = resourceSet.getAllContents();
    final Iterator<AggregateId> iter = Iterators.<AggregateId>filter(_allContents, AggregateId.class);
    boolean _hasNext = iter.hasNext();
    boolean _while = _hasNext;
    while (_while) {
      {
        final AggregateId aggregateId = iter.next();
        Context _context = EObjectExtensions.getContext(aggregateId);
        String _name = _context.getName();
        List<AggregateId> aggregateIds = contextEntityIds.get(_name);
        boolean _equals = Objects.equal(aggregateIds, null);
        if (_equals) {
          ArrayList<AggregateId> _arrayList = new ArrayList<AggregateId>();
          aggregateIds = _arrayList;
          Context _context_1 = EObjectExtensions.getContext(aggregateId);
          String _name_1 = _context_1.getName();
          contextEntityIds.put(_name_1, aggregateIds);
        }
        aggregateIds.add(aggregateId);
      }
      boolean _hasNext_1 = iter.hasNext();
      _while = _hasNext_1;
    }
    return contextEntityIds;
  }
  
  public String create(final SimpleCodeSnippetContext sctx, final String ctx, final String pkg, final String className, final List<AggregateId> aggregateIds, final ResourceSet resourceSet) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/**");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("* Creates a stream for all known aggregates based on a AggregateRootId.");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("@ApplicationScoped");
      _builder.newLine();
      _builder.append("public class ");
      _builder.append(className, "");
      _builder.append(" implements IdStreamFactory {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("private Map<String, IdStreamFactory> map;");
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
      _builder.append("map = new HashMap<String, IdStreamFactory>();");
      _builder.newLine();
      {
        for(final AggregateId aggregateId : aggregateIds) {
          _builder.append("\t\t");
          _builder.append("map.put(");
          String _name = aggregateId.getName();
          _builder.append(_name, "\t\t");
          _builder.append(".TYPE.asString(), new ");
          String _name_1 = aggregateId.getName();
          _builder.append(_name_1, "\t\t");
          _builder.append("StreamFactory());");
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
      _builder.append("public boolean containsType(final StreamId streamId) {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return map.get(streamId.getName()) != null;");
      _builder.newLine();
      _builder.append("  ");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("public Stream createStream(final StreamId streamId) {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final IdStreamFactory factory = map.get(streamId.getName());");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("if (factory == null) {");
      _builder.newLine();
      _builder.append("  ");
      _builder.append("throw new IllegalArgumentException(\"Unknown stream id type: \"");
      _builder.newLine();
      _builder.append("   ");
      _builder.append("+ streamId);");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return factory.createStream(streamId);");
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
