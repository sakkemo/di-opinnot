beta=0.001;v=0.1;%;%before modified, beta=0.005?v=0.05?
                       the figure produced by running this program in matlab is different with Fig.Sirsys-p9.png
                     so let beta=0.001,v=0.1, and try again, then the resoult is right.
options = odeset ('RelTol',1e-4,'AbsTol',1e-4);
[T,Y] = ode45(@sirsys1,[0 60],[500 1 0],options,beta,v);
plot(T,Y(:,1),'.',T,Y(:,2),'.',T,Y(:,3),'.')
