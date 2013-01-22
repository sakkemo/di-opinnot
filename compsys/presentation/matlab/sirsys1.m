function dy = sirsys1(t,y,beta,v)
dy = zeros (3,1);
dy(1)=-beta*y(1)*y(2);            %(force of infection) lambda = beta*y(2)
dy(2)=beta*y(1)*y(2)-v*y(2);
dy(3)=v*y(2);
