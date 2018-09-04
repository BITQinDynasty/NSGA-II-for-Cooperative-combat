function chromosome = initialize_the_population(Scale, pop)
Stage = Scale(1);
Weapon = Scale(2);
Sensor = Scale(3);
Target = Scale(4);

chromosome = unidrnd(Target+1, [pop, (Weapon + Sensor)*Stage])-1;
end