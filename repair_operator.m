function chromosome = repair_operator(Scale, Z_SWT, Z_SQT, chromosome)
Stage = Scale(1);
Weapon = Scale(2);
Sensor = Scale(3);
Target = Scale(4);
ammunition_constrain = 3;

for i = 1:size(chromosome,1)%pop
    ammunition_consumption = zeros(1,Weapon);
    
%% transform chromosome into 0-1 matrix form
    X = zeros(Stage,Weapon,Target);
    Y = zeros(Stage,Sensor,Target);
    individual = chromosome(i,:);
    for j = 0:Stage-1
        for k1 = 1:Weapon
            if individual( j*(Weapon+Sensor)+k1 ) ~= 0 && ...
                    Z_SWT(j+1,k1,individual( j*(Weapon+Sensor)+k1 )) == 1
                X(j+1,k1,individual( j*(Weapon+Sensor)+k1 )) = 1;
                ammunition_consumption(k1) = ammunition_consumption(k1) + 1;
            end
        end
        for k2 = Weapon+1:Weapon+Sensor
            if individual( j*(Weapon+Sensor)+k2 ) ~= 0 && ...
                    Z_SQT(j+1,k2-Weapon,individual( j*(Weapon+Sensor)+k2 )) == 1
                Y(j+1,k2-Weapon,individual( j*(Weapon+Sensor)+k2 )) = 1;
            end
        end
    end
%% repair infeasible solution
    for j = 1:Weapon
        if ammunition_consumption(j) > ammunition_constrain
            [index_S,index_T] = find(X(:,j,:)==1);
            temp = randperm(length(index_S),...
                ammunition_consumption(j)-ammunition_constrain);
            X(index_S(temp), j, index_T(temp)) = 0;
        end
    end
%% retransform into chromosome
    for j = 1:Stage
        for k1 = 1:Weapon
            temp = find(X(j,k1,:)==1);
            if ~isempty(temp)
                chromosome(i,(j-1)*(Weapon+Sensor)+k1) = temp(1);
            else
                chromosome(i,(j-1)*(Weapon+Sensor)+k1) = 0;
            end
        end
        
        for k2 = 1:Sensor
            temp = find(Y(j,k2,:)==1);
            if ~isempty(temp)
                chromosome(i,(j-1)*(Weapon+Sensor)+k2+Weapon) = temp(1);
            else
                chromosome(i,(j-1)*(Weapon+Sensor)+k2+Weapon) = 0;
            end
        end
    end
end

end