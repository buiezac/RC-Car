

% Spring Rate Testing

% Spring rate theoretical formula: k = ((G)*(d)^4)/(8*(D)^2*N)
% Theoretical
G = (7.93)*(10^10);  % Shear modulus of music wire (Pa)
D = (1.76)*(10^-2);     % mean diameter for all springs (m)
dBR = (1.4)*(10^-3);  % wire diameter for brown springs (m)
dBL = (1.6)*(10^-3);  % wire diameter for black springs (m)
NS = 7;   % active coils for shorter springs (unitless)
NL = 9;   % active coils for longer springs (unitless)


kBRS = (((G)*(dBR)^4)/(8*((D)^3)*NS))/1000;   % theor spr rate for short brown (N/mm)
kBLS = (((G)*(dBL)^4)/(8*((D)^3)*NS))/1000;   % theor spr rate for short black
kBRL = (((G)*(dBR)^4)/(8*((D)^3)*NL))/1000;   % theor spr rate for long brown
kBLL = (((G)*(dBL)^4)/(8*((D)^3)*NL))/1000;   % theor spr rate for long black

xL = linspace(0,30,500);    % operating range for long springs
xS = linspace(0,21,500);    % operating range fo short springs

figure(1)
yBRS = ((kBRS).*(xS));   % theor force values for brown short (N)
plot(xS,yBRS,'r');    % red line    
xlabel('Spring Compression (mm)');
ylabel('Force (N)');
title('Theoretical Test Spring Rates (N/mm)')
legend()
grid on
hold on

yBLS = ((kBLS).*(xS));   % theor force values for black short (N)
plot(xS,yBLS,'b');   % blue line
hold on

yBRL = ((kBRL).*(xL));   % theor force values for brown long (N)
plot(xL,yBRL, 'g--');    % green line
hold on

yBLL = ((kBLL).*(xL));   % theor force values for black long (N)
plot(xL,yBLL, 'm--');   % magenta line
legend('Brown Short','Black Short','Brown Long','Black Long','Location','best');
hold on



% Experimental

x1 = [0,1,10,20,30];   % measured delta x for black long (mm)
y1 = ([0,512,1880,2818,3600]).*(9.81/1000);    % meausured force (N)
p1 = polyfit(x1,y1,1);
y_fit = polyval(p1,xL);
BlackLongSpringRateEXP = p1(1);   % experimental spring rate
ErrorBLL = abs((BlackLongSpringRateEXP-kBLL)/kBLL)*100;


x2 = [0,1,10,20,30];   % measured delta x for brown long (mm)
y2 = ([0,208,1210,1945,2640]).*(9.81/1000);  % measured force (N)
p2 = polyfit(x2,y2,1);
y_fit2 = polyval(p2,xL);
BrownLongSpringRateEXP = p2(1);
ErrorBRL = abs((BrownLongSpringRateEXP-kBRL)/kBRL)*100;
   
% theor spring rates in lb/in
kbrs = kBRS/(0.175126835)
kbrl = kBRL/(0.175126835)
kbls = kBLS/(0.175126835)
kbll = kBLL/(0.175126835)

xs = (xS)./25.4;   % x values converted to inches
xl = (xL)./25.4;


figure(2)   % plotting spring rates in lb/in
ybrs = (kbrs).*(xs); 
plot(xs,ybrs);
title('Theoretical Spring Rates (lb/in)')
xlabel('Spring Compression (in)');
ylabel('Force (lb)')
hold on 

ybls = (kbls).*(xs);
plot(xs,ybls);
hold on

ybrl = (kbrl).*(xl);
plot(xl,ybrl);
hold on 

ybll = (kbll).*(xl);
plot(xl,ybll);
legend('Brown Short','Black Short','Brown Long','Black Long','Location','best');
grid on
hold on


