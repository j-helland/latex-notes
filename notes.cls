% notes.sty
% 		Custom notes environment including some math notation conveniences, pretty section dividers, and pretty theorem/proof environments
% 2/25/2020 Jon Helland

% --- Class structure: identification part
% ---
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2/25/2020 v1.00 Convenient Notes]

% --- Class structure: declaration of options
% ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% --- Class structure: execution of options
% ---
\ProcessOptions \relax

% --- Class structure: declaration of options
% ---
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[top=1in, bottom=1in, left=1.25in, right=1.25in]{geometry}  % set margins
\RequirePackage{indentfirst}  % allow first paragraph in new section to be indented by default
\RequirePackage{graphicx}
\RequirePackage[dvipsnames]{xcolor}  % allow custom color definitions
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathtools}  % allow for alignment in matrix environments e.g. \begin{matrix*}[r]
\RequirePackage{subfig}  % \subfloat in figures
\RequirePackage{hyperref}  % clickable references

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Math notation:
% - shorthand for commands that are tedious
% - attempts to make math code more readable
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% font macros
\newcommand{\bm}[1]{\boldsymbol{#1}}
\newcommand{\mb}[1]{\mathbb{#1}}
\newcommand{\mc}[1]{\mathcal{#1}}
\newcommand{\tensor}[1]{\boldsymbol{\mathcal{#1}}}

% probability
\newcommand{\given}{\,\vert\,}
\newcommand{\expectation}{\mathbb{E}}
\newcommand{\prob}{\mathbb{P}}

% sets
\newcommand{\st}{\,:\,}
\newcommand{\set}[1]{\left\{ #1 \right\}}
\newcommand{\conv}{\text{conv}}
\newcommand{\real}{\mathbb{R}}
\newcommand{\complex}{\mathbb{C}}
\newcommand{\range}{\text{range}}
\newcommand{\supp}{\text{supp}}

% operators
\newcommand{\trace}{\text{tr}}
\renewcommand{\vec}{\text{vec}}
\newcommand{\diag}{\text{diag}}
\newcommand{\rank}{\text{rank}}
\newcommand{\herm}{{\text{H}}}
\newcommand{\sign}{\text{sign}}
\newcommand{\dnorm}[1]{\left\Vert #1 \right\Vert}
\newcommand{\norm}[1]{\Vert #1 \Vert}
\renewcommand{\Re}[1]{\text{Re}\left\{ #1 \right\}}
\renewcommand{\Im}[1]{\text{Im}\left\{#1\right\}}
\newcommand{\toep}{\text{Toep}}
\newcommand{\var}{\mb{V}\text{ar}}
\renewcommand{\outer}{\circledcirc}

% optimization
\DeclareMathOperator*{\argmin}{\text{argmin}}
\DeclareMathOperator*{\argmax}{\text{argmax}}
\DeclareMathOperator*{\minimize}{\text{minimize}}
\DeclareMathOperator*{\maximize}{\text{maximize}}
\newcommand{\subjectto}{\text{subject to}}

% miscellaneous macros
\renewcommand{\hat}[1]{\widehat{#1}}  % there has literally never been a time when I want the non-wide version
\renewcommand{\tilde}[1]{\widetilde{#1}}
\newcommand\numberthis{\addtocounter{equation}{1}\tag{\theequation}}	% used to label specific line in align*

% special overset arc: use as \arc{...}
\makeatletter
\DeclareFontFamily{U}{tipa}{}
\DeclareFontShape{U}{tipa}{m}{n}{<->tipa10}{}
\newcommand{\arc@char}{{\usefont{U}{tipa}{m}{n}\symbol{62}}}
\newcommand{\arc}[1]{\mathpalette\arc@arc{#1}}
\newcommand{\arc@arc}[2]{
	\sbox0{$\m@th#1#2$}
	\vbox{
		\hbox{\resizebox{\wd0}{\height}{\arc@char}}
		\nointerlineskip
		\box0
	}
}
\makeatother

% notation for restriction
\newcommand\restr[2]{{ % we make the whole thing an ordinary symbol
  \left.\kern-\nulldelimiterspace % automatically resize the bar with \right
  #1 % the function
  \vphantom{\big|} % pretend it's a little taller at normal size
  \right|_{#2} % this is the delimiter
}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Custom color definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{notes_gray}{RGB}{243,243,244}
\definecolor{notes_blue}{HTML}{2C3E50}
\definecolor{notes_red}{HTML}{E74C3C}
\definecolor{notes_turquoise}{HTML}{1F8A70}
\definecolor{notes_green}{HTML}{BEDB39}
\definecolor{notes_yellow}{HTML}{FFD34E}
\definecolor{notes_orange}{HTML}{FD7400}
\definecolor{notes_babyblue}{HTML}{3498DB}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create boxed theorem environments with 
% pretty colors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[many]{tcolorbox}  % for special theorem/proof environments

\tcbuselibrary{theorems}  % associated with tcolorbox package

\newtcbtheorem[number within=section]{theorem}{Theorem}%
{colback=notes_babyblue!5,colframe=notes_babyblue!35!black,fonttitle=\bfseries}{theorem}

\newtcbtheorem[number within=section]{lemma}{Lemma}%
{colback=notes_green!5,colframe=notes_green!35!black,fonttitle=\bfseries}{lemma}

\newtcbtheorem[number within=section]{proposition}{Proposition}%
{colback=notes_red!5,colframe=notes_red!35!black,fonttitle=\bfseries}{proposition}

\newtcbtheorem[number within=section]{definition}{Definition}%
{colback=black!5, colframe=black!35!black, fonttitle=\bfseries}{definition}

\newtcbtheorem[number within=section]{corollary}{Corollary}%
{colback=orange!5, colframe=orange!35!black, fonttitle=\bfseries}{corollary}

\newtcbtheorem[number within=section]{conjecture}{Conjecture}%
{colback=magenta!3, colframe=magenta!80!black, fonttitle=\bfseries}{conjecture}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Special proof environment that draws a line
% down the lhs to clearly differentiate between
% proof and not proof content.
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tcolorboxenvironment{proof}{
  blanker,
  before skip=\topsep,
  after skip=\topsep,
  borderline west={0.4pt}{0.4pt}{black},
  breakable,
  left=12pt,
  right=12pt,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Redefine section headers to look fancy
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{tikz}  % used for redefining section headers
\RequirePackage[explicit,calcwidth]{titlesec}  % \titleformat

\titleformat{\section}
  {\addtolength{\titlewidth}{4pc}\Large\bfseries}
  {\llap{\colorbox{notes_gray!1500}{\parbox{2cm}{\strut\color{white}\hfill\thesection}}\hspace{50pt}}}
  {0em}{#1}
  [{\titleline*[l]{\hspace*{\dimexpr-3cm-20pt-2\fboxsep\relax}\color{notes_gray!1500}\titlerule[1.5pt]}}]
  
\titleformat{\subsection}
  {\addtolength{\titlewidth}{2pc}\large\bfseries}
  {\llap{\colorbox{notes_gray!1500}{\parbox{2cm}{\strut\color{white}\hfill\thesubsection}}\hspace{50pt}}}
  {0em}{#1}
  [{\titleline*[l]{\hspace*{\dimexpr-3cm-20pt-2\fboxsep\relax}\color{notes_gray!1500}\titlerule[1.5pt]}}]
  
\titleformat{\subsubsection}
	{\addtolength{\titlewidth}{1pc}\bfseries}
	{\llap{\colorbox{notes_gray!1500}{\parbox{2cm}{\strut\color{white}\hfill\thesubsubsection}}\hspace{50pt}}}
	{0em}{#1}
	[{\titleline*[l]{\hspace*{\dimexpr-3cm-20pt-2\fboxsep\relax}\color{notes_gray!1500}\titlerule[1.5pt]}}]

\usetikzlibrary{calc}
\pagestyle{plain}

\newcounter{chapshift}
\addtocounter{chapshift}{-1}

\newcommand\BoxColor{black}

\def\subsectiontitle{}
\renewcommand{\sectionmark}[1]{\markright{\sffamily\normalsize#1}{}}
\renewcommand{\subsectionmark}[1]{\def\subsectiontitle{#1}}

\makeatletter
\renewcommand{\cleardoublepage}{
\clearpage\ifodd\c@page\else
\hbox{}
\vspace*{\fill}
\thispagestyle{empty}
\newpage
\fi}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% misc config
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Increase paragraph indentation
\setlength\parindent{1cm}
\raggedbottom

