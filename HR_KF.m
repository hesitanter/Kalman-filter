clear;
dom = xmlread('C:\Users\Ke Ma\Dropbox\dage&laodi\OhioT1DM-training\OhioT1DM-training\591-ws-training.xml');
nodes = dom.getElementsByTagName("basis_heart_rate");
node = nodes.item(0);
data = node.getElementsByTagName('event');
len = data.getLength

%????
times = linspace(1, len, 1);
values = linspace(1, len, 1);
for i = 1 : len
    element = data.item(i-1);
    time = element.getAttribute('ts');
    value = element.getAttribute('value');
    %times(i) = str2num(time);
    values(i) = str2num(value);
end

%{
x(k+1) = A*x(k) + W
z(k) = x(k) + v 
https://leijiezhang001.github.io/%E5%8D%A1%E5%B0%94%E6%9B%BC%E6%BB%A4%E6%B3%A2%E8%AF%A6%E8%A7%A3/
https://zhuanlan.zhihu.com/p/34656822
https://blog.csdn.net/u013165921/article/details/78328230
https://blog.csdn.net/zengxiantao1994/article/details/71170728
%}
N = len;
Q = 1e-3;
R = 0.36;
A = 1;
T_start = values(1); P_start = 1;
T_kalman(1) = T_start; P_kalman(1) = P_start;
for k = 2:N
    T_pre(k) = A * T_kalman(k-1);
    P_pre(k) = P_kalman(k-1) + Q;
    K(k) = P_pre(k) / (P_pre(k) + R);
    T_kalman(k) = T_pre(k) + K(k) * (values(k)-T_pre(k));
    P_kalman(k)=P_pre(k)-K(k)*P_pre(k);
end
figure();
subplot(2,1,1);
plot(T_kalman, 'r');
hold on
subplot(2,1,2);
plot(values, 'g');
hold on





