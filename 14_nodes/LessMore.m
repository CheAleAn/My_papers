while T>0
nom=nom+1;
for i=1:T
K(i)=nom;
end
   for i1=1:(T-1) %нахождения лучших среди оставшихся
        for i2=(i1+1):T
            if score(i1,1)>score(i2,1) & score(i1,2)>=score(i2,2)
                K(i1)=0;
            end
            if score(i1,1)>=score(i2,1) & score(i1,2)>score(i2,2)
                K(i1)=0;
            end
            if score(i1,1)<score(i2,1) & score(i1,2)<=score(i2,2)
                K(i2)=0;
            end
            if score(i1,1)<=score(i2,1) & score(i1,2)<score(i2,2)
                K(i2)=0;
            end
            if score(i1,1)==score(i2,1) & score(i1,2)==score(i2,2)
                K(i2)=0;
            end
        end
   end
    L=0;
    clear scorescore
    for i=1:T
        if K(i)==nom%добавление лучших в ранг
            nn=nn+1;
            RangLM(nn,:)=[i,nom,score(i,1),score(i,2)];
        end
        if K(i)==0 %подготовка остальных к повторному циклу
        L=L+1;
        scorescore(L,1)=score(i,1);
        scorescore(L,2)=score(i,2);
        end
    end  
    T=L;
    clear score
    for i=1:T
        score(i,1)=scorescore(i,1);
        score(i,2)=scorescore(i,2);
    end
end 
clear score