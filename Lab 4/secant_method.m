function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego (x0=a)
% b - prawa granica przedziału poszukiwań miejsca zerowego (x1=b)
% max_iterations - maksymalna liczba iteracji działania metody siecznych
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od x2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

xsolution = [];
ysolution = [];
iterations = [];
xtab = [];
xdif = [];

x0 = a;
x1 = b;
for i = 1:max_iterations
    x2 = x1 - fun(x1)*(x1-x0)/(fun(x1)-fun(x0));
    xtab = [xtab x2];
    if i > 1
        xdif = [xdif abs(xtab(i-1)-xtab(i))];
    end
    if abs(fun(x2)) < ytolerance
        xsolution = x2;
        ysolution = fun(x2);
        iterations = i;
        xtab = transpose(xtab);
        xdif = transpose(xdif);
        return;
    end
    x0 = x1;
    x1 = x2;

    if i == max_iterations
        xsolution = x2;
        ysolution = fun(x2);
        iterations = i;
    end

end
end
