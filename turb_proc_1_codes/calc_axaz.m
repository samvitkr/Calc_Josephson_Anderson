close all
clear all
Nx=2048;
Ny=512;
Nz=1536;
Lx=  8*pi;
Lz = 3*pi;
xp = [0:Nx-1]*Lx/(Nx);
zp=  [0:1:Nz-1]*Lz/(Nz);
dnu=1.0006e-3;
ut = 0.0499;
nu=dnu*ut;
 load('bsplinedata.mat');
load('kz_vals.mat');

kx = 2*(pi/Lx)*[0:Nx/2-1, 0, -Nx/2+1:-1];
lambdax=2*pi./kx(2:Nx/2-1);
%kxint=floor(kx(end));
kz = 2*(pi/Lz)*[0:Nz/2-1, 0, -Nz/2+1:-1];
lambdaz=2*pi./kz(2:Nz/2-1);
[Lx,Lz]=meshgrid(lambdax,lambdaz);
Lx=Lx';
Lz=Lz';
dkx=kx(2)-kx(1);
dkz=kz(2)-kz(1);

[Kx,Kz]=meshgrid(kx,kz);
Kx=Kx';
Kz=Kz';



%mw=matfile('smooth_2d_spectra_2.mat');
%winmax=mw.winmax;
%w=1;
jloc=[ 38;53;75;92;106;119;172 ];
njl=length(jloc);
ksi=zeros(Nx,Nz,njl);
kt=kztaylor(jloc);
aropt=jloc*0;
ar_try=aropt;
for jlo=1:njl
    nxi(jlo)=find(kx(1:Nx/2)<kt(jlo),1,'last'); 
    nzi(jlo)=find(kz(1:Nz/2)<kt(jlo),1,'last'); 

    %Kxi=Kx<kt(jlo);
    %Kzi=Kz<kt(jlo);
    %ki=Kxi.*Kzi;
    %ksi(:,:,jlo)=ki;
end
%ax=jloc*0;
%az=ax;
 for j=1:7
     j
     st=sprintf("smooth_2d_spectra_%d.mat",j);
     mw=matfile(st,'Writable',true);
%     distw=[distw;m.distw];
%     
% end
% for w=5:8
w=4;
win=1+2*(w-1);
y=1+yv(jloc(j));

fun = @(a)calc_gauss_filtersize_xz(a,Kx(1:nxi,1:nzi),Kz(1:nxi,1:nzi),mw.wconv(1:nxi,1:nzi,w)./ut^2);
%a0 = [4/y, 5/y];
%a=a0;
%ar=calc_gauss_filtersize_xz(a0,Kx(1:nxi,1:nzi),Kz(1:nxi,1:nzi),mw.wconv(1:nxi,1:nzi,w)./ut^2)
% lb = [0,0];
% ub = [kt(j),kt(j)]; 
% A = [];
% b = [];
% Aeq = [];
% beq = [];
aropt(j)=fun([ax(j),az(j)]);
ar_try(j)=fun([1/y,1.5/y]);
% a = fminsearch(fun,a0)
%a = fmincon(fun,a0,A,b,Aeq,beq,lb,ub)
%ax(j)=a(1);
%az(j)=a(2);
%y=1+yv(mw.jl);
%y=1+yv(92);
%a=[5.9427    1.9513];
%ax=a(1)/y;
%az=a(2)/y;
f=exp(-(Kx.^2/ax(j).^2+Kz.^2/az(j).^2));

 mp=max(max(-mw.wconv(1:nxi,1:nzi,w).*Kx(1:nxi,1:nzi).*Kz(1:nxi,1:nzi)./ut^2));
 mn=min(min(-mw.wconv(1:nxi,1:nzi,w).*Kx(1:nxi,1:nzi).*Kz(1:nxi,1:nzi)./ut^2));
%figure1 = figure('Colormap',...
%    [0 0 1;0.0078740157480315 0.0078740157480315 1;0.015748031496063 0.015748031496063 1;0.0236220472440945 0.0236220472440945 1;0.031496062992126 0.031496062992126 1;0.0393700787401575 0.0393700787401575 1;0.047244094488189 0.047244094488189 1;0.0551181102362205 0.0551181102362205 1;0.062992125984252 0.062992125984252 1;0.0708661417322835 0.0708661417322835 1;0.078740157480315 0.078740157480315 1;0.0866141732283465 0.0866141732283465 1;0.094488188976378 0.094488188976378 1;0.102362204724409 0.102362204724409 1;0.110236220472441 0.110236220472441 1;0.118110236220472 0.118110236220472 1;0.125984251968504 0.125984251968504 1;0.133858267716535 0.133858267716535 1;0.141732283464567 0.141732283464567 1;0.149606299212598 0.149606299212598 1;0.15748031496063 0.15748031496063 1;0.165354330708661 0.165354330708661 1;0.173228346456693 0.173228346456693 1;0.181102362204724 0.181102362204724 1;0.188976377952756 0.188976377952756 1;0.196850393700787 0.196850393700787 1;0.204724409448819 0.204724409448819 1;0.21259842519685 0.21259842519685 1;0.220472440944882 0.220472440944882 1;0.228346456692913 0.228346456692913 1;0.236220472440945 0.236220472440945 1;0.244094488188976 0.244094488188976 1;0.251968503937008 0.251968503937008 1;0.259842519685039 0.259842519685039 1;0.267716535433071 0.267716535433071 1;0.275590551181102 0.275590551181102 1;0.283464566929134 0.283464566929134 1;0.291338582677165 0.291338582677165 1;0.299212598425197 0.299212598425197 1;0.307086614173228 0.307086614173228 1;0.31496062992126 0.31496062992126 1;0.322834645669291 0.322834645669291 1;0.330708661417323 0.330708661417323 1;0.338582677165354 0.338582677165354 1;0.346456692913386 0.346456692913386 1;0.354330708661417 0.354330708661417 1;0.362204724409449 0.362204724409449 1;0.37007874015748 0.37007874015748 1;0.377952755905512 0.377952755905512 1;0.385826771653543 0.385826771653543 1;0.393700787401575 0.393700787401575 1;0.401574803149606 0.401574803149606 1;0.409448818897638 0.409448818897638 1;0.417322834645669 0.417322834645669 1;0.425196850393701 0.425196850393701 1;0.433070866141732 0.433070866141732 1;0.440944881889764 0.440944881889764 1;0.448818897637795 0.448818897637795 1;0.456692913385827 0.456692913385827 1;0.464566929133858 0.464566929133858 1;0.47244094488189 0.47244094488189 1;0.480314960629921 0.480314960629921 1;0.488188976377953 0.488188976377953 1;0.496062992125984 0.496062992125984 1;0.503937007874016 0.503937007874016 1;0.511811023622047 0.511811023622047 1;0.519685039370079 0.519685039370079 1;0.52755905511811 0.52755905511811 1;0.535433070866142 0.535433070866142 1;0.543307086614173 0.543307086614173 1;0.551181102362205 0.551181102362205 1;0.559055118110236 0.559055118110236 1;0.566929133858268 0.566929133858268 1;0.574803149606299 0.574803149606299 1;0.582677165354331 0.582677165354331 1;0.590551181102362 0.590551181102362 1;0.598425196850394 0.598425196850394 1;0.606299212598425 0.606299212598425 1;0.614173228346457 0.614173228346457 1;0.622047244094488 0.622047244094488 1;0.62992125984252 0.62992125984252 1;0.637795275590551 0.637795275590551 1;0.645669291338583 0.645669291338583 1;0.653543307086614 0.653543307086614 1;0.661417322834646 0.661417322834646 1;0.669291338582677 0.669291338582677 1;0.677165354330709 0.677165354330709 1;0.68503937007874 0.68503937007874 1;0.692913385826772 0.692913385826772 1;0.700787401574803 0.700787401574803 1;0.708661417322835 0.708661417322835 1;0.716535433070866 0.716535433070866 1;0.724409448818898 0.724409448818898 1;0.732283464566929 0.732283464566929 1;0.740157480314961 0.740157480314961 1;0.748031496062992 0.748031496062992 1;0.755905511811024 0.755905511811024 1;0.763779527559055 0.763779527559055 1;0.771653543307087 0.771653543307087 1;0.779527559055118 0.779527559055118 1;0.78740157480315 0.78740157480315 1;0.795275590551181 0.795275590551181 1;0.803149606299213 0.803149606299213 1;0.811023622047244 0.811023622047244 1;0.818897637795276 0.818897637795276 1;0.826771653543307 0.826771653543307 1;0.834645669291339 0.834645669291339 1;0.84251968503937 0.84251968503937 1;0.850393700787402 0.850393700787402 1;0.858267716535433 0.858267716535433 1;0.866141732283465 0.866141732283465 1;0.874015748031496 0.874015748031496 1;0.881889763779528 0.881889763779528 1;0.889763779527559 0.889763779527559 1;0.897637795275591 0.897637795275591 1;0.905511811023622 0.905511811023622 1;0.913385826771654 0.913385826771654 1;0.921259842519685 0.921259842519685 1;0.929133858267717 0.929133858267717 1;0.937007874015748 0.937007874015748 1;0.94488188976378 0.94488188976378 1;0.952755905511811 0.952755905511811 1;0.960629921259842 0.960629921259842 1;0.968503937007874 0.968503937007874 1;0.976377952755906 0.976377952755906 1;0.984251968503937 0.984251968503937 1;0.992125984251969 0.992125984251969 1;1 1 1;1 1 1;1 0.992125984251969 0.992125984251969;1 0.984251968503937 0.984251968503937;1 0.976377952755906 0.976377952755906;1 0.968503937007874 0.968503937007874;1 0.960629921259842 0.960629921259842;1 0.952755905511811 0.952755905511811;1 0.94488188976378 0.94488188976378;1 0.937007874015748 0.937007874015748;1 0.929133858267717 0.929133858267717;1 0.921259842519685 0.921259842519685;1 0.913385826771654 0.913385826771654;1 0.905511811023622 0.905511811023622;1 0.897637795275591 0.897637795275591;1 0.889763779527559 0.889763779527559;1 0.881889763779528 0.881889763779528;1 0.874015748031496 0.874015748031496;1 0.866141732283465 0.866141732283465;1 0.858267716535433 0.858267716535433;1 0.850393700787402 0.850393700787402;1 0.84251968503937 0.84251968503937;1 0.834645669291339 0.834645669291339;1 0.826771653543307 0.826771653543307;1 0.818897637795276 0.818897637795276;1 0.811023622047244 0.811023622047244;1 0.803149606299213 0.803149606299213;1 0.795275590551181 0.795275590551181;1 0.78740157480315 0.78740157480315;1 0.779527559055118 0.779527559055118;1 0.771653543307087 0.771653543307087;1 0.763779527559055 0.763779527559055;1 0.755905511811024 0.755905511811024;1 0.748031496062992 0.748031496062992;1 0.740157480314961 0.740157480314961;1 0.732283464566929 0.732283464566929;1 0.724409448818898 0.724409448818898;1 0.716535433070866 0.716535433070866;1 0.708661417322835 0.708661417322835;1 0.700787401574803 0.700787401574803;1 0.692913385826772 0.692913385826772;1 0.68503937007874 0.68503937007874;1 0.677165354330709 0.677165354330709;1 0.669291338582677 0.669291338582677;1 0.661417322834646 0.661417322834646;1 0.653543307086614 0.653543307086614;1 0.645669291338583 0.645669291338583;1 0.637795275590551 0.637795275590551;1 0.62992125984252 0.62992125984252;1 0.622047244094488 0.622047244094488;1 0.614173228346457 0.614173228346457;1 0.606299212598425 0.606299212598425;1 0.598425196850394 0.598425196850394;1 0.590551181102362 0.590551181102362;1 0.582677165354331 0.582677165354331;1 0.574803149606299 0.574803149606299;1 0.566929133858268 0.566929133858268;1 0.559055118110236 0.559055118110236;1 0.551181102362205 0.551181102362205;1 0.543307086614173 0.543307086614173;1 0.535433070866142 0.535433070866142;1 0.52755905511811 0.52755905511811;1 0.519685039370079 0.519685039370079;1 0.511811023622047 0.511811023622047;1 0.503937007874016 0.503937007874016;1 0.496062992125984 0.496062992125984;1 0.488188976377953 0.488188976377953;1 0.480314960629921 0.480314960629921;1 0.47244094488189 0.47244094488189;1 0.464566929133858 0.464566929133858;1 0.456692913385827 0.456692913385827;1 0.448818897637795 0.448818897637795;1 0.440944881889764 0.440944881889764;1 0.433070866141732 0.433070866141732;1 0.425196850393701 0.425196850393701;1 0.417322834645669 0.417322834645669;1 0.409448818897638 0.409448818897638;1 0.401574803149606 0.401574803149606;1 0.393700787401575 0.393700787401575;1 0.385826771653543 0.385826771653543;1 0.377952755905512 0.377952755905512;1 0.37007874015748 0.37007874015748;1 0.362204724409449 0.362204724409449;1 0.354330708661417 0.354330708661417;1 0.346456692913386 0.346456692913386;1 0.338582677165354 0.338582677165354;1 0.330708661417323 0.330708661417323;1 0.322834645669291 0.322834645669291;1 0.31496062992126 0.31496062992126;1 0.307086614173228 0.307086614173228;1 0.299212598425197 0.299212598425197;1 0.291338582677165 0.291338582677165;1 0.283464566929134 0.283464566929134;1 0.275590551181102 0.275590551181102;1 0.267716535433071 0.267716535433071;1 0.259842519685039 0.259842519685039;1 0.251968503937008 0.251968503937008;1 0.244094488188976 0.244094488188976;1 0.236220472440945 0.236220472440945;1 0.228346456692913 0.228346456692913;1 0.220472440944882 0.220472440944882;1 0.21259842519685 0.21259842519685;1 0.204724409448819 0.204724409448819;1 0.196850393700787 0.196850393700787;1 0.188976377952756 0.188976377952756;1 0.181102362204724 0.181102362204724;1 0.173228346456693 0.173228346456693;1 0.165354330708661 0.165354330708661;1 0.15748031496063 0.15748031496063;1 0.149606299212598 0.149606299212598;1 0.141732283464567 0.141732283464567;1 0.133858267716535 0.133858267716535;1 0.125984251968504 0.125984251968504;1 0.118110236220472 0.118110236220472;1 0.110236220472441 0.110236220472441;1 0.102362204724409 0.102362204724409;1 0.094488188976378 0.094488188976378;1 0.0866141732283465 0.0866141732283465;1 0.078740157480315 0.078740157480315;1 0.0708661417322835 0.0708661417322835;1 0.062992125984252 0.062992125984252;1 0.0551181102362205 0.0551181102362205;1 0.047244094488189 0.047244094488189;1 0.0393700787401575 0.0393700787401575;1 0.031496062992126 0.031496062992126;1 0.0236220472440945 0.0236220472440945;1 0.015748031496063 0.015748031496063;1 0.0078740157480315 0.0078740157480315;1 0 0]);
%figure1 = figure('Colormap',...
%    [0 0 1;0.0078740157480315 0.0078740157480315 1;0.015748031496063 0.015748031496063 1;0.0236220472440945 0.0236220472440945 1;0.031496062992126 0.031496062992126 1;0.0393700787401575 0.0393700787401575 1;0.047244094488189 0.047244094488189 1;0.0551181102362205 0.0551181102362205 1;0.062992125984252 0.062992125984252 1;0.0708661417322835 0.0708661417322835 1;0.078740157480315 0.078740157480315 1;0.0866141732283465 0.0866141732283465 1;0.094488188976378 0.094488188976378 1;0.102362204724409 0.102362204724409 1;0.110236220472441 0.110236220472441 1;0.118110236220472 0.118110236220472 1;0.125984251968504 0.125984251968504 1;0.133858267716535 0.133858267716535 1;0.141732283464567 0.141732283464567 1;0.149606299212598 0.149606299212598 1;0.15748031496063 0.15748031496063 1;0.165354330708661 0.165354330708661 1;0.173228346456693 0.173228346456693 1;0.181102362204724 0.181102362204724 1;0.188976377952756 0.188976377952756 1;0.196850393700787 0.196850393700787 1;0.204724409448819 0.204724409448819 1;0.21259842519685 0.21259842519685 1;0.220472440944882 0.220472440944882 1;0.228346456692913 0.228346456692913 1;0.236220472440945 0.236220472440945 1;0.244094488188976 0.244094488188976 1;0.251968503937008 0.251968503937008 1;0.259842519685039 0.259842519685039 1;0.267716535433071 0.267716535433071 1;0.275590551181102 0.275590551181102 1;0.283464566929134 0.283464566929134 1;0.291338582677165 0.291338582677165 1;0.299212598425197 0.299212598425197 1;0.307086614173228 0.307086614173228 1;0.31496062992126 0.31496062992126 1;0.322834645669291 0.322834645669291 1;0.330708661417323 0.330708661417323 1;0.338582677165354 0.338582677165354 1;0.346456692913386 0.346456692913386 1;0.354330708661417 0.354330708661417 1;0.362204724409449 0.362204724409449 1;0.37007874015748 0.37007874015748 1;0.377952755905512 0.377952755905512 1;0.385826771653543 0.385826771653543 1;0.393700787401575 0.393700787401575 1;0.401574803149606 0.401574803149606 1;0.409448818897638 0.409448818897638 1;0.417322834645669 0.417322834645669 1;0.425196850393701 0.425196850393701 1;0.433070866141732 0.433070866141732 1;0.440944881889764 0.440944881889764 1;0.448818897637795 0.448818897637795 1;0.456692913385827 0.456692913385827 1;0.464566929133858 0.464566929133858 1;0.47244094488189 0.47244094488189 1;0.480314960629921 0.480314960629921 1;0.488188976377953 0.488188976377953 1;0.496062992125984 0.496062992125984 1;0.503937007874016 0.503937007874016 1;0.511811023622047 0.511811023622047 1;0.519685039370079 0.519685039370079 1;0.52755905511811 0.52755905511811 1;0.535433070866142 0.535433070866142 1;0.543307086614173 0.543307086614173 1;0.551181102362205 0.551181102362205 1;0.559055118110236 0.559055118110236 1;0.566929133858268 0.566929133858268 1;0.574803149606299 0.574803149606299 1;0.582677165354331 0.582677165354331 1;0.590551181102362 0.590551181102362 1;0.598425196850394 0.598425196850394 1;0.606299212598425 0.606299212598425 1;0.614173228346457 0.614173228346457 1;0.622047244094488 0.622047244094488 1;0.62992125984252 0.62992125984252 1;0.637795275590551 0.637795275590551 1;0.645669291338583 0.645669291338583 1;0.653543307086614 0.653543307086614 1;0.661417322834646 0.661417322834646 1;0.669291338582677 0.669291338582677 1;0.677165354330709 0.677165354330709 1;0.68503937007874 0.68503937007874 1;0.692913385826772 0.692913385826772 1;0.700787401574803 0.700787401574803 1;0.708661417322835 0.708661417322835 1;0.716535433070866 0.716535433070866 1;0.724409448818898 0.724409448818898 1;0.732283464566929 0.732283464566929 1;0.740157480314961 0.740157480314961 1;0.748031496062992 0.748031496062992 1;0.755905511811024 0.755905511811024 1;0.763779527559055 0.763779527559055 1;0.771653543307087 0.771653543307087 1;0.779527559055118 0.779527559055118 1;0.78740157480315 0.78740157480315 1;0.795275590551181 0.795275590551181 1;0.803149606299213 0.803149606299213 1;0.811023622047244 0.811023622047244 1;0.818897637795276 0.818897637795276 1;0.826771653543307 0.826771653543307 1;0.834645669291339 0.834645669291339 1;0.84251968503937 0.84251968503937 1;0.850393700787402 0.850393700787402 1;0.858267716535433 0.858267716535433 1;0.866141732283465 0.866141732283465 1;0.874015748031496 0.874015748031496 1;0.881889763779528 0.881889763779528 1;0.889763779527559 0.889763779527559 1;0.897637795275591 0.897637795275591 1;0.905511811023622 0.905511811023622 1;0.913385826771654 0.913385826771654 1;0.921259842519685 0.921259842519685 1;0.929133858267717 0.929133858267717 1;0.937007874015748 0.937007874015748 1;0.94488188976378 0.94488188976378 1;0.952755905511811 0.952755905511811 1;0.960629921259842 0.960629921259842 1;0.968503937007874 0.968503937007874 1;0.976377952755906 0.976377952755906 1;0.984251968503937 0.984251968503937 1;0.992125984251969 0.992125984251969 1;1 1 1;1 1 1;1 0.992125984251969 0.992125984251969;1 0.984251968503937 0.984251968503937;1 0.976377952755906 0.976377952755906;1 0.968503937007874 0.968503937007874;1 0.960629921259842 0.960629921259842;1 0.952755905511811 0.952755905511811;1 0.94488188976378 0.94488188976378;1 0.937007874015748 0.937007874015748;1 0.929133858267717 0.929133858267717;1 0.921259842519685 0.921259842519685;1 0.913385826771654 0.913385826771654;1 0.905511811023622 0.905511811023622;1 0.897637795275591 0.897637795275591;1 0.889763779527559 0.889763779527559;1 0.881889763779528 0.881889763779528;1 0.874015748031496 0.874015748031496;1 0.866141732283465 0.866141732283465;1 0.858267716535433 0.858267716535433;1 0.850393700787402 0.850393700787402;1 0.84251968503937 0.84251968503937;1 0.834645669291339 0.834645669291339;1 0.826771653543307 0.826771653543307;1 0.818897637795276 0.818897637795276;1 0.811023622047244 0.811023622047244;1 0.803149606299213 0.803149606299213;1 0.795275590551181 0.795275590551181;1 0.78740157480315 0.78740157480315;1 0.779527559055118 0.779527559055118;1 0.771653543307087 0.771653543307087;1 0.763779527559055 0.763779527559055;1 0.755905511811024 0.755905511811024;1 0.748031496062992 0.748031496062992;1 0.740157480314961 0.740157480314961;1 0.732283464566929 0.732283464566929;1 0.724409448818898 0.724409448818898;1 0.716535433070866 0.716535433070866;1 0.708661417322835 0.708661417322835;1 0.700787401574803 0.700787401574803;1 0.692913385826772 0.692913385826772;1 0.68503937007874 0.68503937007874;1 0.677165354330709 0.677165354330709;1 0.669291338582677 0.669291338582677;1 0.661417322834646 0.661417322834646;1 0.653543307086614 0.653543307086614;1 0.645669291338583 0.645669291338583;1 0.637795275590551 0.637795275590551;1 0.62992125984252 0.62992125984252;1 0.622047244094488 0.622047244094488;1 0.614173228346457 0.614173228346457;1 0.606299212598425 0.606299212598425;1 0.598425196850394 0.598425196850394;1 0.590551181102362 0.590551181102362;1 0.582677165354331 0.582677165354331;1 0.574803149606299 0.574803149606299;1 0.566929133858268 0.566929133858268;1 0.559055118110236 0.559055118110236;1 0.551181102362205 0.551181102362205;1 0.543307086614173 0.543307086614173;1 0.535433070866142 0.535433070866142;1 0.52755905511811 0.52755905511811;1 0.519685039370079 0.519685039370079;1 0.511811023622047 0.511811023622047;1 0.503937007874016 0.503937007874016;1 0.496062992125984 0.496062992125984;1 0.488188976377953 0.488188976377953;1 0.480314960629921 0.480314960629921;1 0.47244094488189 0.47244094488189;1 0.464566929133858 0.464566929133858;1 0.456692913385827 0.456692913385827;1 0.448818897637795 0.448818897637795;1 0.440944881889764 0.440944881889764;1 0.433070866141732 0.433070866141732;1 0.425196850393701 0.425196850393701;1 0.417322834645669 0.417322834645669;1 0.409448818897638 0.409448818897638;1 0.401574803149606 0.401574803149606;1 0.393700787401575 0.393700787401575;1 0.385826771653543 0.385826771653543;1 0.377952755905512 0.377952755905512;1 0.37007874015748 0.37007874015748;1 0.362204724409449 0.362204724409449;1 0.354330708661417 0.354330708661417;1 0.346456692913386 0.346456692913386;1 0.338582677165354 0.338582677165354;1 0.330708661417323 0.330708661417323;1 0.322834645669291 0.322834645669291;1 0.31496062992126 0.31496062992126;1 0.307086614173228 0.307086614173228;1 0.299212598425197 0.299212598425197;1 0.291338582677165 0.291338582677165;1 0.283464566929134 0.283464566929134;1 0.275590551181102 0.275590551181102;1 0.267716535433071 0.267716535433071;1 0.259842519685039 0.259842519685039;1 0.251968503937008 0.251968503937008;1 0.244094488188976 0.244094488188976;1 0.236220472440945 0.236220472440945;1 0.228346456692913 0.228346456692913;1 0.220472440944882 0.220472440944882;1 0.21259842519685 0.21259842519685;1 0.204724409448819 0.204724409448819;1 0.196850393700787 0.196850393700787;1 0.188976377952756 0.188976377952756;1 0.181102362204724 0.181102362204724;1 0.173228346456693 0.173228346456693;1 0.165354330708661 0.165354330708661;1 0.15748031496063 0.15748031496063;1 0.149606299212598 0.149606299212598;1 0.141732283464567 0.141732283464567;1 0.133858267716535 0.133858267716535;1 0.125984251968504 0.125984251968504;1 0.118110236220472 0.118110236220472;1 0.110236220472441 0.110236220472441;1 0.102362204724409 0.102362204724409;1 0.094488188976378 0.094488188976378;1 0.0866141732283465 0.0866141732283465;1 0.078740157480315 0.078740157480315;1 0.0708661417322835 0.0708661417322835;1 0.062992125984252 0.062992125984252;1 0.0551181102362205 0.0551181102362205;1 0.047244094488189 0.047244094488189;1 0.0393700787401575 0.0393700787401575;1 0.031496062992126 0.031496062992126;1 0.0236220472440945 0.0236220472440945;1 0.015748031496063 0.015748031496063;1 0.0078740157480315 0.0078740157480315;1 0 0]);
subplot(2,4,j)
% w1=-ksi(1:Nx/2,1:Nz/2,j).*mw.wconv(1:Nx/2,1:Nz/2,w)./ut^2;
% w2=abs(w1)>1e-4;
% w3=w1.*w2;

hold on
dl=4*(pi^2)*((Lx.*Lz).^(-1));
pcolor(y*Kx(1:nxi,1:nzi),y*Kz(1:nxi,1:nzi),...Kx(1:Nx/2,1:Nz/2).*Kz(1:Nx/2,1:Nz/2).* f(1:nxi,1:nzi).*
   -f(1:nxi,1:nzi).*mw.wconv(1:nxi,1:nzi,w)./ut^2)
% pcolor(Lx,Lz,...
%     -dl.*mw.wconv(2:Nx/2-1,2:Nz/2-1,w)./ut^2)

%  mp=max(max(-dl.*mw.wconv(2:Nx/2-1,2:Nz/2-1,w)./ut^2));
%  mn=min(min(-dl.*mw.wconv(2:Nx/2-1,2:Nz/2-1,w)./ut^2));

%caxis([mn -mn])
caxis([-1e-3 1e-3])
shading interp
colormap(redblue)
%contour(Lx./y,Lz./y,-mw.wconv(2:Nx/2-1,2:Nz/2-1,w)./ut^2,[0 0],'k-','LineWidth',0.5)

%[cm,c]=contour(y.*Kx(5:Nx/2,10:Nz/2),y.*Kz(5:Nx/2,10:Nz/2),w3(5:Nx/2,10:Nz/2),[0 0],'k-','LineWidth',1.5)
contour(y.*Kx(1:nxi,1:nzi),y.*Kz(1:nxi,1:nzi),f(1:nxi,1:nzi),[0.5 0.5],'k-','LineWidth',1.5)
hold off
xlim([0.0 15])
ylim([0.0 15])
%xlim([0.2 max(lambdax)/y])
%ylim([0.2 max(lambdaz)/y])

%  xlim([0.01 100])
%  ylim([0.01 100])
% pbaspect([2 5 1])
h=colorbar;
% ylabel(h,'$ -4\pi^2(\phi_{u_2 \omega_3}-\phi_{u_3 \omega_2})/(u_{\tau}^2\lambda_x \lambda_z)$','interpreter','latex')%-k_x k_z
set(gca,'TickDir','out')
set(gca,'XMinorTick','on','YMinorTick','on')
grid on
%set(gca,'Xscale','log')
%set(gca,'Yscale','log')
pbaspect([1 1 1])

%xlabel('\lambda_x/h')
%ylabel('\lambda_z/h')
%xline( 4*y )
%yline(4*y)
 ylabel('yk_z')
 xlabel('yk_x')
%title('y^+=150, nofilter')
tstr=sprintf("y^+=%.01f w=%d",y/dnu,win);
title(tstr)



%%

% % % figure
% % % %hold on
% % % [CM,cc] = contour(y.*Kx(1:Nx/2,1:Nz/2),y.*Kz(1:Nx/2,1:Nz/2),...
% % %      -mw.wconv(1:Nx/2,1:Nz/2,1)./ut^2);
% % %  
% % %  cc.LineStyle = ':';
% % % cc.Color = 'w';
% % % Lvls = cc.LevelList;
% % % PosIdx = find(ismember(CM(1,:),Lvls(Lvls>=0)));
% % % PosLen = CM(2,PosIdx);
% % % NegIdx = find(ismember(CM(1,:),Lvls(Lvls<0))); 
% % % NegLen = CM(2,NegIdx);
% % % close all
% % % hold on
% % % for k = 1:numel(PosIdx)
% % %     IdxRng = PosIdx(k)+1:PosIdx(k)+PosLen(k);
% % %     plot(CM(1,IdxRng), CM(2,IdxRng), '-k')
% % % end
% % % % for k = 1:numel(NegIdx)
% % % %     IdxRng = NegIdx(k)+1:NegIdx(k)+NegLen(k);
% % % %     plot(CM(1,IdxRng), CM(2,IdxRng), '--k')
% % % % end
% % % hold off
% % % axis('equal')
% % % xlim([0 2])
% % % ylim([0 5])
% % % pbaspect([2 5 1])
 end


 
 

% 
% figure
% w=[1:15];
% win=1+2*(w-1);
% plot(win(1:end),mw.distw./ut^2,'o-')
% ylabel('||\phi(w+1)-\phi(w)||_{L2}/ut^2')
% xlabel('w')
% set(gca,'Yscale','log')

% rms_spec=zeros(16,1);
% 
% for w=1:16
%     r1=rms(mw.wconv(:,:,w),1);
%   rms_spec(w)=rms(r1,2);
% end
% figure
% w=[1:15];
% win=1+2*(w-1);
% 
% plot(win(1:end),rms_spec(2:end)./rms_spec(1),'o-')
% ylabel('\phi_{rms}/\phi_{rms}^{raw}')
% xlabel('w')
%set(gca,'Yscale','log')

% sumtot =squeeze(dkx*dkz*( sum(sum(mw.wconv),2)))./ut^2;
% sumtot2=squeeze(dkx*dkz*( sum(sum(mw.wconv(1:Nx/2,1:Nz/2,:)),2)))./ut^2;
%%


