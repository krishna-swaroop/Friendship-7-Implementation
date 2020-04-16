%%% The following is my implementation of finding the location of Friendship-7 satellite as part of an assignment for EEE F472 Satellite
%%% Communication course at BITS Pilani.
%%% D. Krishna Swaroop 2017A3PS0315P


%%% Orbital Elements as mentioned in the problem statement
a = 6589116;                      %%% Semimajor axis value in metres
M0d= 228.5;                       %%% Mean Anomaly at T0 in degrees
M0= M0d*(pi/180);                 %%% Mean Anomaly at T0 in radians
T0= 2437716.11642;                %%% Time T0 in JD
e = 0.007589;                     %%% eccentricity
wd = 181.2;                       %%% Argument of perigee in degrees
w = wd*(pi/180);                  %%% Argument of perigee in radians
omegad= 235.2;                    %%% longitude of ascending node in degrees
omega= omegad*(pi/180);           %%% longitude of ascending node in radians
id= 32.54;                        %%% inclination of orbit in degrees;
i= id*(pi/180);                   %%% Inclination angle in radians

%%% Observation Times. Can give arbitrary dates. Should write code for taking user input for this
D= 20;                           
M= 2;
Y= 1962;
H= 0;                           %%% Hours
m= 0;                            %%% Minutes
s= 0;                            %%% Seconds

%%% Constants and other conversions
GMe= 3.986004415*(10.^14);  %%% G-Gravitational Constant; Me is mas of earth
NM= 1852;                   %%% NM is nautical mile

n = 86400/(2*pi)*((GMe/a.^3).^(0.5));        %%% Mean daily motion, n of the orbit


t0 = 1/n;                                 %%% Orbital period,t0
%t = JulianDay(D,M,Y,H,m,s);%%% Julian Day calc function. Refer to
%JulianDay.m
%%% Change the above comment to generalise the time. This was part of an assignment to show position at arbitrary times.
%%% Make sure you pull the JulianDay.m function for this to work
t = 2437728.500001;                        %%% This is in the main code because I was unsure of time to be entered into the function.
T = (t-2451545.0)/36525;
GST = 280.46061837 + 360.98564736629*(t-2451545.0) + 0.000387933*(T.^2) - (T.^3)/38710000;

%%% Calc of Anomalies and Radial Distance
M= M0 + 2*pi*n*(t-T0);                    %%% M=Mean Anomaly
E = keplerEq (M, e);                      %%% Finding Eccentric and true anomalies. Galat hai
r=a*(1-e*cos(E));                         %%% radial distance
f = 2*atan(((1+e)/(1-e)).^(0.5)*tan(E/2));%%%True Anomaly in Radians

%%% Moving to different coordinate system

u = w + f;

x = r*(cos(u)*cos(omega) - sin(u)*sin(omega)*cos(i));
y = r*(cos(u)*sin(omega) + sin(u)*cos(omega)*cos(i));
z = r*sin(u)*sin(i);

%%% Conversion to spherical coordinates
alpha = atan(y/x);
alpha = alpha*180/pi;
delta = asin(z/r);
delta = delta*180/pi;

GST = rem(GST,360)+360;

L = alpha - GST;   %%% Longitude
L= L+180;          %%% To ensure L is between -180 and +180
phi = delta;       %%% Latitude
%%% Negative Longitude refers to Western Hemisphere
%%% Negative Latitude refers to Southern Hemisphere



