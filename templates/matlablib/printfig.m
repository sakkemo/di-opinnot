function [] = printfig(format, filename)
%PRINTFIG Summary of this function goes here
%   Detailed explanation goes here
%ti = get(gca,'TightInset');
%set(gca, 'Position',[ti(1) ti(2) 1-ti(1)-ti(3) 1-ti(2)-ti(4)])

if strcmp(format, 'png')
    print('-painters', '-dpng' , filename)
elseif strcmp(format, 'pdf')
    print('-dpdf', '-r300', filename)
end
end

