clear; clc; close all;

%% Exercicio 1 - Identificacao de um sistema de primeira ordem

K1   = 1.8;      % ganho estatico
tau1 = 1.2;      % constante de tempo [s]

G1 = tf(K1, [tau1 1]);          % G1(s) = K1 / (tau1*s + 1)

polo1   = pole(G1);
tr1     = 2.2*tau1;             % tempo de subida (10-90%)
ts1     = 4*tau1;               % tempo de acomodacao (2%)
ganho1  = dcgain(G1);           % ganho em regime permanente

fprintf('=== EXERCICIO 1 ===\n');
fprintf('Funcao de transferencia: G1(s) = %.4g / (%.4g s + 1)\n', K1, tau1);
fprintf('Ganho K = %.4g\n', K1);
fprintf('Constante de tempo tau = %.4g s\n', tau1);
fprintf('Polo do sistema = %.4f\n', polo1);
fprintf('Tempo de subida (10-90%%) = %.4f s\n', tr1);
fprintf('Tempo de acomodacao (2%%) = %.4f s\n', ts1);
fprintf('Ganho em regime permanente = %.4g\n\n', ganho1);

t = 0:0.01:8;
y1 = K1*(1 - exp(-t/tau1));     % resposta ao degrau unitario

figure;
plot(t, y1, 'b', 'LineWidth', 1.5); grid on;
xlabel('Tempo (s)'); ylabel('Saida y(t)');
title('Exercicio 1 - Resposta ao degrau unitario');
legend('G_1(s)', 'Location', 'southeast');

% Entrada em degrau de amplitude 2,5
amp1 = 2.5;
valorFinal_amp = K1*amp1;
y1_amp = amp1*y1;

fprintf('Para entrada degrau de amplitude %.2f:\n', amp1);
fprintf('Novo valor final da saida = %.4g\n\n', valorFinal_amp);

figure;
plot(t, y1_amp, 'r', 'LineWidth', 1.5); grid on;
xlabel('Tempo (s)'); ylabel('Saida y(t)');
title(sprintf('Exercicio 1 - Resposta ao degrau de amplitude %.2f', amp1));
legend(sprintf('G_1(s), entrada = %.2f', amp1), 'Location', 'southeast');

% Comentarios:
% 1) Quanto menor a constante de tempo tau, mais o polo (-1/tau) se afasta
%    da origem (mais negativo), tornando a resposta transitoria mais rapida.
% 2) O tempo de subida e o tempo de acomodacao sao diretamente
%    proporcionais a tau: aumentar tau torna a resposta mais lenta.


%% Exercicio 2 - Escolha entre tres sistemas de segunda ordem
GA = tf(25, [1 3 25]);
GB = tf(25, [1 10 25]);
GC = tf(25, [1 16 25]);

[wnA, zetaA, poloA] = damp(GA);
[wnB, zetaB, poloB] = damp(GB);
[wnC, zetaC, poloC] = damp(GC);

wnA = wnA(1); zetaA = zetaA(1);
wnB = wnB(1); zetaB = zetaB(1);
wnC = wnC(1); zetaC = zetaC(1);

tipoA = classifica_amortecimento(zetaA);
tipoB = classifica_amortecimento(zetaB);
tipoC = classifica_amortecimento(zetaC);

fprintf('=== EXERCICIO 2 ===\n');
imprime_2a_ordem('Sistema A', poloA, wnA, zetaA, tipoA, dcgain(GA));
imprime_2a_ordem('Sistema B', poloB, wnB, zetaB, tipoB, dcgain(GB));
imprime_2a_ordem('Sistema C', poloC, wnC, zetaC, tipoC, dcgain(GC));

t2 = 0:0.01:8;
yA = step(GA, t2);
yB = step(GB, t2);
yC = step(GC, t2);

figure;
plot(t2, yA, 'b', t2, yB, 'r', t2, yC, 'g', 'LineWidth', 1.5); grid on;
xlabel('Tempo (s)'); ylabel('Saida y(t)');
title('Exercicio 2 - Resposta ao degrau unitario');
legend('Sistema A (\zeta=0,30)', 'Sistema B (\zeta=1,00)', 'Sistema C (\zeta=1,60)', ...
       'Location', 'southeast');

figure;
plot(real(poloA), imag(poloA), 'bx', 'MarkerSize', 10, 'LineWidth', 2); hold on;
plot(real(poloB), imag(poloB), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(poloC), imag(poloC), 'gx', 'MarkerSize', 10, 'LineWidth', 2);
grid on; xlabel('Eixo real'); ylabel('Eixo imaginario');
title('Exercicio 2 - Posicao dos polos');
legend('Sistema A', 'Sistema B', 'Sistema C', 'Location', 'best');

fprintf('Analise: a aplicacao nao permite sobressinal, o que exclui o Sistema A\n');
fprintf('(subamortecido, zeta < 1). Entre B (criticamente amortecido) e C\n');
fprintf('(sobreamortecido), o Sistema B atinge o regime permanente mais rapido.\n');
fprintf('Sistema mais adequado: Sistema B.\n\n');

% Comentario:
% O Sistema B foi escolhido por ser o mais rapido entre os sistemas sem
% sobressinal, pois o amortecimento critico (zeta = 1) representa a menor
% razao de amortecimento capaz de evitar oscilacoes na resposta.


%% Exercicio 3 - Avaliacao de desempenho de dois sistemas de segunda ordem
G_1 = tf(16, [1 2.8 16]);
G_2 = tf(25, [1 6.5 25]);

[wn_1, zeta_1] = damp(G_1); wn_1 = wn_1(1); zeta_1 = zeta_1(1);
[wn_2, zeta_2] = damp(G_2); wn_2 = wn_2(1); zeta_2 = zeta_2(1);

fprintf('=== EXERCICIO 3 ===\n');
m1 = metricas_2a_ordem(zeta_1, wn_1, dcgain(G_1));
m2 = metricas_2a_ordem(zeta_2, wn_2, dcgain(G_2));

imprime_metricas('Sistema 1', m1);
imprime_metricas('Sistema 2', m2);

t3 = 0:0.001:8;
y_1 = step(G_1, t3);
y_2 = step(G_2, t3);

figure;
plot(t3, y_1, 'b', t3, y_2, 'r', 'LineWidth', 1.5); grid on;
xlabel('Tempo (s)'); ylabel('Saida y(t)');
title('Exercicio 3 - Resposta ao degrau unitario');
legend('Sistema 1', 'Sistema 2', 'Location', 'southeast');

fprintf('Requisitos: Mp < 10%% e ts(2%%) < 1,5 s\n');
fprintf('Sistema 1: Mp = %.2f%% (%s), ts = %.3f s (%s)\n', m1.Mp*100, ...
    aprova(m1.Mp < 0.10), m1.ts, aprova(m1.ts < 1.5));
fprintf('Sistema 2: Mp = %.2f%% (%s), ts = %.3f s (%s)\n', m2.Mp*100, ...
    aprova(m2.Mp < 0.10), m2.ts, aprova(m2.ts < 1.5));
fprintf('Sistema que atende aos requisitos: Sistema 2\n\n');

% Comentarios:
% 1) O Sistema 1 (zeta = 0,35) apresenta maior sobressinal e resposta mais
%    oscilatoria/lenta para acomodar, enquanto o Sistema 2 (zeta = 0,65) e
%    mais amortecido e se estabiliza mais rapidamente.
% 2) Apenas o Sistema 2 atende simultaneamente aos requisitos de
%    sobressinal maximo (<10%) e tempo de acomodacao (<1,5 s), sendo o
%    mais indicado para a aplicacao.


%% Exercicio 4 - Selecao de parametros para um sistema de segunda ordem
configs = struct('nome', {}, 'zeta', {}, 'wn', {});
configs(1) = struct('nome', 'Configuracao A', 'zeta', 0.35, 'wn', 6.0);
configs(2) = struct('nome', 'Configuracao B', 'zeta', 0.55, 'wn', 5.0);
configs(3) = struct('nome', 'Configuracao C', 'zeta', 0.70, 'wn', 4.0);
configs(4) = struct('nome', 'Configuracao D', 'zeta', 0.80, 'wn', 3.2);

fprintf('=== EXERCICIO 4 ===\n');
t4 = 0:0.001:8;
figure; hold on;
cores = {'b', 'r', 'g', 'm'};
metr = struct([]);

for i = 1:4
    z = configs(i).zeta; wn = configs(i).wn;
    Gi = tf(wn^2, [1 2*z*wn wn^2]);      % forma padrao de 2a ordem
    m = metricas_2a_ordem(z, wn, dcgain(Gi));
    metr = [metr, m]; %#ok<AGROW>
    imprime_metricas(configs(i).nome, m);

    yi = step(Gi, t4);
    plot(t4, yi, cores{i}, 'LineWidth', 1.5);
end

grid on; xlabel('Tempo (s)'); ylabel('Saida y(t)');
title('Exercicio 4 - Resposta ao degrau unitario');
legend({configs.nome}, 'Location', 'southeast');

fprintf('Requisitos: Mp < 10%% e ts(2%%) < 1,5 s\n');
validas = false(1,4);
for i = 1:4
    ok = metr(i).Mp < 0.10 && metr(i).ts < 1.5;
    validas(i) = ok;
    fprintf('%s: Mp = %.2f%%, ts = %.3f s -> %s\n', configs(i).nome, ...
        metr(i).Mp*100, metr(i).ts, aprova(ok));
end

idxValidas = find(validas);
[~, iMin] = min([metr(idxValidas).tr]);
melhorConfig = configs(idxValidas(iMin)).nome;
fprintf('Configuracao selecionada (menor tempo de subida entre as validas): %s\n\n', melhorConfig);

% Comentarios:
% 1) As configuracoes A e B foram descartadas por apresentarem sobressinal
%    acima de 10%%, e a configuracao D foi descartada por ultrapassar
%    levemente o tempo de acomodacao de 1,5 s.
% 2) A configuracao C foi a unica que atendeu simultaneamente aos dois
%    requisitos, sendo portanto a escolhida para a aplicacao.


%% Exercicio 5 - Comparacao entre sistemas de primeira e segunda ordem
K_A = 2; tau_A = 1.2;
GA5 = tf(K_A, [tau_A 1]);

wn_B = 4; zeta_B = 5.6/(2*wn_B);   % de s^2+5.6s+16 -> wn^2=16, 2*zeta*wn=5.6
GB5 = tf(32, [1 5.6 16]);

fprintf('=== EXERCICIO 5 (entrada degrau unitario) ===\n');
poloA5 = pole(GA5);
trA5 = 2.2*tau_A;
tsA5 = 4*tau_A;
ganhoA5 = dcgain(GA5);
fprintf('--- Equipamento A (1a ordem) ---\n');
fprintf('Polo = %.4f\n', poloA5);
fprintf('Ganho em regime permanente = %.4g\n', ganhoA5);
fprintf('Valor final (degrau unitario) = %.4g\n', ganhoA5);
fprintf('Tempo de subida (10-90%%) = %.4f s\n', trA5);
fprintf('Tempo de acomodacao (2%%) = %.4f s\n\n', tsA5);

mB5 = metricas_2a_ordem(zeta_B, wn_B, dcgain(GB5));
fprintf('--- Equipamento B (2a ordem) ---\n');
imprime_metricas('Equipamento B', mB5);

t5 = 0:0.001:8;
yA5 = step(GA5, t5);
yB5 = step(GB5, t5);

figure;
plot(t5, yA5, 'b', t5, yB5, 'r', 'LineWidth', 1.5); grid on;
xlabel('Tempo (s)'); ylabel('Saida y(t)');
title('Exercicio 5 - Resposta ao degrau unitario');
legend('Equipamento A', 'Equipamento B', 'Location', 'southeast');

% Entrada em degrau de amplitude 1,5
amp5 = 1.5;
valorFinalA_amp = ganhoA5*amp5;
valorFinalB_amp = dcgain(GB5)*amp5;
fprintf('Entrada degrau de amplitude %.2f:\n', amp5);
fprintf('Valor final Equipamento A = %.4g\n', valorFinalA_amp);
fprintf('Valor final Equipamento B = %.4g\n\n', valorFinalB_amp);

figure;
plot(t5, amp5*yA5, 'b', t5, amp5*yB5, 'r', 'LineWidth', 1.5); grid on;
xlabel('Tempo (s)'); ylabel('Saida y(t)');
title(sprintf('Exercicio 5 - Resposta ao degrau de amplitude %.2f', amp5));
legend('Equipamento A', 'Equipamento B', 'Location', 'southeast');

% Comentarios:
% 1) Quanto a rapidez: o Equipamento B (2a ordem) atinge a vizinhanca do
%    valor final mais rapidamente que o Equipamento A (1a ordem), pois seu
%    tempo de subida e de acomodacao sao menores.
% 2) Quanto ao sobressinal: o Equipamento A nao apresenta sobressinal (1a
%    ordem), enquanto o Equipamento B apresenta um pequeno sobressinal por
%    ser subamortecido (zeta < 1).
% 3) Quanto ao regime permanente: como os dois equipamentos possuem o
%    mesmo ganho estatico (K = 2), ambos atingem o mesmo valor final para
%    qualquer amplitude de entrada, mudando apenas a forma como esse valor
%    e alcancado.


%% ========================= FUNCOES LOCAIS ==============================
function tipo = classifica_amortecimento(zeta)
    if zeta < 1
        tipo = 'subamortecido';
    elseif zeta == 1
        tipo = 'criticamente amortecido';
    else
        tipo = 'sobreamortecido';
    end
end

function imprime_2a_ordem(nome, polos, wn, zeta, tipo, ganhoDC)
    fprintf('--- %s ---\n', nome);
    fprintf('Polos: %s\n', mat2str(polos, 4));
    fprintf('Frequencia natural wn = %.4f rad/s\n', wn);
    fprintf('Coeficiente de amortecimento zeta = %.4f\n', zeta);
    fprintf('Tipo de resposta: %s\n', tipo);
    fprintf('Ganho em regime permanente = %.4g\n\n', ganhoDC);
end

function m = metricas_2a_ordem(zeta, wn, ganhoDC)
    % Formulas padrao para sistema de 2a ordem subamortecido (0 < zeta < 1)
    wd    = wn*sqrt(1 - zeta^2);
    beta  = acos(zeta);
    td    = (1 + 0.7*zeta)/wn;          % tempo de atraso (50%)
    tr    = (pi - beta)/wd;             % tempo de subida (0-100%)
    tp    = pi/wd;                      % tempo de pico
    Mp    = exp(-zeta*pi/sqrt(1 - zeta^2)); % sobressinal maximo (fracao)
    ts    = 4/(zeta*wn);                % tempo de acomodacao (2%)
    peak  = ganhoDC*(1 + Mp);           % valor do primeiro pico
    polos = [-zeta*wn + 1i*wd, -zeta*wn - 1i*wd];

    m = struct('zeta', zeta, 'wn', wn, 'wd', wd, 'td', td, 'tr', tr, ...
                'tp', tp, 'Mp', Mp, 'ts', ts, 'peak', peak, ...
                'polos', polos, 'ganhoDC', ganhoDC, 'valorFinal', ganhoDC);
end

function imprime_metricas(nome, m)
    fprintf('--- %s ---\n', nome);
    fprintf('Valor final da resposta = %.4g\n', m.valorFinal);
    fprintf('Tempo de atraso (50%%) = %.4f s\n', m.td);
    fprintf('Tempo de subida (0-100%%) = %.4f s\n', m.tr);
    fprintf('Tempo de pico = %.4f s\n', m.tp);
    fprintf('Valor do primeiro pico = %.4f\n', m.peak);
    fprintf('Sobressinal maximo (Mp) = %.2f%%\n', m.Mp*100);
    fprintf('Tempo de acomodacao (2%%) = %.4f s\n', m.ts);
    fprintf('Frequencia natural wn = %.4f rad/s\n', m.wn);
    fprintf('Coeficiente de amortecimento zeta = %.4f\n', m.zeta);
    fprintf('Polos: %s\n\n', mat2str(m.polos, 4));
end

function s = aprova(cond)
    if cond
        s = 'ATENDE';
    else
        s = 'NAO ATENDE';
    end
end