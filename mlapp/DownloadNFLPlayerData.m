function t = DownloadNFLPlayerData()
json = webread('http://noahveltman.com/nflplayers/bins.json');
dd = structfun(@(d)struct('Height', [d.h], 'Weight', [d.w], 'Percent', [d.pct]), json);
t = struct2table(dd);
t.Properties.RowNames = arrayfun(@(y)num2str(y), 1920:2014, 'uni', false);