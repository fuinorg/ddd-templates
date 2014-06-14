package org.fuin.dsl.ddd.gen.base;

import com.google.common.collect.Sets;
import java.util.Collections;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcAllTest {
  @Test
  public void test() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Copyright (C) 2013 Future Invent Informationsmanagement GmbH. All rights");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* reserved. <http://www.fuin.org/>");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    final String copyright = _builder.toString();
    final String pkg = "org.fuin.dsl.ddd.gen";
    final Set<String> imports = Collections.<String>unmodifiableSet(Sets.<String>newHashSet("java.lang.Integer", "static org.fest.assertions.Assertions.assertThat"));
    final String src = "public class Dummy {}";
    final SrcAll testee = new SrcAll(copyright, pkg, imports, src);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder_1 = new StringConcatenation();
    _builder_1.append("/**");
    _builder_1.newLine();
    _builder_1.append(" ");
    _builder_1.append("* Copyright (C) 2013 Future Invent Informationsmanagement GmbH. All rights");
    _builder_1.newLine();
    _builder_1.append(" ");
    _builder_1.append("* reserved. <http://www.fuin.org/>");
    _builder_1.newLine();
    _builder_1.append(" ");
    _builder_1.append("*/");
    _builder_1.newLine();
    _builder_1.append("package org.fuin.dsl.ddd.gen;");
    _builder_1.newLine();
    _builder_1.newLine();
    _builder_1.append("import java.lang.Integer;");
    _builder_1.newLine();
    _builder_1.append("import static org.fest.assertions.Assertions.assertThat;");
    _builder_1.newLine();
    _builder_1.newLine();
    _builder_1.append("public class Dummy {}");
    _builder_1.newLine();
    _assertThat.isEqualTo(_builder_1.toString());
  }
}
