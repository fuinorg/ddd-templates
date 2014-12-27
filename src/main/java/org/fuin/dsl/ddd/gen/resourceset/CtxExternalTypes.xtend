package org.fuin.dsl.ddd.gen.resourceset

import java.math.BigDecimal
import java.util.Currency
import java.util.Iterator
import java.util.Locale
import java.util.Map
import java.util.UUID
import org.eclipse.emf.ecore.resource.ResourceSet
import org.fuin.ddd4j.ddd.EntityIdPath
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.joda.time.LocalDate
import org.joda.time.LocalDateTime
import org.joda.time.LocalTime

import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

/**
 * Registers a set of external types. It does NOT create any source code.
 * The package for the types is expected to be "&lt;context&gt;.types".
 * The "ddd" file that contains the types should look like this:<br>
 * <code>
 * context myctx {
 *     namespace types {
 *         type Byte
 *         type Short
 *         type Integer
 *         type Long
 *         type Float
 *         type Double
 *         type Boolean
 *         type Character
 *         type String
 *         type Date
 *         type Time
 *         type Timestamp
 *         type UUID
 *         type Currency
 *         type BigDecimal
 *         type Locale
 *         type Object
 *         type EntityIdPath
 *     }
 * }
 * <code>
 * You can provide the following variables to customize the implementations:<br>
 * <code>types.Date</code> - Default="org.joda.time.LocalDate"<br>
 * <code>types.Time</code> - Default="org.joda.time.LocalTime"<br>
 * <code>types.Timestamp</code> - Default="org.joda.time.LocalDateTime"<br>
 * <code>types.UUID</code> - Default="java.util.UUID"<br>
 */
class CtxExternalTypes extends AbstractSource<ResourceSet> {

	override getModelType() {
		typeof(ResourceSet)
	}

	override isIncremental() {
		false
	}

	override create(ResourceSet resourceSet, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val dateType = getVar("types.Date", LocalDate.name)
		val timeType = getVar("types.Time", LocalTime.name)
		val dateTimeType = getVar("types.Timestamp", LocalDateTime.name)
		val uuidType = getVar("types.UUID", UUID.name)

		// Just registers the external types
		val Iterator<Context> iter = resourceSet.getAllContents().filter(typeof(Context))
		while (iter.hasNext) {
			val Context ctx = iter.next
			val name = ctx.name
			val CodeReferenceRegistry refReg = context.codeReferenceRegistry
			refReg.putReference(name + ".types.Byte", Byte.name)
			refReg.putReference(name + ".types.Short", Short.name)
			refReg.putReference(name + ".types.Integer", Integer.name)
			refReg.putReference(name + ".types.Long", Long.name)
			refReg.putReference(name + ".types.Float", Float.name)
			refReg.putReference(name + ".types.Double", Double.name)
			refReg.putReference(name + ".types.Boolean", Boolean.name)
			refReg.putReference(name + ".types.Character", Character.name)
			refReg.putReference(name + ".types.String", String.name)
			refReg.putReference(name + ".types.Date", dateType)
			refReg.putReference(name + ".types.Time", timeType)
			refReg.putReference(name + ".types.Timestamp", dateTimeType)
			refReg.putReference(name + ".types.UUID", uuidType)
			refReg.putReference(name + ".types.Currency", Currency.name)
			refReg.putReference(name + ".types.BigDecimal", BigDecimal.name)
			refReg.putReference(name + ".types.Locale", Locale.name)
			refReg.putReference(name + ".types.Object", Object.name)
			refReg.putReference(name + ".types.EntityIdPath", EntityIdPath.name)
		}

		// Will never produce anything
		return null

	}

}
