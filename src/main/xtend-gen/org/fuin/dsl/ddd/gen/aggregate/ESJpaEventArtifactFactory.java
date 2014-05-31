package org.fuin.dsl.ddd.gen.aggregate;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ESJpaEventArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate) throws GenerateException {
    try {
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = aggregate.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + "Event.java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(aggregate, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final Aggregate aggregate, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.append(" ");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    String _asPackage = this.asPackage(ns);
    _builder.append(_asPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import javax.persistence.*;");
    _builder.newLine();
    _builder.append("import javax.validation.constraints.*;");
    _builder.newLine();
    _builder.append("import org.fuin.ddd4j.eventstore.jpa.*;");
    _builder.newLine();
    _builder.append("import org.fuin.objects4j.common.*;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    String _name = aggregate.getName();
    _builder.append(_name, " ");
    _builder.append(" event.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("@Table(name = \"");
    String _name_1 = aggregate.getName();
    String _sqlUpper = this.toSqlUpper(_name_1);
    _builder.append(_sqlUpper, "");
    _builder.append("_EVENTS\")");
    _builder.newLineIfNotEmpty();
    _builder.append("@Entity");
    _builder.newLine();
    _builder.append("@IdClass(");
    String _name_2 = aggregate.getName();
    _builder.append(_name_2, "");
    _builder.append("EventId.class)");
    _builder.newLineIfNotEmpty();
    _builder.append("public class ");
    String _name_3 = aggregate.getName();
    _builder.append(_name_3, "");
    _builder.append("Event extends StreamEvent {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Id");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Column(name = \"");
    String _name_4 = aggregate.getName();
    String _sqlUpper_1 = this.toSqlUpper(_name_4);
    _builder.append(_sqlUpper_1, "    ");
    _builder.append("_ID\")");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("private String ");
    String _name_5 = aggregate.getName();
    String _firstLower = StringExtensions.toFirstLower(_name_5);
    _builder.append(_firstLower, "    ");
    _builder.append("Id;");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Id");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Column(name = \"EVENT_NUMBER\")");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("private Integer eventNumber;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("private transient ");
    String _name_6 = aggregate.getName();
    _builder.append(_name_6, "    ");
    _builder.append("Id id;");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* Protected default constructor only required for JPA.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("protected ");
    String _name_7 = aggregate.getName();
    _builder.append(_name_7, "    ");
    _builder.append("Event() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* Constructor with all mandatory data.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* @param ");
    String _name_8 = aggregate.getName();
    String _firstLower_1 = StringExtensions.toFirstLower(_name_8);
    _builder.append(_firstLower_1, "     ");
    _builder.append("Id");
    _builder.newLineIfNotEmpty();
    _builder.append("     ");
    _builder.append("*            Unique aggregate identifier.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* @param version");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*            Version.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* @param eventEntry");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*            Event entry to connect.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public ");
    String _name_9 = aggregate.getName();
    _builder.append(_name_9, "    ");
    _builder.append("Event(@NotNull final ");
    String _name_10 = aggregate.getName();
    _builder.append(_name_10, "    ");
    _builder.append("Id ");
    String _name_11 = aggregate.getName();
    String _firstLower_2 = StringExtensions.toFirstLower(_name_11);
    _builder.append(_firstLower_2, "    ");
    _builder.append("Id,");
    _builder.newLineIfNotEmpty();
    _builder.append("\t    ");
    _builder.append("@NotNull final Integer version, final EventEntry eventEntry) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("super(eventEntry);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("Contract.requireArgNotNull(\"");
    String _name_12 = aggregate.getName();
    String _firstLower_3 = StringExtensions.toFirstLower(_name_12);
    _builder.append(_firstLower_3, "\t\t");
    _builder.append("Id\", ");
    String _name_13 = aggregate.getName();
    String _firstLower_4 = StringExtensions.toFirstLower(_name_13);
    _builder.append(_firstLower_4, "\t\t");
    _builder.append("Id);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("Contract.requireArgNotNull(\"version\", version);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.");
    String _name_14 = aggregate.getName();
    String _firstLower_5 = StringExtensions.toFirstLower(_name_14);
    _builder.append(_firstLower_5, "\t\t");
    _builder.append("Id = ");
    String _name_15 = aggregate.getName();
    String _firstLower_6 = StringExtensions.toFirstLower(_name_15);
    _builder.append(_firstLower_6, "\t\t");
    _builder.append("Id.asString();");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("this.eventNumber = version;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.id = ");
    String _name_16 = aggregate.getName();
    String _firstLower_7 = StringExtensions.toFirstLower(_name_16);
    _builder.append(_firstLower_7, "\t\t");
    _builder.append("Id;");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* Returns the unique aggregate identifier.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* @return Aggregate identifier.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final String get");
    String _name_17 = aggregate.getName();
    _builder.append(_name_17, "    ");
    _builder.append("Id() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    String _name_18 = aggregate.getName();
    String _firstLower_8 = StringExtensions.toFirstLower(_name_18);
    _builder.append(_firstLower_8, "\t\t");
    _builder.append("Id;");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* Returns the aggregate identifier.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* @return Name converted into a ");
    String _name_19 = aggregate.getName();
    String _firstLower_9 = StringExtensions.toFirstLower(_name_19);
    _builder.append(_firstLower_9, "     ");
    _builder.append(" ID.");
    _builder.newLineIfNotEmpty();
    _builder.append("     ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final ");
    String _name_20 = aggregate.getName();
    _builder.append(_name_20, "    ");
    _builder.append("Id getId() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("if (id == null) {");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("id = ");
    String _name_21 = aggregate.getName();
    _builder.append(_name_21, "\t\t    ");
    _builder.append("Id.valueOf(");
    String _name_22 = aggregate.getName();
    String _firstLower_10 = StringExtensions.toFirstLower(_name_22);
    _builder.append(_firstLower_10, "\t\t    ");
    _builder.append("Id);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return id;");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* Returns the event number of the stream.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("* @return Number that is unique in combination with the name.");
    _builder.newLine();
    _builder.append("     ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final Integer getEventNumber() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return eventNumber;");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("// CHECKSTYLE:OFF Generated code");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final int hashCode() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("final int prime = 31;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("int result = 1;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("result = prime * result\t+ ((");
    String _name_23 = aggregate.getName();
    String _firstLower_11 = StringExtensions.toFirstLower(_name_23);
    _builder.append(_firstLower_11, "\t\t");
    _builder.append("Id == null) ? 0 : ");
    String _name_24 = aggregate.getName();
    String _firstLower_12 = StringExtensions.toFirstLower(_name_24);
    _builder.append(_firstLower_12, "\t\t");
    _builder.append("Id.hashCode());");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("result = prime * result\t+ ((eventNumber == null) ? 0 : eventNumber.hashCode());");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return result;");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final boolean equals(final Object obj) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("if (this == obj)");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("if (obj == null)");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("if (getClass() != obj.getClass())");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t\t");
    String _name_25 = aggregate.getName();
    _builder.append(_name_25, "\t\t");
    _builder.append("Event other = (");
    String _name_26 = aggregate.getName();
    _builder.append(_name_26, "\t\t");
    _builder.append("Event) obj;");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("if (");
    String _name_27 = aggregate.getName();
    String _firstLower_13 = StringExtensions.toFirstLower(_name_27);
    _builder.append(_firstLower_13, "\t\t");
    _builder.append("Id == null) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t    ");
    _builder.append("if (other.");
    String _name_28 = aggregate.getName();
    String _firstLower_14 = StringExtensions.toFirstLower(_name_28);
    _builder.append(_firstLower_14, "\t\t    ");
    _builder.append("Id != null)");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t\t");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("} else if (!");
    String _name_29 = aggregate.getName();
    String _firstLower_15 = StringExtensions.toFirstLower(_name_29);
    _builder.append(_firstLower_15, "\t\t");
    _builder.append("Id.equals(other.");
    String _name_30 = aggregate.getName();
    String _firstLower_16 = StringExtensions.toFirstLower(_name_30);
    _builder.append(_firstLower_16, "\t\t");
    _builder.append("Id))");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t    ");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("if (eventNumber == null) {");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("if (other.eventNumber != null)");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("} else if (!eventNumber.equals(other.eventNumber))");
    _builder.newLine();
    _builder.append("\t\t    ");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("// CHECKSTYLE:ON");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("    ");
    _builder.append("public final String toString() {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return ");
    String _name_31 = aggregate.getName();
    String _firstLower_17 = StringExtensions.toFirstLower(_name_31);
    _builder.append(_firstLower_17, "\t\t");
    _builder.append("Id + \"-\" + eventNumber;");
    _builder.newLineIfNotEmpty();
    _builder.append("    ");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}