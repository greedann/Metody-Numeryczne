function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety

if t <= 0
    error('Czas musi być większy od 0');
end

M = 750; % [m/s]

m0 = 15e4; % [kg]
u = 2000; % [m/s]
q = 2700; % [kg/s]
g = 1.622; % [m/s^2]


v = u * log(m0 / (m0 - q * t)) - g * t;

velocity_delta = v - M;

end
