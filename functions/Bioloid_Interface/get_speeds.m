function Speeds=get_speeds(Current, Desired, Time)

Speeds=abs((Desired-Current)./Time);
for i=1:length(Speeds)
    if Speeds(i)>684
        Speeds(i)=684;
    end
end
