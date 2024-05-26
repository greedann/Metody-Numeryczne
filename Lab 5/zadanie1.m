function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
% Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
% V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
% interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej
%       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
% interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
%       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
N = 4:4:16;
x_fine = linspace(-1, 1, 1000);
original_Runge = 1 ./ (1 + 25 * x_fine.^2);


subplot(2,1,1);

plot(x_fine, original_Runge, 'DisplayName', 'Original Runge');
xlabel('x');
ylabel('y');

title('Interpolacja funkcji Runge');
hold on;
for i = 1:length(N)
    V{i} = vandermonde_matrix(N(i));% macierz Vandermond
    x_coarse = linspace(-1, 1, N(i));% węzły interpolacji
    y_runge = 1 ./ (1 + 25 * x_coarse.^2); % wartości funkcji interpolowanej w węzłach interpolacji
    
    c_runge = V{i} \ y_runge'; % współczynniki wielomianu interpolującego
    interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % interpolacja || polyval - funkcja do wyznaczania wartości wielomianu
    plot (x_fine, interpolated_Runge{i})
end
legend show;
hold off

original_sine = sin(2 * pi * x_fine);
subplot(2,1,2);

plot(x_fine, original_sine, 'DisplayName', 'Original Sinus');
xlabel('x');
ylabel('y');
title('Interpolacja funkcji Sine');
hold on;
for i = 1:length(N)
    x_coarse = linspace(-1, 1, N(i));
    y_sine = sin(2 * pi * x_coarse);
    c_sine = V{i} \ y_sine';
    interpolated_sine{i} = polyval(flipud(c_sine), x_fine);
    plot (x_fine, interpolated_sine{i})
end
legend show;
hold off
saveas(gcf, 'zadanie1.png');
end

function V = vandermonde_matrix(N)
% Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
x_coarse = linspace(-1,1,N);
V = fliplr(vander(x_coarse));
end
