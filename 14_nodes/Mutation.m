%повторная особь с мутацией
for i=1:sumofkids
    A=rand;
    if Rangkid(i)*repeatnow/(nom)*10>=A
        alpha = ceil(rand*GenomeLength);
        diff = ub(alpha)-lb(alpha);  
        step = vars_scheme{alpha,6};
        if step > 0
           xoverKids(i,alpha) = lb(alpha)+ceil(rand*diff/step)*step; 
        else
           xoverKids(i,alpha) = rand*diff + lb(alpha);
        end
    end
    clear A
end
for i1=1:P/2
    for i2=1:GenomeLength
        population(P+i1,i2)=xoverKids(i1,i2);
    end
end
%for i1=1:P/2
    %for i2=1:3*P/2
       % for i3=1:GenomeLength
          %  if xoverKids(i1,i3)==population(i2,i3) & i1~=i2-P
          %     alpha = ceil(rand*GenomeLength);
          %     if step > 0
          %        xoverKids(i1,alpha) = lb(alpha)+ceil(rand*diff/step)*step; 
         %      else
        %          xoverKids(i1,alpha) = rand*diff + lb(alpha);
        %       end
       %     end
     %   end
 %   end
%end