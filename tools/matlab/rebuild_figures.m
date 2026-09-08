function rebuild_figures()
% REBUILD_FIGURES Regenerate primary PYNQ-Z2 MDO figures from committed CSVs.
%
% Run from repository root:
%   addpath('tools/matlab');
%   rebuild_figures;

repo = fileparts(fileparts(fileparts(mfilename('fullpath'))));
outDir = fullfile(repo, 'docs', 'assets', 'plots');
if ~isfolder(outDir)
    mkdir(outDir);
end

acDir = fullfile(repo, 'verification', 'raw', 'afe', 'ac');
trDir = fullfile(repo, 'verification', 'raw', 'afe', 'transient');
awgDir = fullfile(repo, 'verification', 'raw', 'awg');

plot_afe_ac(acDir, outDir);
plot_afe_transients(trDir, outDir);
plot_awg(awgDir, outDir);

fprintf('Figures regenerated in %s\n', outDir);
end

function plot_afe_ac(acDir, outDir)
files = dir(fullfile(acDir, '*.csv'));

for k = 1:numel(files)
    fpath = fullfile(files(k).folder, files(k).name);
    T = readtable(fpath, 'VariableNamingRule', 'preserve');

    if width(T) < 7
        continue;
    end

    f = numeric_column(T, 1);
    ch1 = numeric_column(T, 6);
    ch2 = numeric_column(T, 7);

    good = isfinite(f) & isfinite(ch1) & isfinite(ch2) & f > 0;
    f = f(good);
    ch1 = ch1(good);
    ch2 = ch2(good);

    ref1 = interp1(log10(f), ch1, log10(1e6), 'linear', 'extrap');
    ref2 = interp1(log10(f), ch2, log10(1e6), 'linear', 'extrap');

    rel1 = ch1 - ref1;
    rel2 = ch2 - ref2;

    if contains(lower(files(k).name), 'aafv=1')
        mode = 'FAST';
        nyq = 62.5e6;
    else
        mode = 'DUAL';
        nyq = 31.25e6;
    end

    fig = figure('Visible','off', 'Color','w');
    semilogx(f/1e6, rel1, 'LineWidth',1.4); hold on;
    semilogx(f/1e6, rel2, 'LineWidth',1.4);
    yline(-3, '--', '-3 dB');
    xline(nyq/1e6, '--', sprintf('Nyquist %.2f MHz',nyq/1e6));
    grid on; box on;
    xlabel('Frequency (MHz)');
    ylabel('Relative transfer magnitude (dB)');
    legend('Channel 1','Channel 2','Location','best');
    title(sprintf('%s AAF - post-layout response', mode));

    exportgraphics(fig, fullfile(outDir, ['AFE_' mode '_relative_transfer.png']), ...
        'Resolution',300);
    close(fig);
end

% Comparison plot
dual = find_file(acDir, 'aafv=0');
fast = find_file(acDir, 'aafv=1');

if strlength(dual) > 0 && strlength(fast) > 0
    [fd, gd] = load_transfer(dual);
    [ff, gf] = load_transfer(fast);

    rd = interp1(log10(fd), gd, log10(1e6), 'linear','extrap');
    rf = interp1(log10(ff), gf, log10(1e6), 'linear','extrap');

    fig = figure('Visible','off','Color','w');
    semilogx(ff/1e6, gf-rf, 'LineWidth',1.4); hold on;
    semilogx(fd/1e6, gd-rd, 'LineWidth',1.4);
    yline(-3,'--','-3 dB');
    grid on; box on;
    xlabel('Frequency (MHz)');
    ylabel('Channel 1 relative transfer magnitude (dB)');
    legend('FAST AAF','DUAL AAF','Location','best');
    title('Post-layout AFE mode comparison');

    exportgraphics(fig, fullfile(outDir,'AFE_FAST_vs_DUAL_CH1.png'), ...
        'Resolution',300);
    close(fig);
end
end

function plot_afe_transients(trDir, outDir)
files = dir(fullfile(trDir, '*.csv'));

for k = 1:numel(files)
    T = readtable(fullfile(files(k).folder,files(k).name), ...
        'VariableNamingRule','preserve');

    if width(T) < 5
        continue;
    end

    t = numeric_column(T,1);
    fda = numeric_column(T,2);
    adc = numeric_column(T,3);
    fdaCM = numeric_column(T,4);
    adcCM = numeric_column(T,5);

    good = isfinite(t) & isfinite(fda) & isfinite(adc) & ...
           isfinite(fdaCM) & isfinite(adcCM);

    t=t(good); fda=fda(good); adc=adc(good);
    fdaCM=fdaCM(good); adcCM=adcCM(good);

    tag = classify_transient(files(k).name);
    [scale,unit] = time_scale(t);

    fig = figure('Visible','off','Color','w');
    plot(t*scale,fda,'LineWidth',1.2); hold on;
    plot(t*scale,adc,'LineWidth',1.2);
    grid on; box on;
    xlabel(['Time (' unit ')']);
    ylabel('Differential voltage (V)');
    legend('FDA differential output','ADC input differential','Location','best');
    title(strrep(tag,'_',' '));
    exportgraphics(fig,fullfile(outDir,['TRANSIENT_' tag '_differential.png']), ...
        'Resolution',300);
    close(fig);

    fig = figure('Visible','off','Color','w');
    plot(t*scale,fdaCM,'LineWidth',1.2); hold on;
    plot(t*scale,adcCM,'LineWidth',1.2);
    grid on; box on;
    xlabel(['Time (' unit ')']);
    ylabel('Common-mode voltage (V)');
    legend('FDA common mode','ADC input common mode','Location','best');
    title([strrep(tag,'_',' ') ' - common mode']);
    exportgraphics(fig,fullfile(outDir,['TRANSIENT_' tag '_common_mode.png']), ...
        'Resolution',300);
    close(fig);
end
end

function plot_awg(awgDir, outDir)
ac = dir(fullfile(awgDir,'*V9*AC*.csv'));
if ~isempty(ac)
    T=readtable(fullfile(ac(1).folder,ac(1).name),'VariableNamingRule','preserve');
    f=T.Frequency_Hz;
    g=T.OUT_rel_dB;
    p=T.OUT_Phase_deg;

    fig=figure('Visible','off','Color','w');
    semilogx(f/1e6,g,'LineWidth',1.4);
    yline(-3,'--','-3 dB');
    grid on; box on;
    xlabel('Frequency (MHz)');
    ylabel('BNC output relative magnitude (dB)');
    title('AWG post-layout signal-path AC response');
    exportgraphics(fig,fullfile(outDir,'AWG_postlayout_AC_response.png'),'Resolution',300);
    close(fig);

    fig=figure('Visible','off','Color','w');
    semilogx(f/1e6,p,'LineWidth',1.2);
    grid on; box on;
    xlabel('Frequency (MHz)');
    ylabel('Output phase (deg)');
    title('AWG post-layout output phase');
    exportgraphics(fig,fullfile(outDir,'AWG_postlayout_phase.png'),'Resolution',300);
    close(fig);
end

tr = dir(fullfile(awgDir,'*V8*.csv'));
if ~isempty(tr)
    T=readtable(fullfile(tr(1).folder,tr(1).name),'VariableNamingRule','preserve');
    t=T.Time_s;
    out=T.OUT_V;
    op=T.OP_OUT_V;

    [scale,unit]=time_scale(t);

    fig=figure('Visible','off','Color','w');
    plot(t*scale,out,'LineWidth',1.3);
    grid on; box on;
    xlabel(['Time (' unit ')']);
    ylabel('50 Ohm BNC output voltage (V)');
    title('AWG accepted 1 MHz transient');
    exportgraphics(fig,fullfile(outDir,'AWG_1MHz_BNC_transient.png'),'Resolution',300);
    close(fig);

    fig=figure('Visible','off','Color','w');
    plot(t*scale,out,'LineWidth',1.2); hold on;
    plot(t*scale,op,'LineWidth',1.2);
    grid on; box on;
    xlabel(['Time (' unit ')']);
    ylabel('Voltage (V)');
    legend('50 Ohm BNC output','Op-amp output','Location','best');
    title('AWG accepted output-stage transient');
    exportgraphics(fig,fullfile(outDir,'AWG_1MHz_output_stage.png'),'Resolution',300);
    close(fig);
end
end

function x=numeric_column(T,idx)
v=T{:,idx};
if isnumeric(v)
    x=double(v(:));
else
    x=str2double(string(v(:)));
end
end

function f=find_file(folder,needle)
d=dir(fullfile(folder,'*.csv'));
f="";
for k=1:numel(d)
    if contains(lower(d(k).name),lower(needle))
        f=string(fullfile(d(k).folder,d(k).name));
        return;
    end
end
end

function [f,g]=load_transfer(path)
T=readtable(path,'VariableNamingRule','preserve');
f=numeric_column(T,1);
g=numeric_column(T,6);
good=isfinite(f)&isfinite(g)&f>0;
f=f(good); g=g(good);
end

function tag=classify_transient(name)
switch lower(name)
    case 'trans(20260903-220723).csv'
        tag='LOW_FAST_40MHz';
    case 'trans(20260904-072702).csv'
        tag='LOW_DUAL_20MHz';
    case 'trans(20260904-074916).csv'
        tag='HIGH_DUAL_20MHz';
    case 'trans(20260904-084345).csv'
        tag='HIGH_FAST_40MHz';
    otherwise
        tag=regexprep(name,'[^A-Za-z0-9]','_');
        tag=regexprep(tag,'_csv$','');
end
end

function [s,u]=time_scale(t)
m=max(abs(t),[],'omitnan');
if m < 1e-6
    s=1e9; u='ns';
elseif m < 1e-3
    s=1e6; u='us';
elseif m < 1
    s=1e3; u='ms';
else
    s=1; u='s';
end
end
