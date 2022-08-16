%rectangiular prism.Blakely
%function: g=G*rho*sum*MUijk*(C*atanA*B/C*Rijk-Alog(Rijk+B)-Blog(Rijk+A))
%input (xp,yp),(xq,yq,zq),rho
%Rijk=sqrt(A^2+B^2+C^2)
%MUijk=((-1)^i*(-1)^i*(-1)^k)

function[g]=m_2(xobs,yobs,x1,y1,z1,x2,y2,z2)




P=[x1 x2];
L=[y1 y2];
T=[z1 z2];




gama=6.674e-11;



g=zeros(length(yobs),length(xobs));
for n=1:length(xobs);
    for m=1:length(yobs);


                        
                            sum=0;
                             for p=1:2
                                 for q=1:2
                                        for s=1:2
                                            
                          A=xobs(n)-P(p);
                          B=yobs(m)-L(q);
                          C=0.05-T(s);
                                           
                          Rpqs=sqrt(A^2+B^2+C^2);
                                                    
                          MUpqs=((-1)^p)*((-1)^q)*((-1)^s);
                          term1=B+Rpqs;term1=log(term1);
                          term2=A+Rpqs;term2=log(term2);
                          term3=atan((A*B)/(C*Rpqs));    
                          sum=sum+MUpqs*((A*term1)+ (B*term2)-(C*term3));
                          
                         
                                        end 
                                  end
                             end                         
                               
                g(m,n)=-gama*sum*1e5;
               
   end
end
   

   %gtot=[];
%    for i=1:441
%        gtot(i)=g(i);
%    end