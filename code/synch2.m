% number of oscillators
N = 150;

% normally distributed natural frequencies
mu = 0; % MEAN frequency.
sigma = 0.1; % "spread" of frequencies. small => nearly identical

% 1-by-N vector of normal random numbers from the normal 
% distribution with mean mu and standard deviations sigma
omega = normrnd(mu, sigma, [N,1]);

% coupling strength
K = 2;
% θi = ωi + \Sigma_{j=1}^{n} sin (θj − θi)
dtheta = @(t, theta) omega + K/N * sum(sin(theta-theta'))';

ns = 1:N; % N oscillators 
tspan = 0:0.01:1000;
y0 = 2*pi*rand(1,N)'; % initial phase vector

figure;
hold on;
title("Initial")
xlabel('oscillator')
ylabel('phase')
scatter(ns, y0);
hold off;


% figure;
[t,y] = ode15s(dtheta, tspan, y0);

% plot phase of oscillators after T time steps
figure;
hold on;
axis([0 150 0 7]);
scatter(ns,mod(y(end,:),2*pi));
% scatter(ns,y(end,:));
