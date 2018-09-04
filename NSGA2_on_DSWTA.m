function [] = NSGA2_on_DSWTA()
%% load scenario data
% detail in Generator
load case_generator Case_S4W5Q5T8;
Scale = Case_S4W5Q5T8{1};
P_SWT = Case_S4W5Q5T8{2};
Z_SWT = Case_S4W5Q5T8{3};
P_SQT = Case_S4W5Q5T8{4};
Z_SQT = Case_S4W5Q5T8{5};
C_W = Case_S4W5Q5T8{6};
C_Q = Case_S4W5Q5T8{7};
Value = Case_S4W5Q5T8{8};
%% initialize the population
pop = 50;% population size
V = Scale(1)*(Scale(2)+Scale(3)); % length of chromosome
chromosome = initialize_the_population(Scale, pop);
chromosome = repair_operator(Scale,Z_SWT,Z_SQT,chromosome);
Fitness = evaluate_objective(chromosome,Scale, P_SWT, P_SQT, C_W, C_Q, Value);
chromosome = [chromosome Fitness];

%% fast non-dominated sorting
chromosome = non_dominated_sorting(chromosome,V);

%% start the evolution process
gen = 500;
pool = round(pop/2);
tour = 2;
for i = 1:gen
    %tournament selection
    parent_chromosome = tournament_selection(chromosome, pool, tour);
    
    %perform Crossover and Mutation operator
    offspring_chromosome = ...
        genetic_operator(parent_chromosome,Scale(4));
    %repair offspring to feasible
    offspring_chromosome = repair_operator(Scale,Z_SWT,Z_SQT,offspring_chromosome);
    %evaluate the fitness of generated offspring
    fitness_offspring = evaluate_objective(offspring_chromosome,...
        Scale, P_SWT, P_SQT, C_W, C_Q, Value);
    offspring_chromosome(:, V+1:V+2) = fitness_offspring;
    
    %intermediate_chromosome
    intermediate_chromosome(1:pop, :) = chromosome;
    intermediate_chromosome(pop+1:pop+size(offspring_chromosome,1), :) = offspring_chromosome;
    %non-dominated sorting of intermediate chromosome
    intermediate_chromosome = non_dominated_sorting(intermediate_chromosome,V);
    
    chromosome = replace_chromosome(intermediate_chromosome, pop);
    if ~mod(i,10)
        clc
        fprintf('%d generations completed\n',i);
        %plot(-chromosome(:,V + 1),chromosome(:,V + 2),'*','Color',[i/500 0 i/500]);hold on;
    end
end
%% result
save solution chromosome

%% Visulize
plot(-chromosome(:,V + 1),chromosome(:,V + 2),'*');hold on;
end