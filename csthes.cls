%
% This is file 'csthes.cls'
%
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csthes}

\RequirePackage{ifthen}

% Defaults / Base commands for options
\newcommand*{\@dateprefix}{}
\newcommand*{\selectedlanguage}{}
\newcommand*{\selectedtype}{}
\newcommand*{\babellanguage}{}
\newboolean{isThesis}
\setboolean{isThesis}{true}

% Declaring Options
\DeclareOption{draft}{%
	\renewcommand*{\@dateprefix}{\dateprefix\ }%
	\PassOptionsToClass{draft}{report}%
}
\DeclareOption{final}{%
	\renewcommand*{\@dateprefix}{\relax}%
	\PassOptionsToClass{final}{report}%
}
\DeclareOption{german}{%
	\renewcommand*{\selectedlanguage}{de}
	\PassOptionsToClass{ngerman}{report}%
	\renewcommand*{\babellanguage}{ngerman}%explicitly here as above command doesn't provide global option
}
\DeclareOption{english}{%
	\renewcommand*{\selectedlanguage}{en}
	\PassOptionsToClass{english}{report}%
	\renewcommand*{\babellanguage}{english}%explicitly here as above command doesn't provide global option
}
\DeclareOption{thesis}{%
	\renewcommand*{\selectedtype}{thesis}%
	\setboolean{isThesis}{true}
}
\ExecuteOptions{final,english,thesis}
\ProcessOptions\relax

\PassOptionsToPackage{final}{hyperref}% Always use hyperlinks

% Load base class 

% For onesided printing uncomment next command
\LoadClass[11pt,a4paper, oneside]{report}
% For twosided printing comment next command
%\LoadClass[10pt,a4paper,twoside, openright]{report}

% Load required Packages
\RequirePackage[\babellanguage]{babel}
\RequirePackage{natbib}
\RequirePackage{fancyhdr}
\RequirePackage[OT1]{fontenc}

% Define pagestyles
\fancypagestyle{plain}{
	\fancyhead{}% clear all header fields
	\fancyfoot{}% clear all footer fields
	\fancyfoot[C]{\thepage}%
	\renewcommand{\headrulewidth}{0pt}%
	\renewcommand{\footrulewidth}{0pt}%
}
\fancypagestyle{default}{
	\fancyhead{}% clear all header fields
	%\fancyhead[L]{\leftmark}
	%\fancyhead[R]{\rightmark}
	\fancyfoot{}% clear all footer fields
    \fancyfoot[C]{\thepage}%
	\renewcommand{\headrulewidth}{0.2pt}%
	\renewcommand{\footrulewidth}{0pt}%
}
\fancypagestyle{blank}{
	\fancyhead{}% clear all header fields
	\fancyfoot{}% clear all footer fields
	\renewcommand{\headrulewidth}{0pt}%
	\renewcommand{\footrulewidth}{0pt}%
}

% Use blank pagestyle for empty pages inserted by \cleardoublepage
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \thispagestyle{blank}\hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\widowpenalty=10000
\clubpenalty=10000

% Define commands for title page

\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\@subtitle}{\relax}
\newcommand*{\setthesistype}[1]{\renewcommand*{\thesistype}{#1}}
\newcommand*{\thesistype}{\@latex@warning@no@line{No \protect\thesistype\space given}Enter the thesis type!}
\newcommand*{\thesistitle}{\@latex@warning@no@line{No \protect\thesistitle\space given}Enter Bachelor Thesis or Master Thesis!}
\newcommand*{\degree}[1]{\renewcommand*{\@degree}{#1}}
\newcommand*{\@degree}{\@latex@warning@no@line{No \protect\semester\space given}Enter the degree!}
\newcommand*{\supervisor}[1]{\renewcommand*{\@supervisor}{#1}}
\newcommand*{\@supervisor}{\@latex@warning@no@line{No \protect\supervisor\space given}Enter the supervisor!}

\newcommand*{\@@date}{\@dateprefix\@date}
\newcommand{\@matr@error}{\@latex@warning@no@line{No \protect\matr\space given}Enter your matriculation number!}

\renewcommand\maketitle{\newpage%
  \let\oldand\and
  \renewcommand{\and}{\@matr\renewcommand{\@matr}{\@matr@error}\\}
  \newcommand{\@matr}{\@matr@error}
  \newcommand{\matr}[1]{\renewcommand*{\@matr}{\unskip{} (\matriculationnumbername ~##1)}}
  \thispagestyle{empty}
  \setcounter{page}\@ne
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \begin{center}
    \vspace*{.02\textheight}
    \includegraphics[width=35mm]{images/logos/uni_siegen_logo.png}
  \end{center}
  \null\vfil  
  
%  \vskip 15\p@
  \begin{center}%
    {\Huge \@title \par}%
    {\huge \@subtitle \par}%
    \vskip 2.5em%
	{\Large \textsc{\thesistype} \textsc{Thesis} }%
	\vskip 2.5em%
	{\Large \textsc{\@degree} \par}  
	\vskip 0.5em%
	\Large
  	\faculty   
  	\vskip 0.5em%
  	{\Large \university{}} 
  	\vskip 0.5em%
    {\Large \@author \@matr \par}% 
    \vskip 2.5em%
    {\large \@@date \par}%       % Set date in \large size.
  \vfil
  {\large \supervisortext : \@supervisor}
  % TODO: Add cooperation partners here
  \end{center}\par
  \newpage
  \thispagestyle{empty}
  \vfil
  \hbox{}\@thanks
  \vfil
  \newpage
  \setcounter{page}\@ne
  \setcounter{footnote}{0}%
  \pagenumbering{roman}% use roman numbering after title
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \let\and\oldand
}

% Define structuring commands
\newcommand{\mainmatter}{%
  \cleardoublepage%
  \pagenumbering{arabic}%
  \pagestyle{default}%
  \setcounter{page}{1}%
}


% Language definitions
\newcommand*{\worktitlename}{\csname worktitlename@\selectedtype @\selectedlanguage\endcsname}
\newcommand*{\matriculationnumbername}{\csname matriculationnumbername@\selectedlanguage\endcsname}
\newcommand*{\indegreename}{\csname insemestername@\selectedlanguage\endcsname}
\newcommand*{\dateprefix}{\csname dateprefix@\selectedlanguage\endcsname}
\newcommand*{\facultyat}{\csname facultyat@\selectedlanguage\endcsname}
\newcommand*{\faculty}{\csname faculty@\selectedlanguage\endcsname}
\newcommand*{\facultyof}{\csname facultyof@\selectedlanguage\endcsname}
\newcommand*{\university}{\csname university@\selectedlanguage\endcsname}
\newcommand*{\supervisortext}{\csname supervisortext@\selectedlanguage\endcsname}

\newcommand*{\worktitlename@thesis@de}{Thesis English}
\newcommand*{\matriculationnumbername@de}{Matr.\,Nr.}
\newcommand*{\insemestername@de}{aus dem}
\newcommand*{\dateprefix@de}{Entwurf vom}
\newcommand*{\facultyat@de}{an der}
\newcommand*{\faculty@de}{Fakult\"at IV}
\newcommand*{\facultyof@de}{der}
\newcommand*{\university@de}{Universit\"at Siegen}
\newcommand*{\supervisortext@de}{Betreuer}



\newcommand*{\worktitlename@thesis@en}{Thesis English}
\newcommand*{\matriculationnumbername@en}{Matr.\,No.}
\newcommand*{\indegreename@en}{in}
\newcommand*{\dateprefix@en}{Draft of}
\newcommand*{\facultyat@en}{at}
\newcommand*{\faculty@en}{Carl Zeiss AG, Jena, \\ 
                        Corporate Research Department (CRT) \\ 
                        and \\
                        Department of Mechatronics\\ 
                        Naturwissenschaftlich-Technische Fakult\"at}
\newcommand*{\facultyof@en}{of}
\newcommand*{\university@en}{Universit\"at Siegen}
\newcommand*{\supervisortext@en}{Supervisors}

% Bibliography
\let\oldbibliography\bibliography
\renewcommand*{\bibliography}[1]{\oldbibliography{#1}\addcontentsline{toc}{chapter}{\bibname}}

% Use defaults
\pagestyle{default}
\bibliographystyle{apalike}
