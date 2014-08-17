package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.Map;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;

@SuppressWarnings("all")
public abstract class AbstractSource<T extends Object> implements ArtifactFactory<T> {
  private String artifactName;
  
  private Map<String, String> varMap;
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
    Map<String, String> _varMap = config.getVarMap();
    this.varMap = _varMap;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public String getArtifactName() {
    return this.artifactName;
  }
  
  private String getBasePkg() {
    Map<String, String> _nullSafe = CollectionExtensions.<String, String>nullSafe(this.varMap);
    return _nullSafe.get("basepkg");
  }
  
  private String getPkg() {
    Map<String, String> _nullSafe = CollectionExtensions.<String, String>nullSafe(this.varMap);
    return _nullSafe.get("pkg");
  }
  
  public String contextPkg(final String ctxName) {
    String _basePkg = this.getBasePkg();
    String _plus = (_basePkg + ".");
    String _plus_1 = (_plus + ctxName);
    String _plus_2 = (_plus_1 + ".");
    String _pkg = this.getPkg();
    return (_plus_2 + _pkg);
  }
  
  public String getCopyrightHeader() {
    Map<String, String> _nullSafe = CollectionExtensions.<String, String>nullSafe(this.varMap);
    final String header = _nullSafe.get("copyrightHeader");
    boolean _equals = Objects.equal(header, null);
    if (_equals) {
      return "";
    }
    return header;
  }
  
  public String asPackage(final Namespace ns) {
    String _pkg = this.getPkg();
    boolean _equals = Objects.equal(_pkg, null);
    if (_equals) {
      String _basePkg = this.getBasePkg();
      String _plus = (_basePkg + ".");
      Context _context = EObjectExtensions.getContext(ns);
      String _name = _context.getName();
      String _plus_1 = (_plus + _name);
      String _plus_2 = (_plus_1 + ".");
      String _name_1 = ns.getName();
      return (_plus_2 + _name_1);
    }
    String _basePkg_1 = this.getBasePkg();
    String _plus_3 = (_basePkg_1 + ".");
    Context _context_1 = EObjectExtensions.getContext(ns);
    String _name_2 = _context_1.getName();
    String _plus_4 = (_plus_3 + _name_2);
    String _plus_5 = (_plus_4 + ".");
    String _pkg_1 = this.getPkg();
    String _plus_6 = (_plus_5 + _pkg_1);
    String _plus_7 = (_plus_6 + ".");
    String _name_3 = ns.getName();
    return (_plus_7 + _name_3);
  }
}
