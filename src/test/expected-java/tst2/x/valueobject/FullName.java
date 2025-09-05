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
package tst2.x.valueobject;

import jakarta.json.bind.annotation.JsonbProperty;
import jakarta.validation.constraints.NotNull;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlRootElement;
import java.io.Serial;
import java.io.Serializable;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.ValueObject;
import org.fuin.objects4j.ui.Examples;
import org.fuin.objects4j.ui.Label;
import org.fuin.objects4j.ui.Prompt;
import org.fuin.objects4j.ui.ShortLabel;
import org.fuin.objects4j.ui.Tooltip;

/**
 * A person's full nomenclature, also known as a personal name.
 */
@ShortLabel(bundle = "x", key = "valueobject.FullName.slabel", value = "Name")
@Label(bundle = "x", key = "valueobject.FullName.label", value = "Full name")
@Tooltip(bundle = "x", key = "valueobject.FullName.tooltip", value = "A person's full nomenclature, also known as a personal name")
@Examples(value = { "Peter Parker","Mary Jane Watson","Harry Osborn" })
@XmlRootElement(name = "full-name")
public final class FullName implements ValueObject, Serializable {

    @Serial
    private static final long serialVersionUID = 1000L;
    
    @NotNull
    @XmlAttribute(name = "first-name")
    @JsonbProperty("first-name")
    @ShortLabel(key = "firstName.slabel", value = "First")
    @Label(key = "firstName.label", value = "First name")
    @Tooltip(key = "firstName.tooltip", value = "A given name, also known as a personal name or forename")
    @Prompt(key = "firstName.prompt", value = "Enter your first name")
    @Examples(value = { "Peter","Mary Jane","Harry" })
    private String firstName;
    
    @NotNull
    @XmlAttribute(name = "last-name")
    @JsonbProperty("last-name")
    @ShortLabel(key = "lastName.slabel", value = "Last")
    @Label(key = "lastName.label", value = "Last name")
    @Tooltip(key = "lastName.tooltip", value = "A family name, also known as a surname")
    @Prompt(key = "lastName.prompt", value = "Enter your last name")
    @Examples(value = { "Parker","Watson","Osborn" })
    private String lastName;
    
    /**
     * Default constructor.
     */
    protected FullName() {
        super();
    }
    
    /**
     * Constructor with all data.
     *
     * @param firstName First name.
     * @param lastName Last name.
     */
    public FullName(@NotNull final String firstName, @NotNull final String lastName) {
        super();
        Contract.requireArgNotNull("firstName", firstName);
        Contract.requireArgNotNull("lastName", lastName);
        
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    /**
     * Returns: First name.
     *
     * @return Current value.
     */
    @NotNull
    public final String getFirstName() {
        return firstName;
    }
    
    /**
     * Returns: Last name.
     *
     * @return Current value.
     */
    @NotNull
    public final String getLastName() {
        return lastName;
    }
    
}
