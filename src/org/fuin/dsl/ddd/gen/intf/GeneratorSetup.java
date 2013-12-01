package org.fuin.dsl.ddd.gen.intf;

import java.util.ArrayList;
import java.util.List;

import org.fuin.dsl.ddd.gen.aggregategen.AggregateGenerator;
import org.fuin.dsl.ddd.gen.entitygen.EntityGenerator;
import org.fuin.dsl.ddd.gen.enumgen.EnumGenerator;
import org.fuin.dsl.ddd.gen.eventgen.EventGenerator;
import org.fuin.dsl.ddd.gen.exceptions.ExceptionsGenerator;
import org.fuin.dsl.ddd.gen.validatorgen.ValidatorGenerator;
import org.fuin.dsl.ddd.gen.vogen.ValueObjectGenerator;

public class GeneratorSetup {

    private static List<ISubGenerator> projectGenerators;

    public static List<ISubGenerator> getProjectGenerators() {
        if (projectGenerators == null) {
            projectGenerators = new ArrayList<ISubGenerator>();

            // Add all generators
            projectGenerators.add(new ValidatorGenerator());
            projectGenerators.add(new ValueObjectGenerator());
            projectGenerators.add(new EnumGenerator());
            projectGenerators.add(new EntityGenerator());
            projectGenerators.add(new AggregateGenerator());
            projectGenerators.add(new ExceptionsGenerator());
            projectGenerators.add(new EventGenerator());

        }
        return projectGenerators;
    }



}
