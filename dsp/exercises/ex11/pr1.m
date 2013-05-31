fT = 8000;
fp = 1000;
fs = 2000;
Rp = 2;
Rs = 40;
Wp = fp/(fT/2);
Ws = 2*fs/fT;
type = '';

speksitIIR(Wp, Ws, Rp, Rs, type, fT)

%%
fT = 24000;
fp = 3000;
fs = 2000;
Rp = 1;
Rs = 50;
Wp = fp/(fT/2);
Ws = 2*fs/fT;
type = 'high';

clf; speksitIIR(Wp, Ws, Rp, Rs, type, fT)