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
import java.util.Collection
import java.util.List
import java.util.Set

/**
 * Registers a set of external types. It does NOT create any source code.
 * The default namespace for the types is expected to be "&lt;context&gt;.types".
 * It's possible to change the namespace using the variable <code>namespace</code>
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
 *         type Collection generics 1
 *         type List generics 1
 *         type Map generics 2
 *         type Set generics 1
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

		val pkg = getVar("namespace", "types")
		val dateType = getVar(pkg + ".Date", LocalDate.name)
		val timeType = getVar(pkg + ".Time", LocalTime.name)
		val dateTimeType = getVar(pkg + ".Timestamp", LocalDateTime.name)
		val uuidType = getVar(pkg + ".UUID", UUID.name)

		// Just registers the external types
		val Iterator<Context> iter = resourceSet.getAllContents().filter(typeof(Context))
		while (iter.hasNext) {
			val Context ctx = iter.next
			val name = ctx.name
			val CodeReferenceRegistry refReg = context.codeReferenceRegistry
			refReg.putReference(name + "." + pkg + ".Byte", Byte.name)
			refReg.putReference(name + "." + pkg + ".Short", Short.name)
			refReg.putReference(name + "." + pkg + ".Integer", Integer.name)
			refReg.putReference(name + "." + pkg + ".Long", Long.name)
			refReg.putReference(name + "." + pkg + ".Float", Float.name)
			refReg.putReference(name + "." + pkg + ".Double", Double.name)
			refReg.putReference(name + "." + pkg + ".Boolean", Boolean.name)
			refReg.putReference(name + "." + pkg + ".Character", Character.name)
			refReg.putReference(name + "." + pkg + ".String", String.name)
			refReg.putReference(name + "." + pkg + ".Date", dateType)
			refReg.putReference(name + "." + pkg + ".Time", timeType)
			refReg.putReference(name + "." + pkg + ".Timestamp", dateTimeType)
			refReg.putReference(name + "." + pkg + ".UUID", uuidType)
			refReg.putReference(name + "." + pkg + ".Currency", Currency.name)
			refReg.putReference(name + "." + pkg + ".BigDecimal", BigDecimal.name)
			refReg.putReference(name + "." + pkg + ".Locale", Locale.name)
			refReg.putReference(name + "." + pkg + ".Object", Object.name)
			refReg.putReference(name + "." + pkg + ".EntityIdPath", EntityIdPath.name)
			refReg.putReference(name + "." + pkg + ".Collection", Collection.name)
			refReg.putReference(name + "." + pkg + ".List", List.name)
			refReg.putReference(name + "." + pkg + ".Map", Map.name)
			refReg.putReference(name + "." + pkg + ".Set", Set.name)
			
		}

		// Will never produce anything
		return null

	}

}
