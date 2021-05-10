global vars_scheme;
    
ret_pop = zeros(P,GenomeLength);
    
    for i=1:GenomeLength
       diff = ub(i)-lb(i);  
       step = vars_scheme{i,6};
       
       if step > 0
           ret_pop(:,i) = round((rand(P,1)*diff + lb(i))/step)*step; 
       else
           ret_pop(:,i) = rand(P,1)*diff + lb(i);
       end
    end

population = ret_pop;

