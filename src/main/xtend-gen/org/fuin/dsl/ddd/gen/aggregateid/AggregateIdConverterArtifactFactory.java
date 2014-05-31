package org.fuin.dsl.ddd.gen.aggregateid;

import com.google.common.base.Objects;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AggregateIdConverterArtifactFactory extends AbstractSource<AggregateId> {
  public Class<? extends AggregateId> getModelType() {
    return AggregateId.class;
  }
  
  public GeneratedArtifact create(final AggregateId aggregateId) throws GenerateException {
    try {
      ExternalType _base = aggregateId.getBase();
      boolean _equals = Objects.equal(_base, null);
      if (_equals) {
        return null;
      }
      EObject _eContainer = aggregateId.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = aggregateId.getName();
      String _plus_1 = (_plus + _name);
      String _plus_2 = (_plus_1 + "Converter");
      String _replace = _plus_2.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      String _name_1 = aggregateId.getName();
      ExternalType _base_1 = aggregateId.getBase();
      String _name_2 = _base_1.getName();
      String __valueObjectConverterSource = this._valueObjectConverterSource(ns, _name_1, _name_2, true);
      byte[] _bytes = __valueObjectConverterSource.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
