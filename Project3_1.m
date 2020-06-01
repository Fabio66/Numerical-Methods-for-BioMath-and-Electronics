%Fabio Carletti 

%
close all
clear all
clc
%

%Constants%
    %Temperature Range%
    ItC      = [-100:0.1:100];                                          % °C
    It       = ItC + 273.15;                                            %  K
    %

q       = 1.6021892e-19 ;                                               % elementary charge ([] = C)
m0      = 9.109534e-31;                                                 % electron rest mass ([] = Kg = V A s^3 m^{-2})

hPl     = 6.626176e-34;                                                 % Planck constant ([] = V A s^2 = J s)
hPlred  = hPl/(2*pi);                                                   % reduced Planck constant ([] = V A s^2 = J s)

KB      = 1.3806488e-23;                                                % m^2 kg s^-2 K ^-1
Vth     = KB.*It/q ;                                                      % thermal voltage ([] = V)
Nav     = 6.022e23 ;                                                    % Avogadro's constant ([] = mol^{-1})

m_n_star_dos = m0*1.08;                                                 % electron effective mass for DOS calculations ([] = Kg)
m_p_star_dos = m0*0.81;                                             	% hole effective mass for DOS calculations ([] = Kg)

m_n_star_mob = m0*0.26;                                                 % electron effective mass for conductivity calculations ([] = Kg)
m_p_star_mob = m0*0.386;                                                % hole effective mass for conductivity calculations ([] = Kg)

    %LOW FIELD MOBILITIES%
    mu_n_LF      = 1400*1e-4;                                           % cm^(2)/V*s
    mu_p_LF      = 480*1e-4;                                            % cm^(2)/V*s
    %LOW FIELD MOBILITIES%
    
ND_plus     = 1e20;                                                     % m^(-3)
NA_minus    = [0.1 0.5 1 10 50 100 500]*1e21;                           % m^(-3)
%Constans end%

%Computation first point first part%

Egap    = 1.1785 - 9.025e-5.*It - 3.05e-7.*(It).^(2);                   % eV

Nv      = 2*(2*pi*m_p_star_dos*KB.*It/(hPl^(2))).^(3/2);                % m^-3
Nc      = 2*(2*pi*m_n_star_dos*KB.*It/(hPl^(2))).^(3/2);                % m^-3

Ei      = Egap/2 + (KB.*It/2).*log(Nv./Nc);

%Plot
figure
plot(It, Ei);
xlabel('T  [°C]');
ylabel('Ei [eV]');
title('Intrinsic Fermi level change with increasing temperature');

%End first point first part%

%
%

%Computation second point first part%

T       = 300;
Egap300 = 1.1785 - 9.025e-5*T - 3.05e-7*T^2;
error   = (Ei - Egap300/2);
errorn  = abs(error./Ei);   %abs acts elementwise by definition
epsilon = max(errorn)*100;      

%End second point first part%

%
%

%Computation third point first part%

    %Intrinsic silicon -> conductivity sigma? (T = 300K)
    

Nv300      = 2*(2*pi*m_p_star_dos*KB*T/(hPl^(2)))^(3/2);
Nc300      = 2*(2*pi*m_n_star_dos*KB*T/(hPl^(2)))^(3/2);

ni         = (Nc300*Nv300)^(1/2)*exp(-q*Egap300/(2*KB*T)); %Intrinsic concentration at T=300K

sigman_in  = q*mu_n_LF*ni;
sigmap_in  = q*mu_p_LF*ni;
sigmat_in  = sigmap_in + sigman_in;


    %Extrinsic silicon 

n = ND_plus/2 + 0.5*((ND_plus)^(2)+4*ni^(2))^(1/2);
p = (ni)^(2)/n;

sigman_ext = q*mu_n_LF*n;
sigmap_ext = q*mu_p_LF*p;
sigmat_ext = sigman_ext + sigmap_ext;
    
%End third point first part%

%
%

%Calculation fourth point first part%

psi_bi_c = -KB*T/q.*log(NA_minus/ni);
figure
semilogx(NA_minus,psi_bi_c);
xlabel('I_{dop} [m^-3]');
ylabel('\phi_{bi,c} [V]');
title('Built int potential of the Ohmic Contact as a function of Semiconductor Doping');

%eEnd fourth point first part%