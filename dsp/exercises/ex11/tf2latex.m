function [tftxt, tftex, frtxt, frtex, dtxt, dtex] = tf2latex(B,A)
% TF2LATEX prints transfer function of causal LTI filters
%
%   [tftext, tflatex, frtext, frlatex, difftext, difflatex] = tf2latex(B,A)
%
%    tftxt       H(z) as text
%    tftex       H(z) as LaTeX code
%    frtxt       H(e^jw) as text
%    frtex       H(e^jw) as LaTeX code
%    dtxt        difference eq. as text
%    dtex        difference eq. as LaTeX code
%    B           numerator polynomial of H(z)
%    A           denominator polynomial of H(z)
%
% Example:
%    B = [1 0 0 1];
%    A = [1 -0.5];
%    figure(1); freqz(B, A);
%    figure(2); zplane(B, A);
%    tf2latex(B, A)
%    [tftxt, tftex, frtxt, frtex, dtxt, dtex] = tf2latex(B, A)
%
% Jukka Parviainen, 5.2.2008 / 14.2.2006 / 5.1.2006 / 30.1.2004

if (A(1) ~= 1)
  error('A must be a vector beginning with 1');
end;

%%%%%%%%%%%%%%%%%%%%%%%%
% Numerator .. x[n-k]

Bstr = num2str(B(1));
Btex = num2str(B(1));
Hstr = num2str(B(1));
Htex = num2str(B(1));
if (B(1) == 1)
  Xstr = [' x[n]'];
elseif(B(1) == -1)
  Xstr = [' -x[n]'];
else
  Xstr = [num2str(B(1)) ' x[n]'];
end;

for k=2:length(B)
  tmp = B(k);
  if (tmp == 1)
    Bstr = [Bstr ' + z^(-' , num2str(k-1), ')'];
    Btex = [Btex ' + z^{-' , num2str(k-1), '}'];
    Xstr = [Xstr ' + x[n-' , num2str(k-1), ']'];
    Hstr = [Hstr ' + e^(-j' , num2str(k-1), 'w)'];
    Htex = [Hstr ' + e^{-j ' , num2str(k-1), ' \omega)'];
  elseif (tmp == -1)
    Bstr = [Bstr ' - z^(-' , num2str(k-1), ')'];
    Btex = [Btex ' - z^{-' , num2str(k-1), '}'];
    Xstr = [Xstr ' - x[n-' , num2str(k-1), ']'];
    Hstr = [Hstr ' - e^(-j' , num2str(k-1), 'w)'];
    Htex = [Htex ' - e^{-j ' , num2str(k-1), ' \omega}'];
  elseif (tmp == 0)
    % skip
    % ... or alternatively tmp>=0 ...?
  elseif (tmp > 0)
    Bstr = [Bstr ' + ', num2str(tmp), ' z^(-' , num2str(k-1), ')'];
    Btex = [Btex ' + ', num2str(tmp), ' z^{-' , num2str(k-1), '}'];
    Xstr = [Xstr ' + ', num2str(tmp), ' x[n-' , num2str(k-1), ']'];
    Hstr = [Hstr ' + ', num2str(tmp), ' e^(-j' , num2str(k-1), 'w)'];
    Htex = [Htex ' + ', num2str(tmp), ' e^{-j ' , num2str(k-1), ' \omega}'];
  else
    Bstr = [Bstr ' - ', num2str(abs(tmp)), ' z^(-' , num2str(k-1), ')'];
    Btex = [Btex ' - ', num2str(abs(tmp)), ' z^{-' , num2str(k-1), '}'];
    Xstr = [Xstr ' - ', num2str(abs(tmp)), ' x[n-' , num2str(k-1), ']'];
    Hstr = [Hstr ' - ', num2str(tmp), ' e^(-j' , num2str(k-1), 'w)'];
    Htex = [Htex ' - ', num2str(tmp), ' e^{-j ' , num2str(k-1), ' \omega}'];
  end
end;


%%%%%%%%%%%%%%%%%%%%%%%%
% Denominator .. y[n-k]

Astr = num2str(A(1));
Atex = num2str(A(1));
Fstr = num2str(A(1));
Ftex = num2str(A(1));
if (A(1)==1)
  Ystr = ['y[n]'];
elseif (A(1)==-1)
  Ystr = ['-y[n]'];
else
  Ystr = [num2str(A(1)) ' y[n]'];
end;

for k=2:length(A)
  tmp = A(k);
  if (tmp == 1)
    Astr = [Astr ' + z^(-' , num2str(k-1), ')'];
    Atex = [Atex ' + z^{-' , num2str(k-1), '}'];
    Ystr = [Ystr ' + y[n-' , num2str(k-1), ']'];
    Fstr = [Fstr ' + e^(-j' , num2str(k-1), 'w)'];
    Ftex = [Ftex ' + e^{-j ' , num2str(k-1), ' \omega}'];
  elseif (tmp == -1)
    Astr = [Astr ' - z^(-' , num2str(k-1), ')'];
    Atex = [Atex ' - z^{-' , num2str(k-1), '}'];
    Ystr = [Ystr ' - y[n-' , num2str(k-1), ']'];
    Fstr = [Fstr ' - e^(-j' , num2str(k-1), 'w)'];
    Ftex = [Ftex ' - e^{-j ' , num2str(k-1), ' \omega}'];
  elseif (tmp == 0)
    % skip
    % ... or alternatively tmp>=0 ...?
  elseif (tmp > 0)
    Astr = [Astr ' + ', num2str(tmp), ' z^(-' , num2str(k-1), ')'];
    Atex = [Atex ' + ', num2str(tmp), ' z^{-' , num2str(k-1), '}'];
    Ystr = [Ystr ' + ', num2str(tmp), ' y[n-' , num2str(k-1), ']'];
    Fstr = [Fstr ' + ', num2str(tmp), ' e^(-j' , num2str(k-1), 'w)'];
    Ftex = [Ftex ' + ', num2str(tmp), ' e^{-j ' , num2str(k-1), ' \omega}'];
  else
    Astr = [Astr ' - ', num2str(abs(tmp)), ' z^(-' , num2str(k-1), ')'];
    Atex = [Atex ' - ', num2str(abs(tmp)), ' z^{-' , num2str(k-1), '}'];
    Ystr = [Ystr ' - ', num2str(abs(tmp)), ' y[n-' , num2str(k-1), ']'];
    Fstr = [Fstr ' - ', num2str(tmp), ' e^(-j' , num2str(k-1), 'w)'];
    Ftex = [Ftex ' - ', num2str(tmp), ' e^{-j ' , num2str(k-1), ' \omega}'];
  end
end;

%%%%%%%%%%%%%%%%%%%%%%%%
% Transfer function as text

Apit = length(Astr);
Bpit = length(Bstr);
vpit = max(Apit, Bpit) + 4;
spit = round(abs(Apit-Bpit)/2);
if vpit > 60
  vpit = 60;
  spit = 2;
end;
Vstr = repmat('-',1,vpit);
Sstr = repmat(' ',1,spit);
if Apit > Bpit
  Bstr = [Sstr Bstr Sstr];
else
  Astr = [Sstr Astr Sstr];
end;

row1 = ['          ' Bstr];
row2 = [' H(z) = ' Vstr];
row3 = ['          ' Astr];

% Some troubles with length of each row,
% probably when computing spit.
% Fix with 'brute force' :(

len1 = length(row1);
len2 = length(row2);
len3 = length(row3);
maxlen = max([len1 len2 len3]);

row1 = [row1 repmat(' ', 1, maxlen)];
row2 = [row2 repmat(' ', 1, maxlen)];
row3 = [row3 repmat(' ', 1, maxlen)];

row1 = row1(1,1:maxlen);
row2 = row2(1,1:maxlen);
row3 = row3(1,1:maxlen);

% Now all three rows are of equal length

tftxt(1,:) = row1;
tftxt(2,:) = row2;
tftxt(3,:) = row3;

%%%%%%%%%%%%%%%%%%%%%%%%
% Fr. response as text

frtxt = 'not implemented';

%%%%%%%%%%%%%%%%%%%%%%%%
% Fr. response as LaTeX code

frtex = ['$H(e^{j\omega}) = \frac{' Htex '}{' Ftex '}$'];

%%%%%%%%%%%%%%%%%%%%%%%%
% Difference equation as text

DiffStr = [Ystr ' = ' Xstr];
dtxt = DiffStr;

%%%%%%%%%%%%%%%%%%%%%%%%
% Difference equation as LaTeX code

dtex = ['$' DiffStr '$'];

%%%%%%%%%%%%%%%%%%%%%%%%
% Transfer function as LaTeX code

if (length(A) > 1)
  % IIR
  tftex = ['$H(z) = \frac{' Btex '}{' Atex '}$'];
else
  % FIR
  if (A == 1)
    tftex = ['$H(z) = ' Btex '$'];
  elseif (A == -1)
    tftex = ['$H(z) = - ' Btex '$'];    
  else
    tftex = ['$H(z) = \frac{1}{' num2str(A) '} \cdot \big( ' Btex ...
             ' \big)$'];
  end;
end;


