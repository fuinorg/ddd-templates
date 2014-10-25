package org.fuin.dsl.ddd.gen.base;

import java.util.Collections;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.fest.assertions.Assertions;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.gen.base.SrcImports;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcImportsTest {
  @Test
  public void test() {
    final Set<String> imports = Collections.<String>unmodifiableSet(CollectionLiterals.<String>newHashSet("a.b.C", "c.d.e.F", "java.lang.String", "java.lang.Integer", "java.lang.annotation.Annotation", "java.lang.reflect.*"));
    final SrcImports testee = new SrcImports("a.b", imports);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("import c.d.e.F;");
    _builder.newLine();
    _builder.append("import java.lang.annotation.Annotation;");
    _builder.newLine();
    _builder.append("import java.lang.reflect.*;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
  }
}
