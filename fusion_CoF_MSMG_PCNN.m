function cp=fusion_CoF_MSMG_PCNN(matrixA,matrixB)

%% Initialize parameter
Para.iterTimes=200;
Para.link_arrange=7;
Para.alpha_L=0.02;
Para.alpha_Theta=3;
Para.beta=3;
Para.vL=1;
Para.vTheta=20;
t = 11;

%%
MSMG_A=multiscale_morph(abs(matrixA),t);
MSMG_B=multiscale_morph(abs(matrixB),t);

%%
PCNN_timesA=PCNN_withParameters(MSMG_A,Para);
PCNN_timesB=PCNN_withParameters(MSMG_B,Para);
map=(PCNN_timesA>=PCNN_timesB);

%%
cp=map.*matrixA+~map.*matrixB;