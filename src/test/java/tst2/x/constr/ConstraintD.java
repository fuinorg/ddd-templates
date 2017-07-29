/**
 * Copyright (C) 2015 Michael Schnell. All rights reserved. 
 * http://www.fuin.org/
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 3 of the License, or (at your option) any
 * later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library. If not, see http://www.gnu.org/licenses/.
 */
package tst2.x.constr;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;
import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Constraint D - Value object target - With exception - With variables
 */
@Target({ TYPE, METHOD, FIELD, ANNOTATION_TYPE, PARAMETER })
@Retention(RUNTIME)
@Constraint(validatedBy = ConstraintDValidator.class)
@Documented
// CHECKSTYLE:OFF:LineLength
public @interface ConstraintD {

	/** Used to create an error message. */
	String message() default "D is not allowed ${a} '${b}': ${validatedValue.a} - ${validatedValue.b} - ${validatedValue.c} - ${validatedValue.d}";

	/** Processing groups with which the constraint declaration is associated. */		
	Class<?>[] groups() default {};

	/** Payload with which the the constraint declaration is associated. */
	Class<? extends Payload>[] payload() default {};

	int a();
	
	String b();
	
}
//CHECKSTYLE:ON:LineLength
