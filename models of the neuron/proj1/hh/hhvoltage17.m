function ydot = hhvoltage17(t, y)
%y(1,2,3,4) = v, gk, gna, gl
[params, iext] = gethhparams();
phi = params(8).^((params(7)-6.3)./10);
ydot = zeros(4,1);

if t<=iext(3) && t>= iext(2)
    ydot(1) = (iext(1)- params(1).*y(2).^4.*(y(1)-params(4))  ...
        -params(2).*y(3).^3.*y(4).*(y(1)-params(5)) ...
        -params(3)*(y(1)-params(6)))/params(9) ;
else
    ydot(1) = (-params(1).*y(2).^4.*(y(1)-params(4))  ...
        -params(2).*y(3).^3.*y(4).*(y(1)-params(5)) ...
        -params(3)*(y(1)-params(6)))/params(9) ;
end
ydot(2) = 0; %ngate
ydot(3) = alpham(y(1)).*(1-y(3)) - betam(y(1)).*y(3); %mgate
ydot(4) = 0; %hgate

    function val = alphan(v)
        if abs(v+50)>=1.e-4
            val = -phi.*0.01.*(v+50)./(exp(-(v+50)./10)-1);
        else
            val = phi.*0.1./(1-(v+50)./20);
        end
    end

    function val = alpham(v)
        if abs(v+50)>=1.e-4
            val = -phi.*0.1.*(v+35)./(exp(-(v+35)./10)-1);
        else
            val = phi.*1./(1-(v+35)./20);
        end
    end

    function val = alphah(v)
        val = 0.07.*phi.*exp(-(v+60)./20);
    end

    function val = betan(v)
        val = 0.125.*phi.*exp(-(v+60)./80);
    end

    function val = betam(v)
        val = 4*phi*exp(-(v+60)/18);
    end

    function val = betah(v)
        val = phi./(exp(-(v+30)./10)+1);
    end
end