

clc,clear all
format long e
xobs=0:100:2000;
yobs=0:100:1000;
%zobs=0:100:1000;
xmin=min(xobs);
xmax=max(xobs);
ymin=min(yobs);
ymax=max(yobs);
xx=-50:100:2050;
yy=-50:100:1050;
zz=0:100:1000;

%.zobs=zeros(length(xobs),1);..................................
zobs=zeros(length(xobs),1);
%  nx=input('number of blocks in x-axis direction=');
%  ny=input('number of blocks in y-axis direction=');
%  nz=input('number of blocks in z-axis direction=');
%  disp('PLEASE INTER LIMITATION OF DESIRE KERNEL OF NETWORK')
%  disp('            primary point (x0,y0,z0)                  ')
% x0=input('x0=');
% y0=input('y0=');
% z0=input('z0=');
 %disp('          tirsint (xn,yn,zn)   
%                 For example

% xn=input('xn=');
% yn=input('yn=');
% zn=input('zn=');

%                For example


% .........................................................................
%  start main program ......................................................

 %rhoo=2000;
% =xlsread('rrho.xlsx');
%  rhoo=reshape(rho,21,11,10);
 
 xc=800;
 yc=400;
 zc=300;
 nx=21;
ny=11;
nz=10;
% for i=1:nx+1
%     xx(i)=x0+(i-1)*(dx/(nx-1));
% end
% for j=1:ny+1
%     yy(j)=y0+(j-1)*(dy/(ny-1));
% end
% for f=1:nz+1
%     zz(f)=z0+(f-1)*(dz/(nz-1));
% end



 
for i=1:length(xobs);
    for j=1:length(yobs);
       
    h=0;
    for hz=1:nz
      for hy=1:ny
          
       for hx=1:nx
     gijk=m_2(xobs(i),yobs(j),xx(hx),yy(hy),zz(hz),xx(hx+1),yy(hy+1),zz(hz+1));
   h=h+1;
     a1(i,j,h)=gijk;
     
       
       
        end
      end
    end
    end
end


    a=reshape(a1,231,2310);
    rrho=xlsread('rft.xlsx');
 rhoo=reshape(rrho,21,11,10);
 g=a*rrho;
 g1=reshape(g,21,11);
   
[X,Y] = meshgrid(yobs,xobs);
contourf(Y,X,g1);


colorbar
title('Observed gravity anomaly map (mGAL)') 
xlabel('X(m)');ylabel('Y(m)');
 %GI=g1+awgn(g1,2000); 
   GI=g1+0.2*rand(size(g1));
figure(2)
contourf(Y,X,GI);
colorbar
title('calculated noisy gravity anomaly map (mGAL)') 
xlabel('X(m)');ylabel('Y(m)');
%rhoop=reshape(rrho,11,21,10);

          
        vg=reshape(rrho,nx,ny,nz);
        vgp=zeros(nx+1,ny+1,nz+1);
%        
%         for k=1:1:nz;
%            vg(:,:,k)=vg(:,:,k)'*(100/1000);
%         end
     
        for ki=1:1:nz;
           vgp(1:nx,1:ny,ki)=vg(:,:,ki);
        end
 
        

    disp('            primary point (x0,y0,z0)                  ')
% x0=input('x0=');
% y0=input('y0=');
% z0=input('z0=');
%  disp('           Last point (xn,yn,zn)                  ')
% xn=input('xn=');
% yn=input('yn=');
% zn=input('zn=');
              

x0=0;
y0=0;
z0=0;
xn=0.1;
yn=0.1;
zn=0.05;


dx=xn-x0;
dy=yn-y0;
dz=zn-z0;

dnx=dx/nx;
dny=dy/ny;
dnz=dz/nz;

xp=x0:dnx:xn;
yp=y0:dny:yn;
zp=z0:-dnz:-zn;
% According to the disired resolution 5 could be changed
dnx5=dnx/5;
dny5=dny/5;
dnz5=dnz/5;

 
    
[xpi,ypi,zpi]=meshgrid(x0:dnx5:xn,y0:dny5:yn,z0:-dnz5:-zn);
vgpi=interp3(yp,xp,zp,vgp,xpi,ypi,zpi);
figure
% According to the disired slices [],[],[] could be filled
slice(xpi,ypi,zpi,vgpi,[],[],[0 -0.01 -0.020 -0.03 -0.040 ]);shading interp
axis([x0 xn y0 yn -zn z0]);

title('Contrast Density','Fontsize',14);
title('%Density contrast','Fontsize',14);
xlabel('X(km)','FontSize',10);
ylabel('Y(km)','FontSize',10);
zlabel ('Z(km)','Fontsize',10);
colorbar;