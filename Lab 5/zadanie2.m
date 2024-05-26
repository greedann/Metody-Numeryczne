function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev
N = 16;
x_fine = linspace(-1, 1, 1000);
x_coarse = linspace(-1, 1, N);
nodes_Chebyshev = get_Chebyshev_nodes(N);

V = fliplr(vander(x_coarse));
V2 = fliplr(vander(nodes_Chebyshev));
original_Runge = 1 ./ (1 + 25 * x_fine.^2);

y_runge = 1 ./ (1 + 25 * x_coarse.^2);
y_runge = y_runge';
c_runge = V \ y_runge;
interpolated_Runge = polyval(flipud(c_runge), x_fine);

y_runge_chebyshev = 1 ./ (1 + 25 * nodes_Chebyshev.^2);
c_runge_chebyshev = V2 \ y_runge_chebyshev';
interpolated_Runge_Chebyshev = polyval(flipud(c_runge_chebyshev), x_fine);

subplot(2,1,1);
plot(x_fine, original_Runge, 'DisplayName', 'Original Runge');
xlabel('x');
ylabel('y');
hold on;
plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolacja równomierna');
plot(x_coarse, y_runge, 'o', 'DisplayName', 'Węzły interpolacji');
title('Interpolacja dla równomiernie rozmieszczonych punktów');
legend show;

subplot(2,1,2);
plot(x_fine, original_Runge, 'DisplayName', 'Original Runge');
xlabel('x');
ylabel('y');
hold on;
plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolacja Czebyszewa');
plot(nodes_Chebyshev, y_runge_chebyshev, 'o', 'DisplayName', 'Węzły interpolacji');
title('Interpolacja dla węzłów Czebyszewa');
legend show;

saveas(gcf, 'zadanie2.png');
end

function nodes = get_Chebyshev_nodes(N)
% oblicza N węzłów Czebyszewa drugiego rodzaju
nodes = cos((0:N-1) * pi / (N-1));
end
