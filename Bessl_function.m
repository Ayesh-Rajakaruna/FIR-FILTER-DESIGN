function [y] = Bessl_function(x)
bessellimit = 100;
y = 1;
for i = 1:bessellimit
    y = y + (1/factorial(i)*(x/2).^i).^2;
end

