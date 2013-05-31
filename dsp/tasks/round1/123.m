puhnumero = '050 581 0518';
y = myGenDTMF(puhnumero);
soundsc(y, 8000);
printsetup();
spectrogram(y,512,256,512,8000)
printfig('png', '123')