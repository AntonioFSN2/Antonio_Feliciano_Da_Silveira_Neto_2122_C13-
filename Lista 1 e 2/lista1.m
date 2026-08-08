%%Lista 1 

%% Questão 1 - Operações básicas 

a = 12;
b = 5;

soma = a + b
subtracao = a - b
multiplicacao = a * b
divisao = a / b
potencia = a ^ b

%% Questão 2 - Raiz, arredondamento e resto

raiz = sqrt(144)
round(7.6)
ceil(4.01)
resto = rem(250, 17)

%% Questão 3 - MDC e MMC

mdc = gcd(24, 36)
mmc = lcm(12, 18)

%% Questão 4 - Exponencial e trigonometria

e_quadrado = exp(2)

seno = sin(30*pi/180)    
cose = cos(60*pi/180)
tg = tan(45*pi/180)

%% Questão 5 - Criando Vetores

v1 = 1:10
v2 = 10:-1:1
pares = 0:2:20
v3 = linspace(0, 100, 5)

%% Questão 6 - Acessando posições de um vetor

v4 = [4, 8, 15, 16, 23, 42]

priemiro = v4(1)
ultimo = v4(end)
v4(2 : 4)
v4([1, 3, 6])

%% Questão 7 - Informações sobre um vetor

v5 = [5, 10, 15, 20, 25]

length(v5)    
size(v5)      
sum(v5)       
mean(v5)      
max(v5)       
min(v5)       

%% Questão 8 - Vetor linha e Vetor coluna 

v6 = [10, 20, 30, 40]

transposta = v6'
size(v6)
size(transposta)

%% Questão 9 - Criando e acessando uma matriz 

A = [3, 6, 9;
     2, 4, 8;
     1, 3, 5]

A(2,1)
A(1, :)
A(:, 2)
size(A)

%% Questão 10 - Operações com matrizes 

A = [1, 2;
    3, 4]
B = [2, 0;
     1, 5]

A + B
A * B 
transposta_A = A'

zeros(3)
ones(2, 4)
eye(4)
rand(3)

%%Lista 2

%% Questão 1 - Entrada e Saída

cidade = input("Digite o nome de uma cidade:", "s")

display(cidade)

fprintf("A cidade escolhida foi: %s \n", cidade)

%% Questão 2 - If, elseif, else

x = 7

if x > 10
    disp("Maior que 10")
elseif x == 10
    disp("Igual a 10")
else 
    disp("Menor que 10")
end

%% Questão 3 - for

for i = 1:1:5
    disp(i*3)
end

%% Questão 4 - while

x = 0;
i = 0;

while i < 5
    x = x + 1;
    i = i + 1;
    fprintf("i = %d, x = %d\n", i, x)
end

%% Questão 5 - switch e função
opcao = 2;

switch opcao
    case 1
        disp("Opção A")
    case 2
        disp("Opção B")
    case 3
        disp("Opção C")
    otherwise
        disp("Opção inválida")
end

numero = 7;
triplo = funcao_triplo(numero)