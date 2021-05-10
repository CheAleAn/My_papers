kid=1; 
index=1;
while kid<=sumofkids
A=index;  
index=index+1;
B=index;  
index=index+1;
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    