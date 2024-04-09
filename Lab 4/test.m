% zad 1

omega = 10;
impedance_delta = impedance_magnitude(omega)

% zad 2
format long
f = @(x) x.^2 - 4.01;
a = 1;
b = 50;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,f);
size(xtab)

% zad 3
format long
f = @(x) x.^2 - 4.01;
a = 0;
b = 4;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,f);

% zad 4
a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;


[omega_bisection,~,~,xtab_bisection, xdif_bisection] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude);

[omega_secant,~,~,xtab_secant, xdif_secant] = secant_method(a,b,max_iterations,ytolerance,@impedance_magnitude);



subplot(2,1,1);
plot(xtab_bisection);
hold on;
plot(xtab_secant);
hold off;
title('Wartośc rozwiązania w kolejnych iteracjach');
xlabel('Numer iteracji');
ylabel('Wartość przybliżenia');
legend('Bisekcja','Sieczne');


subplot(2,1,2);
semilogy(xdif_bisection);
hold on;
semilogy(xdif_secant);
hold off;
title('Wartośc bezwzględne różnic w kolejnych iteracjach');
xlabel('Numer iteracji');
ylabel('Wartość różnicy');
legend('Bisekcja','Sieczne');

saveas(gcf, '4.png');

% zad 5
time = 10;
velocity_delta = rocket_velocity(time)

% zad 6

a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;


[time_bisection,~,~,xtab_bisection, xdif_bisection] = bisection_method(a,b,max_iterations,ytolerance,@rocket_velocity);

[time_secant,~,~,xtab_secant, xdif_secant] = secant_method(a,b,max_iterations,ytolerance,@rocket_velocity);



subplot(2,1,1);
plot(xtab_bisection);
hold on;
plot(xtab_secant);
hold off;
title('Wartośc rozwiązania w kolejnych iteracjach');
xlabel('Numer iteracji');
ylabel('Wartość przybliżenia');
legend('Bisekcja','Sieczne');


subplot(2,1,2);
semilogy(xdif_bisection);
hold on;
semilogy(xdif_secant);
hold off;
title('Wartośc bezwzględne różnic w kolejnych iteracjach');
xlabel('Numer iteracji');
ylabel('Wartość różnicy');
legend('Bisekcja','Sieczne');

saveas(gcf, '6.png');

% zad 7

N = 40000;
time_delta = estimate_execution_time(N)

% zad 8

a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;


[n_bisection,~,~,xtab_bisection, xdif_bisection] = bisection_method(a,b,max_iterations,ytolerance,@estimate_execution_time);

[n_secant,~,~,xtab_secant, xdif_secant] = secant_method(a,b,max_iterations,ytolerance,@estimate_execution_time);



subplot(2,1,1);
plot(xtab_bisection);
hold on;
plot(xtab_secant);
hold off;
title('Wartośc rozwiązania w kolejnych iteracjach');
xlabel('Numer iteracji');
ylabel('Wartość przybliżenia');
legend('Bisekcja','Sieczne');


subplot(2,1,2);
semilogy(xdif_bisection);
hold on;
semilogy(xdif_secant);
hold off;
title('Wartośc bezwzględne różnic w kolejnych iteracjach');
xlabel('Numer iteracji');
ylabel('Wartość różnicy');
legend('Bisekcja','Sieczne');

saveas(gcf, '8.png');

% zad 9

options = optimset('Display','iter');
fzero(@tan,4.5, options)
