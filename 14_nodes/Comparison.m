kosobi=0;
kosobipred=0;
idealsize=0;
for i=1:P %размер 1 ранга
    if Rangfinal(i)==1
        kosobi=kosobi+1;
    end
    if Rang2(i,1)==1
        kosobipred=kosobipred+1;
    end
end
for i2=1:P %сравнение 1-ых рангов
    for i1=1:P
       if scoreparents(i1,1)==Rang2(i2,2) & scoreparents(i1,2)==Rang2(i2,3) & Rangfinal(i1)==1 & Rang2(i2,1)==1
           idealsize=idealsize+1;
       end
    end
end
if kosobipred==kosobi & idealsize==kosobi
    repeatnow=repeatnow+1;
else
    repeatnow=0;
end