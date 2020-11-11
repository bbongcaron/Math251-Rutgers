%{
    Brenton Bongcaron
    Mavrea
    01:160:251:02
    20 February 2020
%}
%% Storing Tfinal
tFinal = 5;
t = 0:0.05:tFinal;

%% Storing r(t)
rOft = [ 4.*t.*sin(t) ; 4.*t.*cos(t); 3.*t + (4.*t.^3)./3 ];

%% Plotting r(t): 1st Angle
figure('Name', 'r(t): Angle 1')
plot3(rOft(1,:),rOft(2,:),rOft(3,:))
view([15,16])

%% Plotting r(t): 2nd Angle
plot3(rOft(1,:),rOft(2,:),rOft(3,:))
figure('Name', 'r(t): Angle 2')
view([-37,30])
plot3(rOft(1,:),rOft(2,:),rOft(3,:))
hold on

%% Animating r(t): 2nd Angle
%{
[~, numPointsrOft] = size(rOft);
for i = 1:numPointsrOft
    plot3(rOft(1,i),rOft(2,i),rOft(3,i), 'd', 'Color', 'r')
    pause(0.1)
end
hold off
%}
%% Calculate the length of the curve r(t) from t = 0 to t = tFinal
syms t
x = 4*t*sin(t);
y = 4*t*cos(t);
z = 3*t + (4*t^3)/3;

dx = diff(x);
dy = diff(y);
dz = diff(z);

radicand = simplify(dx^2 + dy^2 + dz^2);

length = int(sqrt(radicand), t, 0, tFinal);
fprintf('Length of r(t) from t = 0 to t = tFinal = %s \n \n', length)
%{ 
    If two values t = a and t = b were given, the length of the curve r(t)
    between these points would be:
    int(sqrt(radicand), t, a, b)

    To find a unit tangent vector to the curve r(t), find the derivative 
    of r(t), r'(t), and divide r'(t) by  ||r'(t)|| (the magnitude of r'(t))
%} 

%% Findining the Arc Length Parametrization for r(t)
syms s
fprintf('g(t) = %s \n \n', (int(sqrt(radicand))))
gInverse = subs(finverse(int(sqrt(radicand))),t,s);
fprintf('g^-1(s) = %s \n \n', gInverse)
%{
    Since ||r'(t)|| = 1 for all t of an arc length parametrization, to
    replicate the original r(t), r(s) must be plotted from s = 0 to 
    s = length
%}

%% Plotting r(s)
newInputs = double(subs(gInverse, s, 0:0.05:length));
rOfs = [ 4.*newInputs.*sin(newInputs) ; 4.*newInputs.*cos(newInputs) ; 3.*newInputs + (4.*newInputs.^3)./3 ];

figure('Name', 'r(s)')
view([-37,30])
hold on
plot3(rOfs(1,:),rOfs(2,:),rOfs(3,:),'--')

%% Animating r(s)
%{
[~, numPointsrOfs] = size(rOfs);
for i = 1:numPointsrOfs
    plot3(rOfs(1,i),rOfs(2,i),rOfs(3,i), 'd', 'Color', 'g')
    pause(0.1)
end
hold off
%}
%% Length of r(s)
xALP = 4*gInverse*sin(gInverse);
yALP = 4*gInverse*cos(gInverse);
zALP = 3*gInverse + (4*gInverse^3)/3;
dxALP = diff(xALP);
dyALP = diff(yALP);
dzALP = diff(zALP);
radicandALP = dxALP^2 + dyALP^2 + dzALP^2;
syms s

lengthALP = double(int(sqrt(radicandALP), s, 0, length));

fprintf('Length of r(s) from s = 0 to s = length = %s \n \n', rat(lengthALP))

if (lengthALP == length)
    fprintf('Length of r(t) and length of r(s) are equal! \n')
    fprintf('They are both equal to: %s \n', length)
else
    fprintf('Lengths are not equal.')
end
%{
    If two values s = a and s = b were given, the length of the curve r(s)
    between these points would be:
    int(sqrt(radicand), s, a, b)

    To find a unit tangent vector to the curve r(s), find the derivative 
    of r(s), r'(s), and divide r'(s) by  ||r'(s)|| (the magnitude of r'(s))

    The animations for r(t) and r(s) follow the same exact path. The
    animation for r(s) is much slower than the animation for r(t).
%}



