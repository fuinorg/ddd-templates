package org.fuin.dsl.ddd.gen.entityid;

import com.google.common.base.Objects;
import java.util.Map;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcValueObjectConverter;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;

@SuppressWarnings("all")
public class EntityIdConverterArtifactFactory extends AbstractSource<EntityId> {
  public Class<? extends EntityId> getModelType() {
    return EntityId.class;
  }
  
  public GeneratedArtifact create(final EntityId entityId, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      ExternalType _base = entityId.getBase();
      boolean _equals = Objects.equal(_base, null);
      if (_equals) {
        return null;
      }
      String _name = entityId.getName();
      final String className = (_name + "Converter");
      EObject _eContainer = entityId.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      final String fqn = (_plus + className);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(entityId);
      String _plus_1 = (_uniqueName + "Converter");
      refReg.putReference(_plus_1, fqn);
      if (preparationRun) {
        return null;
      }
      String _artifactName = this.getArtifactName();
      String _copyrightHeader = this.getCopyrightHeader();
      String _asPackage_1 = this.asPackage(ns);
      ExternalType _base_1 = entityId.getBase();
      SrcValueObjectConverter _srcValueObjectConverter = new SrcValueObjectConverter(refReg, _copyrightHeader, _asPackage_1, entityId, _base_1, true);
      String _string = _srcValueObjectConverter.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
