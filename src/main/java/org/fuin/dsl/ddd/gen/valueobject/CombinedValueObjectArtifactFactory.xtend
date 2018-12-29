package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig

/**
 * Combines the {@link SimpleStringValueObjectArtifactFactory} and the {@link ValueObjectArtifactFactory}.
 * The {@link SimpleStringValueObjectArtifactFactory} will be used for generation if possible. 
 * The {@link ValueObjectArtifactFactory} will be used in all other cases.  
 */
class CombinedValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	val SimpleStringValueObjectArtifactFactory simple;

	val ValueObjectArtifactFactory normal;

	new() {
		simple = new SimpleStringValueObjectArtifactFactory
		normal = new ValueObjectArtifactFactory
	}

	override getModelType() {
		typeof(ValueObject)
	}

	override init(ArtifactFactoryConfig config) {
		super.init(config);
		simple.init(config)
		normal.init(config)
	}	


	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {
			
		if (valueObject.base !== null && valueObject.base.name == "String" && valueObject.attributes.size > 0) {			
			return simple.create(valueObject, context, preparationRun)
		}
		
		return normal.create(valueObject, context, preparationRun)
				
	}

}
