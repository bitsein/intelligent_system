

clear all; rand('state',0); randn('state',0);
n=200; a=linspace(0,4*pi,n/2);
u=[a.*cos(a) (a+pi).*cos(a)]'+rand(n,1);
v=[a.*sin(a) (a+pi).*sin(a)]'+rand(n,1);
x=[u v]; y=[ones(1,n/2) -ones(1,n/2)]';
C=1; hh=2*1^2;

t=SVM(x,y,C,hh);


m=100; X=linspace(-16,16,m)'; X2=X.^2;
U=exp(-(repmat(u.^2,1,m)+repmat(X2',n,1)-2*u*X')/hh);
V=exp(-(repmat(v.^2,1,m)+repmat(X2',n,1)-2*v*X')/hh);
figure(1); clf; hold on; axis([-16 16 -16 16]);
contourf(X,X,sign(V'*(U.*repmat(t,1,m))));
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');
colormap([1 0.7 1; 0.7 1 1]);


function t = SVM(x, y, C, hh)
    [n,column] = size(x);
    t = zeros(n,1);
    t_dot = zeros(n,1);
    for i = 1:n
        x2(i) = norm(x(i,:))^2;
    end  
    k = exp(-(repmat(x2,n,1)+repmat(x2',1,n)-2*x*x')/hh);
    e = 0.5;

    for i = 1:n
        ftx = t' * k(i,:)';
        if(1 - ftx*y(i) > 0)
            for j = 1:n
                t_dot(j) = t_dot(j) - y(i) * k(i, j);
            end
        end
    end
    
    m=0;
    while norm(t_dot) > 3 && m < 10000
        t = t - e * (C * t_dot + 2 * k * t);
        
        t_dot = zeros(n,1);
        for i = 1:n
            ftx = t' * k(i,:)';
            if(1 - ftx*y(i) > 0)
                for j = 1:n
                    t_dot(j) = t_dot(j) - y(i) * k(i, j);
                end
            end
        end
        m = m+1;
        e = e * 0.9;
    end
end
