%%% Function to calculate Julian day

function JD = JulianDay(D,M,Y,H,m,s)
    if(M == 1 | M==2)
        Y=Y-1;
        M=M+12;
    end
    X= (H/24) + (m/1440) + (s/86400);      %% calculating fractional day value
    D= D+X;                                %% Total number of days along with fraction based on time
    A= floor(Y/100); 
    B= 2- A + floor(A/4);
    JD= floor(365.25*(Y+4716))+ floor(30.6001*(M+1)) + D + B - 1524.5;
end    