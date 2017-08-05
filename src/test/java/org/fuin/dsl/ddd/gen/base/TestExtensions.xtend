package org.fuin.dsl.ddd.gen.base

/**
 * Test utilities.
 */
class TestExtensions {
	
	/** Folder with expected example classes that are splitted into an abstract and a concrete part. */
	public static final String EXAMPLES_ABSTRACT = "tst";

	/** Folder with expected example classes that are not splitted. */
	public static final String EXAMPLES_CONCRETE = "tst2";
	
	/**
	 * Returns the content of an example file in the EXAMPLES_ABSTRACT package.
	 * 
	 * @return File content as text.
	 */
	def static loadAbstractExample(String filename) {
		Utils.readAsString("src/test/expected-java/" + EXAMPLES_ABSTRACT + "/" + filename)
	}

	/**
	 * Returns the content of an example file in the EXAMPLES_CONCRETE package.
	 * 
	 * @return File content as text.
	 */
	def static loadConcreteExample(String filename) {
		Utils.readAsString("src/test/expected-java/" + EXAMPLES_CONCRETE + "/" + filename)
	}
	
}