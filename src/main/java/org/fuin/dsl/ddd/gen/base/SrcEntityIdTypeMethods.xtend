package org.fuin.dsl.ddd.gen.base

import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates source code for the type related methods from {@ org.fuin.ddd4j.ddd.EntityId}.
 */
class SrcEntityIdTypeMethods implements CodeSnippet {

	val CodeSnippetContext ctx

	val String entityName

	new(CodeSnippetContext ctx, String entityName) {
		this.ctx = ctx
		this.entityName = entityName
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
	}

	override toString() {
		'''	
		/** Name that identifies the entity uniquely within the context. */	
		public static final EntityType TYPE = new StringBasedEntityType("«entityName»");

		@Override
		public final EntityType getType() {
			return TYPE;
		}
		
		@Override
		public final String asTypedString() {
			return TYPE + " " + asString();
		}
		'''
	}

}
