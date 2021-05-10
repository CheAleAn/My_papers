for i2=1:P
    for i1=1:P
        if RangLM(i1,3)==scoreparents(i2,1) & RangLM(i1,4)==scoreparents(i2,2)
            Rangfinal(i2)=RangLM(i1,2);
            Rangall(i2,1)=i1;
            Rangall(i2,2)=RangLM(i1,2);
        end
    end
end