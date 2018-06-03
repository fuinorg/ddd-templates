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
package tst2.x.enumobject;

import javax.annotation.Nullable;
import javax.validation.constraints.NotNull;

import org.fuin.objects4j.common.Contract;

/** Enumeration type C - With deprecated instance. */
public enum EnumD {

    /** First. */
    A(1),

    /** Second. */
    B(2),

    /** Third. */
    C(3)

    ;

    @NotNull
    private Integer id;

    /** All instances. */
    public static final EnumD[] ALL = new EnumD[] { A, B, C };

    /** Valid instances. */
    public static final EnumD[] VALID = new EnumD[] { A, C };

    /** Deprecated instances. */
    public static final EnumD[] DEPRECTAED = new EnumD[] { B };

    /**
     * Determines if it's possible to return an enumeration instance for the
     * given value.
     * 
     * @param value
     *            Value to check.
     * 
     * @return TRUE if the {@link #valueOf(Integer)} will return a value else
     *         FALSE.
     */
    public static boolean isValid(@Nullable final Integer value) {
        if (value == null) {
            return true;
        }
        for (final EnumD v : ALL) {
            if (v.id.equals(v.id)) {
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
    public static EnumD valueOf(@Nullable final Integer value) {
        if (value == null) {
            return null;
        }
        for (final EnumD v : ALL) {
            if (v.id.equals(v.id)) {
                return v;
            }
        }
        throw new IllegalArgumentException("Unknown value: " + value);
    }

    private EnumD(@NotNull final Integer id) {
        Contract.requireArgNotNull("id", id);

        this.id = id;
    }

}
