%Fabio Carletti 

%
close all
clear all
clc
%

%Constants%
q       = 1.6021892e-19 ;                                           % elementary charge ([] = C)
m0      = 9.109534e-31;                                             % electron rest mass ([] = Kg = V A s^3 m^{-2})

hPl     = 6.626176e-34;                                             % Planck constant ([] = V A s^2 = J s)
hPlred  = hPl/(2*pi);                                               % reduced Planck constant ([] = V A s^2 = J s)

Vth    = kB*T/q ;                                                   % thermal voltage ([] = V)
Nav    = 6.022e23 ;                                                 % Avogadro's constant ([] = mol^{-1})

Kb      = 1.3806488e-23;                                            % m^2 kg s^-2 K ^-1

m_n_star_dos = m0*1.08;                                             % electron effective mass for DOS calculations ([] = Kg)
m_p_star_dos = m0*0.81;                                             % hole effective mass for DOS calculations ([] = Kg)
%Constans end%

%Computation first point first part%
It      = [-100:0.1:100];                                           % K

Egap    = 1.1785 - 9.025e-5.*It - 3.05e-7.*(It).^(2);               %eV

Nv      = 2*(2*pi*m_p_star_dos*Kb.*It/(h^(2)))^(3/2)
Nc      = 2*(2*pi*m_n_star_dos*Kb.*It/(h^(2)))^(3/2)

Ei      = Egap/2 + (Kb.*It/2).*log(Nv./Nc);

%Plot
figure
plot(It, Ei);
xlabel('It [°C]');
ylabel('Ei [eV]');
title('Intrinsic level change with temperature');

%End first point first part%