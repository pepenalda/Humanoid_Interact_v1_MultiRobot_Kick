function Counts=Angle2Count(Angles)

Values=abs(Angles);
Counts=512+floor((1023*Angles)./300);
