function f = genetic_operator(parent_chromosome,Weapon)

[N, L] = size(parent_chromosome);

L = L-4;
p = 1;

was_crossover = 0;
was_mutation = 0;

for i = 1:N
    if rand(1)<0.9
        pa = randperm(N,2);
        
        child_1 = parent_chromosome(pa(1), :);
        child_2 = parent_chromosome(pa(2), :);
        
        temp = round(rand(1)*L);
        index = randperm(L, temp);
        temp = child_1;
        child_1(index) = child_2(index);
        child_2(index) = temp(index);
        
        was_crossover = 1;
        was_mutation = 0;
    else
        parent_3 = randperm(N,1);
        child_3 = parent_chromosome(parent_3, :);
        for j = 1:L
            if rand<0.07 %mutation
                child_3(j) = randperm(Weapon, 1);
            end
        end
        
        was_mutation = 1;
        was_crossover = 0;
    end
    
    if was_crossover
        child(p,:) = child_1;
        child(p+1,:) = child_2;
        was_crossover = 0;
        p = p + 2;
    elseif was_mutation
        child(p,:) = child_3;
        was_mutation = 0;
        p = p + 1;
    end
end
f = child;
end