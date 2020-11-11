%{
    Brenton Bongcaron
    Mavrea
    Section 02
    10 March 2020
%}
warning('off','all')
%% Plot f(x,y) = 0
figure('Name', 'f(x,y) = 0 with tangent lines @ x = A = -0.8')
fimplicit(@(x,y) x - 2*y - x*y - 6*x^2 + 2*y^2 - 1);

%% Solve for y-values satisfying f(A,y) = 0
A = -0.8;
syms x y
yValues = double(subs(solve(x - 2*y - x*y - 6*x^2 + 2*y^2 - 1 == 0,y), x, A));
fprintf('The points that satisfy f(A,y) = 0 are: \n')
fprintf('(%.1f, ', A)
fprintf('%.4f)\n', yValues(1))
fprintf('(%.1f, ', A)
fprintf('%.4f)\n\n', yValues(2))

%% Calculate slopes of the tangent lines of f(x,y) = 0 at the points (A, yValues)
dydx = diff(solve(x - 2*y - x*y - 6*x^2 + 2*y^2 - 1 == 0,y),x);
slopes = double(subs(dydx, x, A));
hold on;

%% Plot and Label the points (A, yValues)
scatter(A, yValues(1), 'filled', 'r');
text(A + 0.1, yValues(1) + 0.1, '(-0.8, -1.4059)');
scatter(A, yValues(2), 'filled', 'y');
text(A, yValues(2) + 0.5, '(-0.8, 2.0059)');

%% Plot the tangent lines of f(x,y) = 0 at the points (A, yValues)
fprintf('The equation of the tangent line of f(x,y) = 0 @(A, -1.4059) is: \n')
fprintf('y - (%.4f)', yValues(1))
fprintf(' = %.4f', slopes(1))
fprintf('(x - (%.1f))\n\n', A)
fimplicit(@(x,y) y-yValues(1) - slopes(1)*(x-A), 'r');
fprintf('The equation of the tangent line of f(x,y) = 0 @(A, 2.0059) is: \n')
fprintf('y - (%.4f)', yValues(2))
fprintf(' = %.4f', slopes(2))
fprintf('(x - (%.1f))\n\n', A)
fimplicit(@(x,y) y-yValues(2) - slopes(2)*(x-A), 'y');
hold off;

%% Find y = h(x), the curve of f(x,y) near the point with the larger y-coordinate
bothfCurves = sym2cell(solve(x - 2*y - x*y - 6*x^2 + 2*y^2 - 1 == 0,y));
fprintf('The equation of the curve of f(x,y) near the point with the\n')
fprintf('larger y-coordinate is:\n')
fprintf('h(x) = %s\n\n',bothfCurves{2})
h = double(subs(bothfCurves{2}, x, -2*pi:pi/16:2*pi));
dhdx = diff(bothfCurves{2},x);
slope = double(subs(dhdx,x,-0.8));
fprintf('The equation of the tangent line of y = h(x) @A is: \n')
fprintf('y - (%.4f)', yValues(2))
fprintf(' = %.4f', slope)
fprintf('(x - (%.1f))\n', A)
fprintf('NOTE: THIS IS THE EXACT SAME FORMULA AS\n')
fprintf('THE TANGENT LINE OF f(x,y) = 0 @(A, 2.0059)\n\n')
%{
    The equation of the tangent line of h(x) @ A is IDENTICAL
    to the equation of the tangent line of f(x,y) = 0 @(A, 2.0059).
%}

%% Plot y = h(x) and the tangent line of h(x) @ A
figure('Name', 'y = h(x) and the tangent line of h(x) @ A')
hold on
scatter(A, yValues(2), 'filled', 'y');
fimplicit(@(x,y) y-yValues(2) - slope*(x-A), 'y');
text(A, yValues(2) + 0.5, '(-0.8, 2.0059)');
plot(-2*pi:pi/16:2*pi, h(:), '-.')
hold off

%% Plot g(x,y,z) = 0
figure('Name', 'g(x,y,z) = 0 with tangent plane @(x,y,z) = (B, C, -1.0973)')
fimplicit3(@(x,y,z) 3*x - 2*y - 6*z - 4*x*y + 6*x*z - 2*x^2 - 5*y^2 - 5*z^2 + 2, 'EdgeColor', 'cyan');

%% Solve for z-values satisfying g(B,C,z) = 0
syms z
B = 0.4; C = -0.9;
zValues = double(subs(solve(3*x - 2*y - 6*z - 4*x*y + 6*x*z - 2*x^2 - 5*y^2 - 5*z^2 + 2 == 0, z), [x, y], [B, C]));
fprintf('The points that satisfy g(B,C,z) = 0 are: \n')
fprintf('(%.1f, ', B)
fprintf('%.1f, ', C)
fprintf('%.4f)\n', zValues(1))
fprintf('(%.1f, ', B)
fprintf('%.1f, ', C)
fprintf('%.4f)\n\n', zValues(2))

%% Create the function F(x,y,z) = 0 and find the gradient vector, g
F = 3*x - 2*y - 6*z - 4*x*y + 6*x*z - 2*x^2 - 5*y^2 - 5*z^2 + 2;
g = sym2cell(gradient(F, [x, y, z]));
hold on;
Fx(1) = double(subs(g{1}, [x, y, z], [B, C, zValues(1)]));
Fx(2) = double(subs(g{1}, [x, y, z], [B, C, zValues(2)]));
Fy(1) = double(subs(g{2}, [x, y, z], [B, C, zValues(1)]));
Fy(2) = double(subs(g{2}, [x, y, z], [B, C, zValues(2)]));
Fz(1) = double(subs(g{3}, [x, y, z], [B, C, zValues(1)]));
Fz(2) = double(subs(g{3}, [x, y, z], [B, C, zValues(2)]));

%% Plot the tangent plane of g(x,y,z) = 0 at (B, C, -1.0973)
scatter3(B,C,zValues(1), 'filled', 'r');
text(B - 2, C - 0.1, zValues(1) - 0.1, '(0.4, -0.9, -1.0973)');
fimplicit3(@(x,y,z) Fx(1)*(x-B) + Fy(1)*(y-C) + Fz(1)*(z-zValues(1)), 'EdgeColor', 'none', 'FaceAlpha', .5);
fprintf('The equation of the tangent plane of g(x,y,z) = 0 @(B,C, -1.0973) is: \n')
fprintf('%.4f', Fx(1))
fprintf('(x - %.1f)', B)
fprintf(' + %.4f', Fy(1))
fprintf('(y - (%.1f))', C)
fprintf(' + %.4f', Fz(1))
fprintf('(y - (%.1f))\n\n', zValues(1))
view([-112,-15])
grid off;
hold off;

%% Plot the tangent plane of g(x,y,z) = 0 at (B, C, 0.3773)
figure('Name', 'g(x,y,z) = 0 with tangent plane @(x,y,z) = (B, C, 0.3773)')
hold on;
scatter3(B,C,zValues(2), 'filled', 'b');
text(B + 0.1, C + 0.1, zValues(2) + 0.5, '(0.4, -0.9, 0.3773)');
fimplicit3(@(x,y,z) 3*x - 2*y - 6*z - 4*x*y + 6*x*z - 2*x^2 - 5*y^2 - 5*z^2 + 2, 'EdgeColor', 'cyan');
fimplicit3(@(x,y,z) Fx(2)*(x-B) + Fy(2)*(y-C) + Fz(2)*(z-zValues(2)), 'EdgeColor', 'none', 'FaceAlpha', .5);
fprintf('The equation of the tangent plane of g(x,y,z) = 0 @(B,C, 0.3773) is: \n')
fprintf('%.4f', Fx(2))
fprintf('(x - %.1f)', B)
fprintf(' + %.4f', Fy(2))
fprintf('(y - (%.1f))', C)
fprintf(' + (%.4f)', Fz(2))
fprintf('(y - %.1f)\n', zValues(2))
view([-112,-15])
grid off;