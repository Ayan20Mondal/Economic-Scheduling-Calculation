% Economic Load Dispatch with Losses
% n alpha beta gamma pmin pmax ploss

data = [1 800 8.7 0.0040 60 680 0.000123;
        2 690 5.9 0.0056 59 750 0.000150;
        3 380 6.9 0.0089 93.4 390 0.000300];

alpha = data(:,2);
beta = data(:,3);
gamma = data(:,4);
pmin = data(:,5);
pmax = data(:,6);
ploss = data(:,7);

fprintf('\nAYAN MONDAL');

lambda = input('\n\nEnter the assumed value of lambda : \n');

p = zeros(3,1);
loss = 0;

demand = input('Enter the demand : \n');

deltap = 1;
iteration = 0;

while abs(deltap) > .0001
    iteration = iteration + 1;
    current_loss = 0; 
    for i = 1:3
        p(i) = (lambda - beta(i)) / (2 * [gamma(i) + lambda * ploss(i)]);
        current_loss = current_loss + ploss(i) * p(i)^2;
    end
    loss = current_loss;
    
    deltap = demand + loss - sum(p);
    
    if abs(deltap) > 0
        k = 0;
        for i = 1:3
            k = k + (gamma(i) + ploss(i) * beta(i)) / (2 * [gamma(i) + lambda * ploss(i)]^2);
        end
    end
    
    deltalambda = deltap / k;
    lambda = lambda + deltalambda;
end

totalcost = sum(alpha + beta .* p + gamma .* p.^2);

fprintf('\nFinal Results:\n');
display(lambda);
display(totalcost);

C = alpha + beta .* p + gamma .* p .* p; 

T = table(data(:,1), p, C, 'VariableNames', {'Unit', 'Power', 'Cost'});
disp(T);