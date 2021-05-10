kid=1;    
while kid<=sumofkids
A=ceil(rand*P);   
B=ceil(rand*P);
C=rand;
D=rand;
if (1-Rangfinal(A)/max(Rangfinal))>C & (1-Rangfinal(B)/max(Rangfinal))>D
    alpha = round(rand*GenomeLength);
    for ii=1:alpha
        xoverKids(kid,ii) = population(A,ii);
    end
    for ii=alpha+1:GenomeLength
        xoverKids(kid,ii) = population(B,ii);
    end
    Rangkid(kid)=(Rangfinal(A)+Rangfinal(B))/2;
    kid=kid+1;
end
clear A
clear B
clear C
clear D   
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    