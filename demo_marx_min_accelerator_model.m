function demo_marx_min_accelerator_model()
    % Minimal accelerator model with surplus value
    T=150; w=1.0; A=1.2; % labor productivity
    Lbar=100; delta=0.05; alphaI=0.15; c=0.6; % propensity to consume
    K=100; p=1.0; r=0.04;

    Y=zeros(T,1); C=Y; I=Y; Prof=Y; L=Y;
    for t=1:T
        L(t)=min(Lbar, K);           % labor employed limited by capital
        Y(t)=A*L(t);                 % output
        W=w*L(t);                    % wage bill
        Prof(t)=p*Y(t)-W - r*K;      % surplus value
        I(t)=max(0, alphaI*Prof(t)); % investment out of profits
        C(t)=c*(W+max(Prof(t),0));   % workers + some capitalist consumption
        K = (1-delta)*K + I(t);      % capital accumulation
        % small negative demand shock every 30 periods to mimic gluts
        if mod(t,30)==0, C(t)=0.9*C(t); end
    end

    figure('Name','Marx — Boom-Bust via Accelerator');
    tiledlayout(2,2);
    nexttile; plot(Y); title('Output'); grid on;
    nexttile; plot(Prof); title('Profits (Surplus Value)'); grid on;
    nexttile; plot(I); title('Investment'); grid on;
    nexttile; plot(C); title('Consumption'); grid on;
end