%menampilkan dan membaca data dari real.xlsx
opts = detectImportOptions('real.xlsx');
opts.SelectedVariableNames = (3:5);
data1 = readmatrix('real.xlsx',opts);

opts = detectImportOptions('real.xlsx');
opts.SelectedVariableNames = (8);
data2 = readmatrix('real.xlsx',opts);

%menampilkan hingga data ke-50 saja
data = [data1 data2];
data=data(1:50,:);

%data rating kecocokan setiap alternatif
x = data;

%atribut dari setiap kriteria,
% 1=atrribut keuntungan   
% 0= atribut biaya
k = [0,0,1,0];

%Nilai bobot tiap kriteria 
%1= sangat buruk 
%2=buruk 
%3= cukup
%4= tinggi 
%5= sangat tinggi
w = [3,5,4,1];



%langkah pertama yaitu melakukan perbaikan bobot
%inisialisasi ukuran x
[m n]=size (x); 

 %membagi bobot per kriteria dengan jumlah total seluruh bobot
w=w./sum(w);

%langkah kedua yaitu melakukan perhitungan vektor(S) tiap baris 
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%langkah ketiga melakukan proses perangkingan
V= S/sum(S);

Vtranspose=V.';
opts = detectImportOptions('real.xlsx');
opts.SelectedVariableNames = (1);
x2= readmatrix('real.xlsx',opts);
x2=x2(1:50,:);
x2=[x2 Vtranspose];
x2=sortrows(x2,-2);
x2 = x2(1:5,1);

%Menampilkan hasil
disp ('Nomor Real Estate yang paling mendapaat rekomendasi =')
disp (x2)