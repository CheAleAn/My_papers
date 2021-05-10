%функция жизнеспособности Задачи 1
func_time = tic; %начинаем отсчет времени

%ставим нужные величины 
if(~isempty(parents))
    k = 1;
    for u=1:length(vars_scheme(:,1));
        if vars_scheme{u,1}==1
            RTable_Branch.Cols.Item(vars_scheme{u,2}).set('Z',vars_scheme{u,3}-1,parents(u));
        else
            RTable_Node.Cols.Item(vars_scheme{u,2}).set('Z',vars_scheme{u,3}-1,parents(u));
        end
    end
end
    
    for ll=1:25
        res = Rastr.rgm('');
    end

    sum_dV = 0;
    max_dV = 0;
    sum_P = 0;
    max_P = 0;
    sum_I = 0;
    max_I = 0;
    sum_Delta = 0;
    max_Delta = 0;
    
    %считаем суммы по нужным столбцам
    for i1=0:size_branch-1;
        cP = abs(RTable_Branch.Cols.Item('dp').get('Z',i1));
        cI = abs(RTable_Branch.Cols.Item('ib').get('Z',i1)+RTable_Branch.Cols.Item('ie').get('Z',i1))/2;
        sum_P = sum_P + cP;
        sum_I = sum_I + cI;
        max_P = max(max_P,cP);
        max_I = max(max_I,cI);
    end
    
    %sumv = 0;
    for i2=0:size_node-1;
        cV = abs(RTable_Node.Cols.Item('otv').get('Z',i2));
        cDelta = abs(RTable_Node.Cols.Item('delta').get('Z',i2));
        
        %блок подсчета числа присоединенных линий для экономики
        %ny = RTable_Node.Cols.Item('ny').get('Z',i2);
        
        %if cV > 4.49
            %for i3=0:size_branch-1;
                %ip = RTable_Branch.Cols.Item('ip').get('Z',i3);
                %iq = RTable_Branch.Cols.Item('iq').get('Z',i3);
                %if ip == ny || iq == ny
                   %sumv = sumv+1; 
                %end
            %end
        %end
        
        max_dV = max(cV,max_dV);
        max_Delta = max(cDelta,max_Delta);
        
        sum_dV = sum_dV + cV;
        sum_Delta = sum_Delta + cDelta;
    end
    
%sumv

pre_res = [max_dV, sum_dV, max_P, sum_P, max_I, sum_I, max_Delta, sum_Delta];    

global no_stat;
reghim = [pre_res(1) pre_res(4)];
    %y = pre_res(1);

    %записываем в переменную время выполнения функции
func_stat = [func_stat;toc(func_time)];



