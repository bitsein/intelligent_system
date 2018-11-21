%{
交差確認法による正則化回帰のパラメータ決定
パラメータはガウスカーネルのバンド幅hとパラメータの大きさへの罰則λ
%}
clear all; rand('state',0); randn('state',0);
n=50; N=1000;

x=linspace(-3,3,n)'; X=linspace(-3,3,N)';
pix=pi*x; y=sin(pix)./(pix)+0.1*x+0.2*randn(n,1);
r = randperm(n)';
z = horzcat(x,y,r); [Y, I] = sort(z(:,3)); z = z(I,:); m = n/5;
x_1 = z(1    :  m,1); y_1 = z(1    :  m,2);
x_2 = z(1+  m:2*m,1); y_2 = z(1+  m:2*m,2);
x_3 = z(1+2*m:3*m,1); y_3 = z(1+2*m:3*m,2);
x_4 = z(1+3*m:4*m,1); y_4 = z(1+3*m:4*m,2);
x_5 = z(1+4*m:5*m,1); y_5 = z(1+4*m:5*m,2);
d = 50;
C = zeros(d);

for a = 1:d
    for b = 1:d
        h = 0.38 + 0.08 * a / d; hh = 2*h^2;
        l = 0.19 + 0.09 * b / d;
        %{
        h=0.3; hh=2*h^2; l=0.1;
        %}
        x = vertcat(x_1, x_2, x_3, x_4);
        y = vertcat(y_1, y_2, y_3, y_4);
        x2=x.^2;
        k=exp(-(repmat(x2,1,4*m)+repmat(x2',4*m,1)-2*x*x')/hh);
        t=(k^2+l*eye(4*m))\(k*y);
        X2=X.^2;
        K=exp(-(repmat(X2,1,4*m)+repmat(x2',N,1)-2*X*x')/hh);
        F=K*t; c=0;
        for i = 1:m
            c = c + (y_5(i) - F(round((x_5(i)+3)*(N-1)/6 + 0.5)))^2;
        end

        x = vertcat(x_1, x_2, x_3, x_5);
        y = vertcat(y_1, y_2, y_3, y_5);
        x2=x.^2;
        k=exp(-(repmat(x2,1,4*m)+repmat(x2',4*m,1)-2*x*x')/hh);
        t=(k^2+l*eye(4*m))\(k*y);
        X2=X.^2;
        K=exp(-(repmat(X2,1,4*m)+repmat(x2',N,1)-2*X*x')/hh);
        F=K*t;
        for i = 1:m
            c = c + (y_4(i) - F(round((x_4(i)+3)*(N-1)/6 + 0.5)))^2;
        end

        x = vertcat(x_1, x_2, x_4, x_5);
        y = vertcat(y_1, y_2, y_4, y_5);
        x2=x.^2;
        k=exp(-(repmat(x2,1,4*m)+repmat(x2',4*m,1)-2*x*x')/hh);
        t=(k^2+l*eye(4*m))\(k*y);
        X2=X.^2;
        K=exp(-(repmat(X2,1,4*m)+repmat(x2',N,1)-2*X*x')/hh);
        F=K*t;
        for i = 1:m
            c = c + (y_3(i) - F(round((x_3(i)+3)*(N-1)/6 + 0.5)))^2;
        end

        x = vertcat(x_1, x_3, x_4, x_5);
        y = vertcat(y_1, y_3, y_4, y_5);
        x2=x.^2;
        k=exp(-(repmat(x2,1,4*m)+repmat(x2',4*m,1)-2*x*x')/hh);
        t=(k^2+l*eye(4*m))\(k*y);
        X2=X.^2;
        K=exp(-(repmat(X2,1,4*m)+repmat(x2',N,1)-2*X*x')/hh);
        F=K*t;
        for i = 1:m
            c = c + (y_2(i) - F(round((x_2(i)+3)*(N-1)/6 + 0.5)))^2;
        end

        x = vertcat(x_2, x_3, x_4, x_5);
        y = vertcat(y_2, y_3, y_4, y_5);
        x2=x.^2;
        k=exp(-(repmat(x2,1,4*m)+repmat(x2',4*m,1)-2*x*x')/hh);
        t=(k^2+l*eye(4*m))\(k*y);
        X2=X.^2;
        K=exp(-(repmat(X2,1,4*m)+repmat(x2',N,1)-2*X*x')/hh);
        F=K*t;
        for i = 1:m
            c = c + (y_1(i) - F(round((x_1(i)+3)*(N-1)/6 + 0.5)))^2;
        end

        c = c/10;
        C(a, b) = c;
    end
end

[M, I] = min(C(:));
[R, Q] = quorem(sym(I),sym(d));
h = 0.38 + 0.08 * R / d;
l = 0.18 + 0.12 * Q / d;
disp(h);
disp(l);

%{
figure(1); clf; hold on; axis([-2.8 2.8 -1 1.5]);
plot(X,F,'g-'); plot(x,y,'bo');
%}
