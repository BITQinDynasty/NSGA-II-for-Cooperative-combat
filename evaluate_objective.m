function fitness = evaluate_objective(chromosome,Scale, P_SWT, P_SQT, C_W, C_Q, Value)
Stage = Scale(1);
Weapon = Scale(2);
Sensor = Scale(3);
Target = Scale(4);

fitness = zeros(size(chromosome,1), 2);

for i = 1:size(chromosome,1)
    prob_destroy = ones(1, Target);
    cost_weapon = 0;
    cost_sensor = 0;
    for j = 1:Stage
        prob_weapon = ones(1, Target);
        for k1 = 1:Weapon
            temp = chromosome(i, (j-1)*(Weapon+Sensor)+k1);%target id
            if temp ~= 0
                prob_weapon(temp) = prob_weapon(temp)*(1-P_SWT(j,k1,temp));
                cost_weapon = cost_weapon + C_W(k1);
            end
        end
        prob_weapon = 1-prob_weapon;
        
        prob_sensor = ones(1, Target);
        for k2 = 1:Sensor
            temp = chromosome(i, (j-1)*(Weapon+Sensor)+k2+Weapon);%target id
            if temp ~= 0
                prob_sensor(temp) = prob_sensor(temp)*(1-P_SQT(j,k2,temp));
                cost_sensor = cost_sensor + C_Q(k2);
            end
        end
        prob_sensor = 1-prob_sensor;
        
        prob_destroy = prob_destroy.*(1-prob_weapon.*prob_sensor);
    end
    prob_destroy = 1 - prob_destroy;
    
    fitness(i,1) = -sum(Value.*prob_destroy);% to minimize
    fitness(i,2) = cost_weapon + cost_sensor;
end

fitness;

end