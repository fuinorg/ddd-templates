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
package tst.x.enumobject;

import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;
import java.util.List;

/** Enumeration type D - With integer base type. */
public final class EnumD extends AbstractEnumD {
    
    /** First. */
    public static final EnumD A = new EnumD(1);
    
    /** Second. */
    public static final EnumD B = new EnumD(2);
    
    /** Third. */
    public static final EnumD C = new EnumD(3);
    
    /** All instances. */
    public static final List<EnumD> ALL = List.of(
        A, B, C
    );
    
    /** Valid instances. */
    public static final List<EnumD> VALID = List.of(
        A, B, C
    );
    
    /** Deprecated instances. */
    public static final List<EnumD> DEPRECATED = List.of(
    );
    
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
            if (v.getId().equals(value)) {
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
    @Nullable
    public static EnumD valueOf(@Nullable final Integer value) {
        if (value == null) {
            return null;
        }
        for (final EnumD v : ALL) {
            if (v.getId().equals(value)) {
                return v;
            }
        }
        throw new IllegalArgumentException("Unknown value: " + value);
    }
    
    private EnumD(@NotNull final Integer id) {
        super(id);
    }
    
}
