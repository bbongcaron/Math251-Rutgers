%{
    Brenton Bongcaron
    Mavrea
    01:640:251:02
    10 February 2020
%}
function [pq, pr, v, thetaDP, thetaCP] = calc3Lab1(p,q,r) 
    %{
        p, q, and r are arrays containing x, y, and z coordinates, in that 
        order, and are the input variables
    %}
%% Computation of vectors pq & pr
    pq = q - p;
    pr = r - p; 
    % magnitudes of vectors pq & pr
    magPQ = sqrt(sum(pq.^2));
    magPR = sqrt(sum(pr.^2));
%% Angle between pq & pr: DOT PRODUCT (DP)
    dotP = dot(pq,pr);                          % the DP scalar
    thetaDP = acos(dotP/(magPQ*magPR));         % in radians
%% Angle between pq & pr: CROSS PRODUCT (CP)
    %{
        Computation of v = pq x pr
            v is perpendicular to both vectors pq and pr. v also represents
            a vector that is normal to the plane formed by pq and pr.
    %}
    v = cross(pq,pr);                       
    magCrossP = sqrt(sum(v.^2)) ;               % the CP vector magnitude
    thetaCP = asin(magCrossP/(magPQ*magPR));    % in radians
%% Figure 1: Plotting triangle T made up of points p, q, and r
    M = [p;q;r;p];
    figure(1)
    fill3(M(:,1), M(:,2), M(:,3), 'b')
%% Figure 2: Line segment coming from p in the direction of v
    % calculate unit vector in the direction of v
    magv = sqrt(sum(v.^2));
    unitv = v./magv;
    N = [p;p+unitv];
    figure(2)
    fill3(M(:,1), M(:,2), M(:,3), 'b')
    hold on;
    plot3(N(:,1), N(:,2), N(:,3), 'r')
%% Calculation & Display Equations of Plane PQR
    disp("Equations of Plane PQR: ");
    disp("     Vector Form: <" + v(1) + ", " + v(2) + ", " + v(3) + ">" + " * <x - " + p(1) + ", y - " + p(2) + ", z - " + p(3) + "> = 0");
    disp("     Point-Normal Form: " + v(1) + "(x - " + p(1) + ") + " + v(2) + "(y - " + p(2) + ") + " + v(3) + "(z - " + p(3) + ") = 0");
    k = v(1)*p(1) + v(2)*p(2) + v(3)*p(3);
    disp("     Standard Form: " + v(1) + "x + " + v(2) + "y + " + v(3) + "z = " + k);  
end

