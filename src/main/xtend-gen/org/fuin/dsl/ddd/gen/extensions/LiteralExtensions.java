package org.fuin.dsl.ddd.gen.extensions;

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.StringLiteral;

/**
 * Provides extension methods for Literal.
 */
@SuppressWarnings("all")
public class LiteralExtensions {
  /**
   * Returns the value of the literal with leading and trailing double quote.
   * 
   * @param literal Literal to enhance with double quotes.
   * 
   * @return Original value or string with double quotes.
   */
  public static String str(final Literal literal) {
    if ((literal instanceof StringLiteral)) {
      String _value = ((StringLiteral)literal).getValue();
      String _plus = ("\"" + _value);
      return (_plus + "\"");
    }
    return literal.getValue();
  }
}
