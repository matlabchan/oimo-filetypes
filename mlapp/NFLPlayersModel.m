classdef NFLPlayersModel < handle
    
    properties(Access = public, SetObservable)
        FirstYear = 1920
        CurrentYear
        LastYear = 2014        
    end
    
    properties(GetAccess = public, Dependent)
        CurrentYearData;
    end    
    
    properties(Access = private)
        Data
    end
    
    methods
        function mdl = NFLPlayersModel
            mdl.Data = load('NFLPlayersData.mat');
            mdl.FirstYear = str2double(mdl.Data.nflplayers.Properties.RowNames{1});
            mdl.CurrentYear = mdl.FirstYear;
            mdl.LastYear = str2double(mdl.Data.nflplayers.Properties.RowNames{end});
        end
        
        function nextYear(mdl)
            if mdl.CurrentYear < mdl.LastYear
                mdl.CurrentYear = mdl.CurrentYear + 1;
            else
                mdl.CurrentYear = mdl.FirstYear;
            end                     
        end
        
        function d = get.CurrentYearData(mdl)
            d = mdl.Data.nflplayers(num2str(mdl.CurrentYear), :);
            nonZeroIndx = d.Percent>0;
            d.Weight = d.Weight(nonZeroIndx);
            d.Height = d.Height(nonZeroIndx);
            d.Percent = d.Percent(nonZeroIndx);
        end
        
    end
    
end

