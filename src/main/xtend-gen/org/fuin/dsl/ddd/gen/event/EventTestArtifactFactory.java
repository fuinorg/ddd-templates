package org.fuin.dsl.ddd.gen.event;

import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class EventTestArtifactFactory extends AbstractSource<Event> {
  public Class<? extends Event> getModelType() {
    return Event.class;
  }
  
  public GeneratedArtifact create(final Event event) throws GenerateException {
    try {
      final EObject method = event.eContainer();
      final EObject container = method.eContainer();
      if ((container instanceof AbstractEntity)) {
        final AbstractEntity entity = ((AbstractEntity) container);
        EObject _eContainer = entity.eContainer();
        final Namespace ns = ((Namespace) _eContainer);
        String _asPackage = this.asPackage(ns);
        String _plus = (_asPackage + ".");
        String _name = event.getName();
        String _plus_1 = (_plus + _name);
        String _replace = _plus_1.replace(".", "/");
        final String filename = (_replace + "Test.java");
        String _artifactName = this.getArtifactName();
        CharSequence _create = this.create(event, ns);
        String _string = _create.toString();
        byte[] _bytes = _string.getBytes("UTF-8");
        return new GeneratedArtifact(_artifactName, filename, _bytes);
      }
      return null;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final Event event, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    String _asPackage = this.asPackage(ns);
    _builder.append(_asPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import static org.fest.assertions.Assertions.assertThat;");
    _builder.newLine();
    CharSequence __imports = this._imports(event);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("// CHECKSTYLE:OFF");
    _builder.newLine();
    _builder.append("public final class ");
    String _name = event.getName();
    _builder.append(_name, "");
    _builder.append("Test extends AbstractBaseTest {");
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
    _builder.append("}\t\t");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private ");
    String _name_7 = event.getName();
    _builder.append(_name_7, "\t");
    _builder.append(" createTestee() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("final AId aId = null;");
    _builder.newLine();
    {
      EList<Variable> _variables = event.getVariables();
      List<Variable> _nullSafe = this.<Variable>nullSafe(_variables);
      for(final Variable v : _nullSafe) {
        _builder.append("\t\t");
        _builder.append("final ");
        String _asJavaType = this.asJavaType(v);
        _builder.append(_asJavaType, "\t\t");
        _builder.append(" ");
        String _name_8 = v.getName();
        _builder.append(_name_8, "\t\t");
        _builder.append(" = null;");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return new ");
    String _name_9 = event.getName();
    _builder.append(_name_9, "\t\t");
    _builder.append("(new EntityIdPath(aId), ");
    EList<Variable> _variables_1 = event.getVariables();
    String __methodCall = this._methodCall(_variables_1);
    _builder.append(__methodCall, "\t\t");
    _builder.append(");");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}\t\t\t\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("protected final XmlAdapter<?, ?>[] createAdapter() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(new EmsEntityIdFactory());");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return new XmlAdapter[] { entityIdPathConverter };");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.append("// CHECKSTYLE:ON");
    _builder.newLine();
    return _builder;
  }
}
