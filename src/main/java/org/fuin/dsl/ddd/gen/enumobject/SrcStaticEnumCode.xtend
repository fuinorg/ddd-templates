package org.fuin.dsl.ddd.gen.enumobject

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumInstance
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.TypeExtensions.*

/**
 * Creates static source code for an enumeration.
 */
class SrcStaticEnumCode implements CodeSnippet {

	val CodeSnippetContext ctx
	val String className
	val List<Attribute> attributes
	val Variable baseVar
	val List<EnumInstance> instances
	val ExternalType base

	new(CodeSnippetContext ctx, EnumObject enumObject) {
		this.ctx = ctx
		this.className = enumObject.name
		this.attributes = enumObject.attributes
		this.baseVar = attributes.nullSafe.first
		this.instances = enumObject.instances
		this.base = enumObject.base
		if (base !== null) {
			ctx.requiresImport("javax.validation.constraints.NotNull")
			ctx.requiresImport("javax.annotation.Nullable")
		}
	}
	
	override toString() {
		'''	
		/** All instances. */
		public static final «className»[] ALL = new «className»[] {
			«FOR in : instances SEPARATOR ", "»«in.name»«ENDFOR»
		};
		
		/** Valid instances. */
		public static final «className»[] VALID = new «className»[] {
			«FOR in : instances.valid SEPARATOR ", "»«in.name»«ENDFOR»
		};
		
		/** Deprecated instances. */
		public static final «className»[] DEPRECTAED = new «className»[] {
			«FOR in : instances.deprecated SEPARATOR ", "»«in.name»«ENDFOR»
		};
		
		«IF base !== null»
		/**
		 * Determines if it's possible to return an enumeration instance for the
		 * given value.
		 * 
		 * @param value
		 *            Value to check.
		 * 
		 * @return TRUE if the {@link #valueOf(«base.simpleName(ctx)»)} will return a value else
		 *         FALSE.
		 */
		public static boolean isValid(@Nullable final «base.simpleName(ctx)» value) {
			if (value == null) {
				return true;
			}
			for (final «className» v : ALL) {
				if («new SrcInvokeGetter(ctx, "v", baseVar)».equals(value)) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Returns an enumeration instance for the given value. Throws an
		 * {@link IllegalArgumentException} if the value is invalid.
		 * 
		 * @param value
		 *            Value to check.
		 * 
		 * @return Instance
		 */
		@NotNull
		public static «className» valueOf(@Nullable final «base.simpleName(ctx)» value) {
			if (value == null) {
				return null;
			}
			for (final «className» v : ALL) {
				if («new SrcInvokeGetter(ctx, "v", baseVar)».equals(value)) {
					return v;
				}
			}
			throw new IllegalArgumentException("Unknown value: " + value);
		}
		
		«ENDIF»
		'''
	}

	def private static List<EnumInstance> valid(List<EnumInstance> all) {
		val List<EnumInstance> list = new ArrayList<EnumInstance>()
		for (instance : all) {
			if (instance.deprecated === null) {
				list.add(instance)
			}
		}
		return list
	}

	def private static List<EnumInstance> deprecated(List<EnumInstance> all) {
		val List<EnumInstance> list = new ArrayList<EnumInstance>()
		for (instance : all) {
			if (instance.deprecated !== null) {
				list.add(instance)
			}
		}
		return list
	}

}
