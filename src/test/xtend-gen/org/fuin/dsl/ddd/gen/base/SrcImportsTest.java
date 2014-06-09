package org.fuin.dsl.ddd.gen.base;

import com.google.common.collect.Sets;
import java.util.Collections;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.gen.base.SrcImports;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcImportsTest {
  @Test
  public void test() {
    final Set<String> imports = Collections.<String>unmodifiableSet(Sets.<String>newHashSet("a.b.C", "c.d.e.F"));
    final SrcImports testee = new SrcImports(imports);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("import a.b.C;");
    _builder.newLine();
    _builder.append("import c.d.e.F;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
  }
}
