%Fabio Carletti

%
close all
clear all
clc
%

format short e

%Calculation first poin second part
dd_main;
%End first point second part

%
%

%Calculation second point second part
Emax = max(abs(Efield));
%End second point second part

%
%

%Calculation third point second part
%phi_n_theo = 0*([0:1:1000]');
phi_n_theo = 0;
phi_p_theo = 0;

epsilon_n = norm(phi_n_theo-phi_n,'inf');
epsilon_p = norm(phi_p_theo-phi_p,'inf');
%End third point second part

%
%

%Calculation fourth point second part

%J_n_theo = 0*([0:1:1000]'); , indifferente se così o come sotto
J_n_theo = 0;
J_p_theo = 0;

delta_n = norm(J_n_theo-Jn,'inf');
delta_p = norm(J_p_theo-Jp,'inf');
%End fourth point second part