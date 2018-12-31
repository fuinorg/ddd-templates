package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId

/**
 * Creates the source code for a value object converter.
 */
class SrcValueObjectConverter implements CodeSnippet {

	val String copyrightHeader

	val String pkg

	val String voTypeName

	val String targetTypeName

	val boolean implementsSingleEntityIdFactory
	
	val boolean aggregateId

	val String className

	val SimpleCodeSnippetContext ctx

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param refReg Registry to use for resolving references to other generated artifacts.
	 * @param copyrightHeader Header with copyright for the source.
	 * @param pkg Package where the converter is located.
	 * @param vo Value object to generate the converter for.
	 * @param targetType External base type.
	 * @param implementsSingleEntityIdFactory TRUE if this is a converter for an entity ID.
	 */
	new(CodeReferenceRegistry refReg, String copyrightHeader, String pkg, AbstractVO vo, ExternalType targetType,
		boolean implementsSingleEntityIdFactory) {

		this.copyrightHeader = copyrightHeader
		this.pkg = pkg
		this.voTypeName = vo.name
		this.targetTypeName = targetType.name
		this.implementsSingleEntityIdFactory = implementsSingleEntityIdFactory
		if (vo instanceof AggregateId) {
			aggregateId = true
		} else {
			aggregateId = false
		}
		this.className = voTypeName + "Converter"

		ctx = new SimpleCodeSnippetContext(refReg)
		ctx.requiresImport("javax.enterprise.context.ApplicationScoped")
		ctx.requiresImport("javax.persistence.AttributeConverter")
		ctx.requiresImport("javax.persistence.Converter")
		ctx.requiresImport("javax.annotation.concurrent.ThreadSafe")
		ctx.requiresImport("org.fuin.objects4j.vo.AbstractValueObjectConverter")
		if (implementsSingleEntityIdFactory) {
			if (aggregateId) {
				ctx.requiresImport("org.fuin.ddd4j.ddd.AggregateRootId")
			} else {
				ctx.requiresImport("org.fuin.ddd4j.ddd.EntityId")			
			}
			ctx.requiresImport("org.fuin.ddd4j.ddd.SingleEntityIdFactory")
		}
		ctx.requiresReference(vo.uniqueName)
		ctx.requiresReference(targetType.uniqueName)

	}

	override toString() {
		val src = '''	
			/**
			 * Converts «voTypeName» from/to «targetTypeName».
			 */
			@ThreadSafe
			@ApplicationScoped
			@Converter(autoApply = true)
			public final class «className» extends
					AbstractValueObjectConverter<«targetTypeName», «voTypeName»> implements
					AttributeConverter<«voTypeName», «targetTypeName»>«IF implementsSingleEntityIdFactory», SingleEntityIdFactory«ENDIF» {
			
				@Override
				public Class<«targetTypeName»> getBaseTypeClass() {
					return «targetTypeName».class;
				}
			
				@Override
				public final Class<«voTypeName»> getValueObjectClass() {
					return «voTypeName».class;
				}
			
				@Override
				public final boolean isValid(final «targetTypeName» value) {
					return «voTypeName».isValid(value);
				}
			
				@Override
				public final «voTypeName» toVO(final «targetTypeName» value) {
					return «voTypeName».valueOf(value);
				}
			
				@Override
				public final «targetTypeName» fromVO(final «voTypeName» value) {
					if (value == null) {
						return null;
					}
					return value.asBaseType();
				}
			
				«IF implementsSingleEntityIdFactory»					
					@Override
					public final «IF aggregateId»AggregateRootId«ELSE»EntityId«ENDIF» createEntityId(final String id) {
						return «voTypeName».valueOf(id);
					}
				«ENDIF»
			
			}
		'''
		
		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString
		
	}

}
