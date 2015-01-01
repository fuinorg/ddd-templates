package org.fuin.dsl.ddd.gen.extensions

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal
import org.fuin.dsl.ddd.domainDrivenDesignDsl.StringLiteral

/**
 * Provides extension methods for Literal.
 */
class LiteralExtensions {

	/**
	 * Returns the value of the literal with leading and trailing double quote.
	 * 
	 * @param literal Literal to enhance with double quotes.
	 * 
	 * @return Original value or string with double quotes. 
	 */
	def static String str(Literal literal) {
		if (literal == null) {
			return null
		}
		if (literal instanceof StringLiteral) {
			return "\"" + literal.value + "\"";
		}
		return literal.value;
	}

}
