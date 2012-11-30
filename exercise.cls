\ProvidesClass{exercise}[2012/10/11 v 1.0 Exercise class]

\newif\ifsol
\solfalse
\DeclareOption{solutions}{\soltrue}
\ProcessOptions\relax

%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
%\ProcessOptions\relax
\LoadClass[10pt,a4]{article}

\RequirePackage[english]{babel}
\RequirePackage[latin1]{inputenc}
\RequirePackage{subfig}
\RequirePackage{epsfig}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{color}
\RequirePackage{etoolbox}
\RequirePackage{environ}
\RequirePackage{tikz}
\RequirePackage{psfrag}

% \newtoggle{solutions}
% \ifsol
%   \toggletrue{solutions}
% \else
%   \togglefalse{solutions}
% \fi

\parindent 0mm
\textwidth 16cm
\textheight 23cm
\oddsidemargin 0cm
\evensidemargin 0cm
\topmargin -10mm

% \newcommand{\vect}[1]{{\bf{#1}}}
% \newcommand{\svect}[1]{\boldsymbol{#1}}
% \newcommand{\matr}[1]{\boldsymbol{#1}}


\pagestyle{empty}

% Title formatting
\RequirePackage{titling}
\pretitle{\bf \Large}
\posttitle{\\}
\preauthor{}
\postauthor{\\ \\}
\predate{\bf \large}
\postdate{}



% Solution environment
\NewEnviron{solution}{
  \ifsol\expandafter
  \nopagebreak
  \hrulefill
  
  \BODY\vspace{1cm}\fi
}


\endinput
