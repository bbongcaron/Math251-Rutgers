%{
    Brenton Bongcaron
    Mavrea
    Section 02
    31 March 2020
%}
wValues = []; xValues = []; yValues = []; zValues = []; fValues = [];
syms w x y z
%% Store the functions f and g
f = 3.0*w - 3.0*w*x + 3.0*w*z - 3.0*x*y;
g = 0.2928*w*x + 0.4326*w*y + 0.2673*w*z + 0.8127*x*y + 0.5022*x*z + 0.7421*y*z + 0.265*w^2 + 0.3802*x^2 + 0.6005*y^2 + 0.2541*z^2;

%% Finding and displaying all possible "interior" CP(s) where the gradient of f = 0
gradF = sym2cell(gradient(f, [w,x,y,z]));
interiorCritPts = solve(gradF{1} == 0, gradF{2} == 0, gradF{3} == 0, gradF{4} == 0);
fprintf("Interior Critical Points:\n(" + double(interiorCritPts.w) + "," + double(interiorCritPts.x) + "," + double(interiorCritPts.y) + "," + double(interiorCritPts.z) + ")\n\n")
wValues(1) = round(double(interiorCritPts.w),4);
xValues(1) = round(double(interiorCritPts.x),4);
yValues(1) = round(double(interiorCritPts.y),4);
zValues(1) = round(double(interiorCritPts.z),4);

%% Determine if the interior CP(s) lie within the constrained region
solG = double(subs(g, [w,x,y,z], [interiorCritPts.w,interiorCritPts.x,interiorCritPts.y,interiorCritPts.z]));
fprintf("g" + "(" + double(interiorCritPts.w) + "," + double(interiorCritPts.x) + "," + double(interiorCritPts.y) + "," + double(interiorCritPts.z) + ") = " + solG)
if (solG <= 1)
    fprintf(" <= 1\n")
    fprintf("Therefore, (" + double(interiorCritPts.w) + "," + double(interiorCritPts.x) + "," + double(interiorCritPts.y) + "," + double(interiorCritPts.z) + ")" + " is within the desired domain.\n\n")
else
    fprintf(double(interiorCritPts.w) + "," + double(interiorCritPts.x) + "," + double(interiorCritPts.y) + "," + double(interiorCritPts.z) + ")" + " is NOT within the desired domain.\n\n")
end

%% Use Lagrange multipliers to determine the CP(s) along the boundary g(w,x,y,z) = 1
syms L
gradG = sym2cell(gradient(g, [w,x,y,z]));
boundaryCritPts = solve(gradF{1} == gradG{1}*L , gradF{2} == gradG{2}*L, gradF{3} == gradG{3}*L, gradF{4} == gradG{4}*L, g == 1);

%% Display boundary CP(s)
boundaryCritPts.L = sym2cell(boundaryCritPts.L);
boundaryCritPts.w = sym2cell(boundaryCritPts.w);
boundaryCritPts.x = sym2cell(boundaryCritPts.x);
boundaryCritPts.y = sym2cell(boundaryCritPts.y);
boundaryCritPts.z = sym2cell(boundaryCritPts.z);
[length, ~] = size(boundaryCritPts.L);
fprintf("Boundary Critical Points:\n")
for i = 1:length
    wValues(i+1) = round(double(boundaryCritPts.w{i}),4);
    xValues(i+1) = round(double(boundaryCritPts.x{i}),4);
    yValues(i+1) = round(double(boundaryCritPts.y{i}),4);
    zValues(i+1) = round(double(boundaryCritPts.z{i}),4);
    fprintf("(" + double(boundaryCritPts.w{i}) + "," + double(boundaryCritPts.x{i}) + "," + double(boundaryCritPts.y{i}) + "," + double(boundaryCritPts.z{i}) + ")\n")
end
fprintf("\n")

%% Find f(w,x,y,z) at each of the CP(s) (interior and boundary)
[~,n] = size(wValues);
for i = 1:n
    fValues(i) = double(subs(f, [w,x,y,z], [wValues(i),xValues(i),yValues(i),zValues(i)]));
end

%% Display CP(s) and f(w,x,y,z) @ CP(s) in a table
T = table(wValues',xValues',yValues',zValues',fValues','VariableNames',{'w','x','y','z','f(w,x,y,z)'});
disp(T(1:9,:))

%% Determine the maximum and minimum values of f(w,x,y,z) with respect to g(w,x,y,z) <= 1
minimum = min(fValues);
indexOfmin = find(fValues == minimum);
maximum = max(fValues);
indexOfmax = find(fValues == maximum);

%% Display the maximum and minimum values AND the CPs they occur at
fprintf("The maximum value of f(w,x,y,z) with respect to g(w,x,y,z) <= 1 is " + maximum + "\n")
fprintf("This value of f(w,x,y,z) occurs at the point (" + wValues(indexOfmax) + "," + xValues(indexOfmax) + "," + yValues(indexOfmax) + "," + zValues(indexOfmax) + ")\n\n")
fprintf("The minimum value of f(w,x,y,z) with respect to g(w,x,y,z) <= 1 is " + minimum + "\n")
fprintf("This value of f(w,x,y,z) occurs at the point (" + wValues(indexOfmin) + "," + xValues(indexOfmin) + "," + yValues(indexOfmin) + "," + zValues(indexOfmin) + ")\n\n")
