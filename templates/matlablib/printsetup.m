function [] = printsetup(size)
%PRINTSETUP Summary of this function goes here
%   Detailed explanation goes here
if nargin==0
    size=[10 10];
end
%figure('visible','off'); clf; % open/activate Fig. 2, and clear it
set(gcf,'DefaultLineLineWidth',1)
set(gcf,'DefaultAxesFontSize',8)
set(gcf,'DefaultTextFontSize',8)
set(gcf,'units','centimeters');
set(gcf,'paperunits', get(gcf,'units'))
set(gcf,'PaperSize', [size(1) size(2)])
set(gcf,'PaperPosition',[0 0 size(1) size(2)]) % this line sets the borders of the figure in size of 6cm x 6cm
set(gcf,'Position',[0 0   size(1) size(2)])   % this line sets the figure in size of 6cm x 6cm


end

