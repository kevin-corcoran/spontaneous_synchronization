using DifferentialEquations, Distributions, Random, Plots
Random.seed!(1234);


""" Set Parameters """
# number of oscillators
N = 150;
# number of timesteps for ODEProblem
T = 5000.0;

# mean frequency
mu = 0.0; 
# spread of frequencies. small => nearly identical
sigma = 0.1;
# normal distributed natural frequencies vector
omega = rand(Normal(mu, sigma), N);
# coupling strength
K = 4.0;

""" Kuramoto Model: Differential Equations """
# note: updating internal dt vector optimizes performance
function dtheta!(dt,theta,p,t)
    dt[:,1] = omega + K/N * sum(sin.(theta.-theta'),dims=1)';
end
# dtheta(theta, p, t) = omega + K/N * sum(sin.(theta.-theta'),dims=1)';

""" Solve Differential Equations """
# initial phase vector
theta0 = 2*pi*rand(N);
tspan = (0.0, T);

prob = ODEProblem(dtheta!,theta0,tspan);
sol = solve(prob);

""" Plot Solutions """
# initial phase portrait 
scatter(sol[:,1] .% 2*pi)
# final phase portrait
scatter(sol[:,end] .% 2*pi, ylims=(0,6))

# create a gif
@gif for i ∈ 1:size(sol)[2]
    scatter(sol[:,i] .% 2*pi, ylims=(0,6))
end every 1

# animate(sol .% 2*pi, foreground_color=:white, "g2.gif",every=5)