%CASE GENERATOR
%kill prob and detect prob is  followed by Uniform(0.3,0.7)
%***the distrubution of uncertain parameteris followed by Uniform((1-alpha)p,(1+alpha)p)
%feasibility matrix is generated randomly.
%every weapon possesses 3 unit of ammunition
%every weapon and sensor can allocate one target at most in each stage.
%the cost of weapon and sensor is generated within the range of [10,50]
%the value vector of threaten target is generated in the interval [10 100]
%scale of problem is assumed to be Stage = 4, Weapon = 5, Q(sensor) = 5, Target = 8
S=4;W=5;Q=5;T=8;
Scale = [S,W,Q,T];

P_SWT = 0.3+rand(S,W,T)*0.4;
Z_SWT = rand(S,W,T);
Z_SWT = Z_SWT>0.5;

P_SQT = 0.3+rand(S,Q,T)*0.4;
Z_SQT = rand(S,W,T);
Z_SQT = Z_SQT>0.5;

C_W = 10+rand(1,W)*40;
C_Q = 10+rand(1,Q)*40;

Value = 10+rand(1,T)*90;

Case_S4W5Q5T8 = cell(1,8);
Case_S4W5Q5T8{1} = Scale;
Case_S4W5Q5T8{2} = P_SWT;
Case_S4W5Q5T8{3} = Z_SWT;
Case_S4W5Q5T8{4} = P_SQT;
Case_S4W5Q5T8{5} = Z_SQT;
Case_S4W5Q5T8{6} = C_W;
Case_S4W5Q5T8{7} = C_Q;
Case_S4W5Q5T8{8} = Value;
save case_generator Case_S4W5Q5T8;