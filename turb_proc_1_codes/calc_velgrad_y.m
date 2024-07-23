Nx=2048;
Ny=512;
Nz=1536;
Lx=  8*pi;
Lz = 3*pi;
%kx = [0:Nx-1]*pi/Lx;
kx = 2*(pi/Lx)*[0:Nx/2-1, 0, -Nx/2+1:-1];
%kxint=floor(kx(end));
xp = [0:Nx-1]*Lx/(Nx);
kz = 2*(pi/Lz)*[0:Nz/2-1, 0, -Nz/2+1:-1];
zp=  [0:1:Nz-1]*Lz/(Nz);
load('bsplinedata.mat')
C0= colmat0 ;
C1= colmat1 ;
C2= colmat2 ;
tstart=36;
tend=38;
yp = yv;
nproc=6;
nzproc=Nz/nproc;
nt=3;
kstart=zeros(nproc,1);
for proc=1:nproc
   kstart(proc)=(proc-1)*nzproc;
end

dudy=single(zeros(Ny,Nx,Nz));
dvdy=single(zeros(Ny,Nx,Nz));
dwdy=single(zeros(Ny,Nx,Nz));
d2udy2=single(zeros(Ny,Nx,Nz));




%dudy=single(zeros(Ny,Nx,Nz));
%dvdy=single(zeros(Ny,Nx,Nz));
%dwdy=single(zeros(Ny,Nx,Nz));
%
%dudz=single(zeros(Ny,Nx,Nz));
%dvdz=single(zeros(Ny,Nx,Nz));
%dwdz=single(zeros(Ny,Nx,Nz));

for time=tstart:tend
	fvel=sprintf("vel_%03d.mat",time)
	mv=matfile(fvel);

	for k =1:Nz
	k	
		ufieldslice=mv.u(:,:,k);
		vfieldslice=mv.v(:,:,k);
		wfieldslice=mv.w(:,:,k);


		coeffu=C0\ufieldslice(:,:);
		coeffv=C0\vfieldslice(:,:);
		coeffw=C0\wfieldslice(:,:);
		dudy(:,:,k)=C1*coeffu;
		dvdy(:,:,k)=C1*coeffv;
		dwdy(:,:,k)=C1*coeffw;
		d2udy2(:,:,k)=C2*coeffu;

	end
	fvelg=sprintf("velgrady_%03d.mat",time)
	mvg=matfile(fvelg,'Writable',true);
	mvg.dudy=single(dudy);
	mvg.dvdy=single(dvdy);
	mvg.dwdy=single(dwdy);
	mvg.d2udy2=single(d2udy2);
	
end
