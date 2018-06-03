package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

/**
 * Creates some additional methods necessary for 
 * the appropriate base class for the value object.
 */
class SrcVoBaseOptionalMethods implements CodeSnippet {

	val CodeSnippetContext ctx;

	val String baseName;

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param base External base type: "String", "UUID", "Integer" or "Long" are currently supported.
	 */
	new(CodeSnippetContext ctx, ExternalType base) {
		this.ctx = ctx
		if (base === null) {
			this.baseName = null
		} else {
			this.baseName = base.name
		}
	}

	override toString() {
		if (baseName === null) {
			return ""
		}
		switch baseName {
			case "String": return ""
			case "UUID": return getUuidSrc()
			case "Integer": return getIntegerSrc()
			case "Long": return getLongSrc()
			default: return ""
		}
	}

	def String getUuidSrc() {
		'''	
	    @Override
	    public final String asString() {
	        return asBaseType().toString();
	    }
	    
		'''	
	}

	def String getIntegerSrc() {
		'''	
	    @Override
	    public final String asString() {
	        return asBaseType().toString();
	    }
	    
		'''	
	}

	def String getLongSrc() {
		'''	
	    @Override
	    public final String asString() {
	        return asBaseType().toString();
	    }
	    
		'''	
	}
	
}
