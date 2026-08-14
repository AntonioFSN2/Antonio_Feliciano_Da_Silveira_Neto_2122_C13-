%% Relatório 1 - Aulas 1 e 2

%% Exercício 1 - Análise de três medições
m1 = input('Digite a primeira medição: ');
m2 = input('Digite a segunda medição: ');
m3 = input('Digite a terceira medição: ');

medidas = [m1, m2, m3];

media1 = mean(medidas);
maior1 = max(medidas);
menor1 = min(medidas);

fprintf('Média: %.2f\n', media1);
fprintf('Maior valor: %.2f\n', maior1);
fprintf('Menor valor: %.2f\n', menor1);

if media1 >= 8
    disp('Resultado alto');
elseif media1 >= 5
    disp('Resultado intermediário');
else
    disp('Resultado baixo');
end


%% Exercício 2 - Processamento de um vetor com for
A2 = [3 8 2 10 5 7 1 6];
B2 = zeros(1, length(A2));

for i = 1:length(A2)
    if A2(i) >= 6
        B2(i) = A2(i) * 2;
    else
        B2(i) = A2(i) + 3;
    end
end

A2
B2
soma_B2 = sum(B2)
media_B2 = mean(B2)
maior_B2 = max(B2)
menor_B2 = min(B2)


%% Exercício 3 - Identificação de números pares em um vetor
A3 = [14 7 20 9 6 11 18 5];
B3 = zeros(1, length(A3));
contador3 = 0;

for i = 1:length(A3)
    if rem(A3(i), 2) == 0
        B3(i) = A3(i);
        contador3 = contador3 + 1;
    else
        B3(i) = 0;
    end
end

B3
fprintf('Quantidade de números pares: %d\n', contador3);


%% Exercício 4 - Calculadora com menu usando switch
v1_4 = input('Digite o primeiro valor: ');
v2_4 = input('Digite o segundo valor: ');

disp('1 - Soma');
disp('2 - Subtração');
disp('3 - Multiplicação');
disp('4 - Divisão');
opcao4 = input('Escolha uma opção: ');

switch opcao4
    case 1
        resultado4 = v1_4 + v2_4;
        fprintf('Resultado: %.2f\n', resultado4);
    case 2
        resultado4 = v1_4 - v2_4;
        fprintf('Resultado: %.2f\n', resultado4);
    case 3
        resultado4 = v1_4 * v2_4;
        fprintf('Resultado: %.2f\n', resultado4);
    case 4
        if v2_4 == 0
            disp('A operação não pode ser realizada (divisão por zero)');
        else
            resultado4 = v1_4 / v2_4;
            fprintf('Resultado: %.2f\n', resultado4);
        end
    otherwise
        disp('Opção inválida');
end


%% Exercício 5 - Acumulador com while
soma5 = 0;
contador5 = 0;

while soma5 <= 4
    valor5 = rand();
    soma5 = soma5 + valor5;
    contador5 = contador5 + 1;
    fprintf('Valor sorteado: %.4f | Soma atual: %.4f\n', valor5, soma5);
end

if contador5 > 8
    disp('Muitas repetições');
else
    disp('Poucas repetições');
end

fprintf('Número total de repetições: %d\n', contador5);


%% Exercício 6 - Processamento de uma matriz com dois laços for
A6 = [2 7 4 9;
      6 1 8 3];

B6 = zeros(size(A6));
[linhas6, colunas6] = size(A6);

for j = 1:linhas6
    for i = 1:colunas6
        if A6(j,i) > 5
            B6(j,i) = A6(j,i) * 2;
        else
            B6(j,i) = A6(j,i) + 5;
        end
    end
end

A6
B6
transposta_B6 = B6'
primeira_linha_B6 = B6(1, :)
terceira_coluna_B6 = B6(:, 3)


%% Exercício 7 - Função com duas saídas para analisar um vetor
A7 = [5 12 7 3 9 14];

[soma7, media7] = analisa_vetor(A7);

if media7 >= 8
    disp('Média elevada');
else
    disp('Média abaixo de 8');
end

fprintf('Soma: %.2f\n', soma7);
fprintf('Média: %.2f\n', media7);


%% Exercício 8 - Função para transformar uma matriz
A8 = [1 5 3 8;
      6 2 7 4];
B8 = zeros(size(A8));

B8 = transforma_matriz(A8, B8);

B8


%% Exercício 9 - Entrada como texto e conversão numérica
texto1_9 = input('Digite o primeiro valor: ', 's');
texto2_9 = input('Digite o segundo valor: ', 's');

disp(texto1_9);
disp(texto2_9);

num1_9 = str2num(texto1_9); %#ok<ST2NM>
num2_9 = str2num(texto2_9); %#ok<ST2NM>

soma9 = num1_9 + num2_9;
multiplicacao9 = num1_9 * num2_9;

fprintf('Soma: %.2f\n', soma9);
fprintf('Multiplicação: %.2f\n', multiplicacao9);

if soma9 > 20
    disp('Soma alta');
elseif soma9 == 20
    disp('Soma igual a 20');
else
    disp('Soma baixa');
end


%% Exercício 10 - Desafio integrador: análise de dados e escolha de gráfico
dados10 = [12 18 10 25 15];

soma_dados10 = sum(dados10);
media_dados10 = mean(dados10);
maior_dado10 = max(dados10);
menor_dado10 = min(dados10);

fprintf('Soma: %.2f\n', soma_dados10);
fprintf('Média: %.2f\n', media_dados10);
fprintf('Maior valor: %.2f\n', maior_dado10);
fprintf('Menor valor: %.2f\n', menor_dado10);

contador10 = 0;
for i = 1:length(dados10)
    if dados10(i) >= media_dados10
        contador10 = contador10 + 1;
    end
end

disp('1 - Gráfico de barras');
disp('2 - Gráfico de pizza');
opcao10 = input('Escolha uma opção: ');

switch opcao10
    case 1
        bar(dados10);
        title('Gráfico de Barras dos Dados');
    case 2
        pie3(dados10);
        title('Gráfico de Pizza dos Dados');
    otherwise
        warning('Nenhum gráfico foi criado.');
end

if contador10 > length(dados10)/2
    disp('Maioria dos valores acima ou igual à média');
else
    disp('Menos da metade dos valores acima ou igual à média');
end


%% Funções locais

function [soma, media] = analisa_vetor(vetor)
    soma = sum(vetor);
    media = mean(vetor);
end

function B = transforma_matriz(A, B)
    [linhas, colunas] = size(A);
    for j = 1:linhas
        for i = 1:colunas
            if A(j,i) >= 5
                B(j,i) = A(j,i) * 2 * exp(1);
            else
                B(j,i) = A(j,i) * 2;
            end
        end
    end
end