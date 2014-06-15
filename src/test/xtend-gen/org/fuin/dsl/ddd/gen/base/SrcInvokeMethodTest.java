package org.fuin.dsl.ddd.gen.base;

import java.util.ArrayList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcInvokeMethodTest {
  @Test
  public void testEmpty() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ArrayList<String> names = new ArrayList<String>();
    final SrcInvokeMethod testee = new SrcInvokeMethod(ctx, "super", names);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("super();");
    _assertThat.isEqualTo(_builder.toString());
  }
  
  @Test
  public void testOne() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ArrayList<String> names = new ArrayList<String>();
    names.add("a");
    final SrcInvokeMethod testee = new SrcInvokeMethod(ctx, "super", names);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("super(a);");
    _assertThat.isEqualTo(_builder.toString());
  }
  
  @Test
  public void testMultiple() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ArrayList<String> names = new ArrayList<String>();
    names.add("a");
    names.add("b");
    names.add("c");
    final SrcInvokeMethod testee = new SrcInvokeMethod(ctx, "super", names);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("super(a, b, c);");
    _assertThat.isEqualTo(_builder.toString());
  }
}
