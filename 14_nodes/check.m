clear scorerest
for i=1:P
    forregim=population(i,:);
    Fitnesslifekids();
    scorerest(i,1)=reghim(1);
    scorerest(i,2)=reghim(2);
end
%for alpha=1:GenomeLength
    %forregim(alpha)=Rangall(1,4+alpha);
%end
%Fitnesslifekids();
%scorerest(1,1)=reghim(1);
%scorerest(1,2)=reghim(2);
scorerest
for i=1:P
    if Rangall(i,2)==1
    forregim=population(i,:);
    Fitnesslifekids();
    scoreeerest(i,1)=reghim(1);
    scoreeerest(i,2)=reghim(2);
    end
end
scoreeerest