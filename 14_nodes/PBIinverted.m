n(1,1)=max(scoreparents(:,1));
n(1,2)=max(scoreparents(:,2));
lyam(1,3)=(lyam(1,1)^2+lyam(1,2)^2)^0.5;
for i=1:T
    d(1,i)=(((-score(i,1)+n(1,1))*lyam(1,1))^2+((-score(i,2)+n(1,2))*lyam(1,2))^2)^(0.5)/lyam(1,3);
    d(2,i)=((-score(i,1)+n(1,1)-d(1,i)*lyam(1,1))^2+(-score(i,2)+n(1,2)-d(1,i)*lyam(1,2))^2)^0.5;
    score(i,3)=d(1,i)-thetta*d(2,i);    
end
while T>0
nom=nom+1;
for i=1:T
K(i)=nom;
end
   for i1=1:(T-1) %нахождения лучших среди оставшихся
        for i2=(i1+1):T
            if score(i1,3)>score(i2,3) 
                K(i2)=0;
            end
            if score(i1,3)<score(i2,3)
                K(i1)=0;
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
        scorescore(L,3)=score(i,3);
        end
    end  
    T=L;
    clear score
    for i=1:T
        score(i,1)=scorescore(i,1);
        score(i,2)=scorescore(i,2);
        score(i,3)=scorescore(i,3);
    end
end 
clear score