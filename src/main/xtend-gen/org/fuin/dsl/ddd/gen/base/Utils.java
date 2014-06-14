package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.Map;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;

/**
 * Provides utility methods for templates.
 */
@SuppressWarnings("all")
public class Utils {
  private final static String CODE_REFERENCE_REGISTRY_KEY = "CODE_REFERENCE_REGISTRY";
  
  /**
   * Returns a string containing all tokens separated by a separator string.
   * 
   * @param separator Separator to use.
   * @param tokens Array of tokens, empty array or null.
   * 
   * @return Tokens in the same order as in the array separated by the given separator.
   *         An empty array or null will return an empty string.
   */
  public static String separated(final String separator, final String... tokens) {
    boolean _equals = Objects.equal(tokens, null);
    if (_equals) {
      return "";
    }
    final StringBuilder sb = new StringBuilder();
    int count = 0;
    for (final String token : tokens) {
      {
        if ((count > 0)) {
          sb.append(separator);
        }
        sb.append(token);
        count = (count + 1);
      }
    }
    return sb.toString();
  }
  
  /**
   * Returns the registry from the map. If it does not exist, it will be created.
   * 
   * @param map Map with registry.
   * 
   * @return Registry.
   */
  public static CodeReferenceRegistry getCodeReferenceRegistry(final Map<String,Object> map) {
    Object _get = map.get(Utils.CODE_REFERENCE_REGISTRY_KEY);
    CodeReferenceRegistry reg = ((CodeReferenceRegistry) _get);
    boolean _equals = Objects.equal(reg, null);
    if (_equals) {
      SimpleCodeReferenceRegistry _simpleCodeReferenceRegistry = new SimpleCodeReferenceRegistry();
      reg = _simpleCodeReferenceRegistry;
      map.put(Utils.CODE_REFERENCE_REGISTRY_KEY, reg);
    }
    return reg;
  }
}