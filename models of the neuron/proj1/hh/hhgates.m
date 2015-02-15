function dotgate = hhgates(v, gate)
[params, iext] = gethhparams();
phi = params(8).^((params(7)-6.3)./10);
dotgate = zeros(3,1);

dotgate(1,:) = alphan(v).*(1-gate(1)) - betan(v).*gate(1); %ngate
dotgate(2,:) = alpham(v).*(1-gate(2)) - betam(v).*gate(2); %mgate
dotgate(3,:) = alphah(v).*(1-gate(3)) - betah(v).*gate(3); %hgate

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

