package org.fuin.dsl.ddd.gen.event;

import com.google.common.base.Objects;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.dsl.ddd.gen.extensions.EventExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class EventTestArtifactFactory extends AbstractSource<Event> {
  public Class<? extends Event> getModelType() {
    return Event.class;
  }
  
  public GeneratedArtifact create(final Event event, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final EObject method = event.eContainer();
      final EObject container = method.eContainer();
      if ((container instanceof AbstractEntity)) {
        final AbstractEntity entity = ((AbstractEntity) container);
        String _name = event.getName();
        final String className = (_name + "Test");
        final Namespace ns = EObjectExtensions.getNamespace(entity);
        final String pkg = this.asPackage(ns);
        final String fqn = ((pkg + ".") + className);
        String _replace = fqn.replace(".", "/");
        final String filename = (_replace + ".java");
        final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
        String _uniqueName = EventExtensions.uniqueName(event);
        String _plus = (_uniqueName + "Test");
        refReg.putReference(_plus, fqn);
        if (preparationRun) {
          return null;
        }
        final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
        this.addImports(ctx);
        this.addReferences(ctx, event);
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
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter");
    ctx.requiresImport("static org.fest.assertions.Assertions.*");
    ctx.requiresImport("org.junit.Test");
    ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPathConverter");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPath");
    ctx.requiresImport("static org.fuin.units4j.Units4JUtils.serialize");
    ctx.requiresImport("static org.fuin.units4j.Units4JUtils.deserialize");
    ctx.requiresImport("static org.fuin.units4j.Units4JUtils.marshal");
    ctx.requiresImport("static org.fuin.units4j.Units4JUtils.unmarshal");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final Event event) {
    String _uniqueName = EventExtensions.uniqueName(event);
    ctx.requiresReference(_uniqueName);
    Aggregate _aggregate = EObjectExtensions.getAggregate(event);
    AggregateId _idType = _aggregate.getIdType();
    String _uniqueName_1 = AbstractElementExtensions.uniqueName(_idType);
    ctx.requiresReference(_uniqueName_1);
    EList<Variable> _variables = event.getVariables();
    List<Variable> _nullSafe = CollectionExtensions.<Variable>nullSafe(_variables);
    for (final Variable v : _nullSafe) {
      {
        Type _type = v.getType();
        String _uniqueName_2 = AbstractElementExtensions.uniqueName(_type);
        ctx.requiresReference(_uniqueName_2);
        String _multiplicity = v.getMultiplicity();
        boolean _notEquals = (!Objects.equal(_multiplicity, null));
        if (_notEquals) {
          ctx.requiresImport("java.util.List");
        }
      }
    }
    Context _context = EObjectExtensions.getContext(event);
    String _name = _context.getName();
    String _firstUpper = StringExtensions.toFirstUpper(_name);
    String _plus = (_firstUpper + "EntityIdFactory");
    ctx.requiresReference(_plus);
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final Event event, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("// CHECKSTYLE:OFF");
      _builder.newLine();
      _builder.append("public final class ");
      String _name = event.getName();
      _builder.append(_name, "");
      _builder.append("Test {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Test");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public final void testSerializeDeserialize() {");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("// PREPARE");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final ");
      String _name_1 = event.getName();
      _builder.append(_name_1, "\t\t");
      _builder.append(" original = createTestee();");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("// TEST");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final ");
      String _name_2 = event.getName();
      _builder.append(_name_2, "\t\t");
      _builder.append(" copy = deserialize(serialize(original));");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("// VERIFY");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("assertThat(original).isEqualTo(copy);");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("@Test");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("public final void testMarshalUnmarshal() {");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("// PREPARE");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final ");
      String _name_3 = event.getName();
      _builder.append(_name_3, "\t\t");
      _builder.append(" original = createTestee();");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("// TEST");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("final String xml = marshal(original, createAdapter(), ");
      String _name_4 = event.getName();
      _builder.append(_name_4, "\t\t");
      _builder.append(".class);");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("final ");
      String _name_5 = event.getName();
      _builder.append(_name_5, "\t\t");
      _builder.append(" copy = unmarshal(xml, createAdapter(), ");
      String _name_6 = event.getName();
      _builder.append(_name_6, "\t\t");
      _builder.append(".class);");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("// VERIFY");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("assertThat(original).isEqualTo(copy);");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("private ");
      String _name_7 = event.getName();
      _builder.append(_name_7, "\t");
      _builder.append(" createTestee() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("// TODO Set test values");
      _builder.newLine();
      _builder.append("\t    ");
      _builder.append("final ");
      Aggregate _aggregate = EObjectExtensions.getAggregate(event);
      AggregateId _idType = _aggregate.getIdType();
      String _name_8 = _idType.getName();
      _builder.append(_name_8, "\t    ");
      _builder.append(" entityId = null;");
      _builder.newLineIfNotEmpty();
      {
        EList<Variable> _variables = event.getVariables();
        List<Variable> _nullSafe = CollectionExtensions.<Variable>nullSafe(_variables);
        for(final Variable v : _nullSafe) {
          _builder.append("\t\t");
          _builder.append("final ");
          String _type = VariableExtensions.type(v, ctx);
          _builder.append(_type, "\t\t");
          _builder.append(" ");
          String _name_9 = v.getName();
          _builder.append(_name_9, "\t\t");
          _builder.append(" = null;");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append("\t\t");
      _builder.append("return new ");
      String _name_10 = event.getName();
      EList<Variable> _variables_1 = event.getVariables();
      List<String> _varNames = CollectionExtensions.varNames(_variables_1);
      List<String> _union = Utils.<String>union("new EntityIdPath(entityId)", _varNames);
      SrcInvokeMethod _srcInvokeMethod = new SrcInvokeMethod(ctx, _name_10, _union);
      _builder.append(_srcInvokeMethod, "\t\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("protected final XmlAdapter<?, ?>[] createAdapter() {");
      _builder.newLine();
      _builder.append("        ");
      _builder.append("final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(new ");
      Context _context = EObjectExtensions.getContext(event);
      String _name_11 = _context.getName();
      String _firstUpper = StringExtensions.toFirstUpper(_name_11);
      _builder.append(_firstUpper, "        ");
      _builder.append("EntityIdFactory());");
      _builder.newLineIfNotEmpty();
      _builder.append("        ");
      _builder.append("return new XmlAdapter[] { entityIdPathConverter };");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _builder.append("// CHECKSTYLE:ON");
      _builder.newLine();
      final String src = _builder.toString();
      String _copyrightHeader = this.getCopyrightHeader();
      Set<String> _imports = ctx.getImports();
      SrcAll _srcAll = new SrcAll(_copyrightHeader, pkg, _imports, src);
      _xblockexpression = _srcAll.toString();
    }
    return _xblockexpression;
  }
}
