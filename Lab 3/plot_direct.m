function plot_direct(N,vtime_direct)
% N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
% vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N


plot(N,vtime_direct,'-o')
title('Czas obliczeń metody bezpośredniej w zależności od rozmiaru problemu')
xlabel('Rozmiar problemu')
ylabel('Czas obliczeń [s]')
saveas(gcf,'zadanie2.png')

end