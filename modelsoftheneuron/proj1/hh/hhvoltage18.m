function ydot = hhvoltage18(t, y)
%y(1,2,3,4) = v, gk, gna, gl
[params, iext] = gethhparams();
phi = params(8).^((params(7)-6.3)./10);
phi =1;
ydot = zeros(2,1);
a = 0.95; b =-1.05;

if t<=iext(3) && t>= iext(2)
    ydot(1) = (iext(1)- params(1).*y(2).^4.*(y(1)-params(4))  ...
        -params(2).*(alpham(y(1))/(alpham(y(1))+betam(y(1)))).^3.*(a + b*y(2)).*(y(1)-params(5)) ...
        -params(3)*(y(1)-params(6)))/params(9) ;
else
    ydot(1) = (-params(1).*y(2).^4.*(y(1)-params(4))  ...
        -params(2).*minfhh(y(1)).^3.*(a + b*y(2)).*(y(1)-params(5)) ...
        -params(3)*(y(1)-params(6)))/params(9) ;
end
ydot(2) = alphan(y(1))*(1-y(2)) - betan(y(1))*y(2); %ngate

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

    function val = betan(v)
        val = 0.125.*phi.*exp(-(v+60)./80);
    end

    function val = betam(v)
        val = 4*phi*exp(-(v+60)/18);
    end

end