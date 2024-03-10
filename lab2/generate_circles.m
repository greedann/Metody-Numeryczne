function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
index_number = 196766;
L1 = 6;

circles = zeros(n_max, 3);
circle_areas = zeros(1, n_max);
rand_counts = zeros(1, n_max);

i = 1;
probes = 0;
while i <= n_max
    probes = probes + 1;
    X = rand * a;
    Y = rand * a;
    R = rand * r_max;
    % Sprawdź, czy okrąg mieści się w kwadracie
    if X - R < 0 || X + R > a || Y - R < 0 || Y + R > a
        continue;
    end
    valid = true;
    % Sprawdź, czy okrąg nie przecina się z innymi
    for j = 1:i-1
        % Oblicz odległość między środkami okręgów
        d = sqrt((X - circles(j, 1))^2 + (Y - circles(j, 2))^2);
        % Sprawdź, czy odległość jest mniejsza od sumy promieni
        if d < circles(j, 3) + R
            valid = false;
            break;
        end
    end
    if valid
        circles(i, :) = [X, Y, R];
        circle_areas(i) = pi * R^2;
        rand_counts(i) = probes;
        probes = 0;
        i = i + 1;
    end
end
counts_mean = cumsum(rand_counts) ./ (1:n_max);
circle_areas = cumsum(circle_areas);
end