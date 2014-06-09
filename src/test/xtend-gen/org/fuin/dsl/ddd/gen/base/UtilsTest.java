package org.fuin.dsl.ddd.gen.base;

import org.fest.assertions.Assertions;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.junit.Test;

@SuppressWarnings("all")
public class UtilsTest {
  @Test
  public void testSeparated() {
    String _separated = Utils.separated(",", null);
    StringAssert _assertThat = Assertions.assertThat(_separated);
    _assertThat.isEqualTo("");
    String _separated_1 = Utils.separated(",");
    StringAssert _assertThat_1 = Assertions.assertThat(_separated_1);
    _assertThat_1.isEqualTo("");
    String _separated_2 = Utils.separated(",", new String[] {});
    StringAssert _assertThat_2 = Assertions.assertThat(_separated_2);
    _assertThat_2.isEqualTo("");
    String _separated_3 = Utils.separated(",", new String[] { "a" });
    StringAssert _assertThat_3 = Assertions.assertThat(_separated_3);
    _assertThat_3.isEqualTo("a");
    String _separated_4 = Utils.separated(",", new String[] { "a", "b" });
    StringAssert _assertThat_4 = Assertions.assertThat(_separated_4);
    _assertThat_4.isEqualTo("a,b");
    String _separated_5 = Utils.separated("-", new String[] { "a", "b", "c" });
    StringAssert _assertThat_5 = Assertions.assertThat(_separated_5);
    _assertThat_5.isEqualTo("a-b-c");
  }
}
