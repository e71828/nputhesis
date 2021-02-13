%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Huangrui Mo <huangrui.mo@gmail.com> 
%- Modified by a npuer <740943170@qq.com>.
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{Style/nputhesis}[2014/10/01 v1.0 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\DeclareOption{singlesided}{% enable single-sided printing
    \PassOptionsToClass{oneside}{ctexbook}%
}
\DeclareOption{doublesided}{% enable double-sided printing
    \PassOptionsToClass{twoside}{ctexbook}%
}
\newif\ifnpu@printcopy \npu@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
%    \PassOptionsToClass{twoside}{ctexbook}%
    \npu@printcopytrue%
}
%-
%-> Language
%-
\newif\ifnpu@plain \npu@plainfalse
\DeclareOption{scheme=plain}{% enable plain writing style
    \PassOptionsToClass{scheme=plain}{ctexbook}%
    \npu@plaintrue%
}
%-
%-> Degree
%-
\newif\ifnpu@Bachelor \npu@Bachelorfalse
\newif\ifnpu@Master \npu@Masterfalse
\newif\ifnpu@Doctor \npu@Doctorfalse
\DeclareOption{Bachelor}{% enable Bachelor style
	\npu@Bachelortrue%
	\npu@Masterfalse%
	\npu@Doctorfalse
}
\DeclareOption{Master}{% enable Master style
	\npu@Bachelorfalse%
	\npu@Mastertrue%
	\npu@Doctorfalse
}
\DeclareOption{Doctor}{% enable Doctor style
	\npu@Bachelorfalse%
	\npu@Masterfalse%
	\npu@Doctortrue
}
%-
%-> Draft version info
%-
\newif\ifnpu@versioninfo \npu@versioninfofalse
\DeclareOption{draftversion}{%
    \npu@versioninfotrue%
}
%-
%-
%-> Header and footer
%-
\newif\ifnpu@xhf \npu@xhftrue  %true mean false, i.e. not close header and footer
\DeclareOption{xhf}{%
	\npu@xhffalse
}
%-
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\LoadClass[UTF8,a4paper,zihao=-4]{ctexbook}
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{etoolbox}% a toolbox of programming facilities
\RequirePackage{xstring}%  Ce fichier contient le code de l'extension "xstring"
\RequirePackage{datetime}% change fromat of date
\newcommand{\npuifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\npuifstrbk}{\expandafter\ifblank\expandafter}% expansion control
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn
\newcommand{\npulntotab}[2][1pt]{% convert lines into table lines
    \seq_set_split:NnV \l_tmpa_seq {\\} {#2}
    \clist_set_from_seq:NN \l_tmpa_clist \l_tmpa_seq
    \clist_clear:N \l_tmpb_clist
    \clist_map_inline:Nn \l_tmpa_clist
      {%
        \clist_put_right:Nn \l_tmpb_clist 
          { \ulenhance[#1]{\ulextend{##1}} }
      }
    %\clist_show:N\l_tmpb_clist% show the content of comma list
    \clist_use:Nn \l_tmpb_clist { \\ & }
}
\ExplSyntaxOff
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/nputhesis.cfg}{}{}
    \makeatother
}
\AtBeginDocument{
	  \DeclareSymbolFont{AMSb}{U}{msb}{m}{n}
	  \DeclareSymbolFontAlphabet{\mathbb}{AMSb}
	  \setmathfontface\mathit{XITS-Italic.otf}
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
	\setlength{\textwidth}{146.6mm}% set required text width first
	\setlength{\hoffset}{0mm}% set horizontal offset
	\ifnpu@printcopy% if print copy layout enabled
		\setlength{\oddsidemargin}{12.6mm}% binding side margin
		\setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
	\else
		\setlength{\oddsidemargin}{6.3mm}% left side margin
		\setlength{\evensidemargin}{6.3mm}% ensure uniform left side width for EThesis
	\fi
\ifnpu@Bachelor
{}
\else
	\setlength{\textwidth}{160mm}% set required text width first
	\setlength{\hoffset}{0mm}% set horizontal offset
	\ifnpu@printcopy% if print copy layout enabled
	    \setlength{\oddsidemargin}{0mm}% binding side margin
	    \setlength{\evensidemargin}{-0.8mm}% ensure uniform binding side width for printing
	\else
	    \setlength{\oddsidemargin}{-0.4mm}% left side margin
	    \setlength{\evensidemargin}{-0.4mm}% ensure uniform left side width for EThesis
	\fi
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{246.2mm}% set required text height first
\setlength{\voffset}{0mm}% set vertical offset = 17.4 =(20+12+17.5)/2.845=17.4
\setlength{\topmargin}{-10.4mm}% vertical margin above header
\setlength{\headheight}{19.2pt}% header height +7.2 for logo
\setlength{\headsep}{10.3pt}% vertical margin between header and body text -7.2 for logo
\setlength{\footskip}{23.3pt}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.25}\selectfont% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex% use underline from xeCJKfntef
	%	\RequirePackage{CJKulem}
\else% use underline from ulem
    \RequirePackage{ulem}%
\fi
\newcommand{\ulunify}[1]{\uline{#1}}% unified name
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \setlength{\ULdepth}{5pt}% set depth
    \expandafter\ulunify\expandafter{#2}% linebreak fix
}
\newcommand{\ulhshift}{-4em}% horizontal shift on underline
\newcommand{\ulextend}[2][195pt]{% extend underline length \hspace*{\ulhshift}
    \hbox to #1{\hfill#2\hfill}}
%-
%-> Detect class and counter
%-
\newcommand*{\npuifcnt}[1]{% check if counter exists
    \ifcsname c@#1\endcsname%
        \expandafter\@firstoftwo%
    \else%
        \expandafter\@secondoftwo%
    \fi
}
\npuifcnt{chapter}{\def\npumaincnt{chapter}}{\def\npumaincnt{section}}%
%-
%-> Page header and footer Style
%-
%- Page styles in Latex refers to headers and footers of a document.
%- These headers/footers typically contain document titles, chapter
%- or section numbers/names, and page numbers.
%- Configure fancy style
\ifnpu@xhf% header and footer style
	\RequirePackage{fancyhdr}% fancy headers and footers
\fi
\ifnpu@xhf% user defined header and footer style
	\RequirePackage{fancyhdr}% fancy headers and footers
	\pagestyle{fancy}%
    %- customizing headers and footers in LaTeX is a two-stage process
    %- 1) \chapter|section call \chapter|sectionmark that call \markboth|right to define \left|rightmark
    %-    but \chapter*|section* do not call \chapter|sectionmark, then manually call \markboth|right is needed to update \left|rightmark
    %-    \markboth{here set \leftmark for chapter heading}{here set \rightmark for section heading}
    %- 2) in header/footer definition, \left|rightmark represent the current chapter and section heading
    %- original chaptermark and sectionmark for headings
    %\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{\chaptername\ \thechapter.\ #1}}{}}%
    %\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}%
    %- redefine to set mark to actual name
    %\renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{#1}}{}}%
    %\renewcommand{\sectionmark}[1]{\markright{\MakeUppercase{#1}}{}}%
	%- Deactivate uppercase effect
%	\renewcommand{\MakeUppercase}[1]{#1}%
	%- Define different kinds of header and footer for different parts
    \fancypagestyle{frontmatterstyle}{% style for frontmatter
        \fancyhf{}% clear fields
        \fancyhead[C]{\footnotesize \ifnumodd{\value{page}}{\leftmark}{\@title}}% structure elements
        \fancyfoot[C]{\footnotesize \thepage}% page number
        \renewcommand{\headrulewidth}{0.8pt}% header rule
        \renewcommand{\footrulewidth}{0pt}% footer rule
    }
    \fancypagestyle{mainmatterstyle}{% style for mainmatter
        \fancyhf{}% clear fields
        \fancyhead[C]{\footnotesize \ifnumodd{\value{page}}{\leftmark}{\@title}}% structure elements
		\fancyfoot[C]{\footnotesize \thepage}% page number
        \renewcommand{\headrulewidth}{0.8pt}% header rule
        \renewcommand{\footrulewidth}{0pt}% footer rule
    }
    \fancypagestyle{backmatterstyle}{% header and footer style for backmatter
        \fancyhf{}% clear fields
        \fancyhead[C]{\footnotesize \ifnumodd{\value{page}}{\leftmark}{\@title}}% structure elements
		\fancyfoot[C]{\footnotesize \thepage}% page number
        \renewcommand{\headrulewidth}{0.8pt}% header rule
        \renewcommand{\footrulewidth}{0pt}% footer rule
    }
	\RequirePackage[export]{adjustbox}
	\fancypagestyle{withlogo}{% header and footer style for the logo
		\fancyhf{}% clear fields
		\fancyhead[C]{\includegraphics[totalheight=18pt,valign=m]{textlogoblack}\enspace {\fontsize{16}{19.2} \bfseries{本科毕业设计论文}}}% structure elements
		\fancyfoot[C]{\footnotesize \thepage}% page number
		\renewcommand{\headrulewidth}{0.8pt}% header rule
		\renewcommand{\footrulewidth}{0pt}% footer rule
	}
	%- Redefine \frontmatter to include the change
		\providecommand{\frontmatter}{}% compatibility for non-book classes
		\let\myfrontmatter\frontmatter%
		\renewcommand{\frontmatter}{%
			\myfrontmatter%
			\ifnpu@Bachelor
				\pagestyle{withlogo}%
%				\renewcommand{\headrule}{\hrule width\headwidth height0.8pt}%
			\else
				\pagestyle{frontmatterstyle}%
				\renewcommand{\headrule}{\hrule width\headwidth height2.7pt \vspace{0.9pt} \hrule width\headwidth height0.9pt}%
			\fi
		}%head with logo for Bachelor
	%- Redefine \mainmatter to include the change
	\providecommand{\mainmatter}{}% compatibility for non-book classes
	\let\mymainmatter\mainmatter%
	\renewcommand{\mainmatter}{%
		\mymainmatter%
		\pagestyle{withlogo}%mainmatterstyle
		\if@twoside
			\fancyfoot[C]{\footnotesize \ifnumodd{\value{page}}{\hspace*{\fill}\thepage}{\thepage\hspace*{\fill}}}% page number
		\fi
	}
	%- Redefine \backmatter to include the change
	\providecommand{\backmatter}{}% compatibility for non-book classes
	\let\mybackmatter\backmatter%
	\renewcommand{\backmatter}{%
		\mybackmatter%
		\pagestyle{withlogo}%backmatterstyle
		\if@twoside
			\fancyfoot[C]{\footnotesize \ifnumodd{\value{page}}{\hspace*{\fill}\thepage}{\thepage\hspace*{\fill}}}% page number
		\fi
	}
	%- Some Latex commands, like \chapter, use the \thispagestyle command
	%- to automatically switch to the plain page style, thus ignoring the
	%- page style currently in effect. To customize such pages you must
	%- redefine the plain pagestyle. If you want the plain style inherits
	%- the current style, comment all the lines in plain style definition.
	\fancypagestyle{plain}{%
%		\fancyhf{}% clear fields
%		\renewcommand{\headrulewidth}{0pt}% header rule
%		\renewcommand{\footrulewidth}{0pt}% footer rule
	}
	\fancypagestyle{noheaderstyle}{% header and footer style for no header
        \fancyhf{}% clear fields
        %\fancyhead[C]{\footnotesize \ifnumodd{\value{page}}{\leftmark}{\@title}}% structure elements
		\if@twoside
			\fancyfoot[C]{\footnotesize \ifnumodd{\value{page}}{\hspace*{\fill}\thepage}{\thepage\hspace*{\fill}}}% page number
		\else
			\fancyfoot[C]{\footnotesize \thepage}% page number
		\fi
        \renewcommand{\headrulewidth}{0pt}% header rule
        \renewcommand{\footrulewidth}{0pt}% footer rule
	}
\fi
%---------------------------------------------------------------------------%
%->> Cover_and_Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\def\npu@value@ch@confidential{}
\newcommand{\confidential}[1]{\def\npu@value@ch@confidential{#1}}
\def\npu@value@ch@schoollogo{}
\newcommand{\schoollogo}[2]{\def\npu@value@ch@schoollogo{\includegraphics[#1]{#2}}}
\def\npu@value@ch@titleforhead{}
\newcommand{\titleforhead}[1]{\def\npu@value@ch@titleforhead{#1}}
\def\npu@value@ch@titlemark{}
\renewcommand{\title}[2][\npu@value@ch@titleforhead]{%
    \def\npu@value@ch@title{#2}
%    \def\npu@value@ch@titlemark{\MakeUppercase{#1}}}
    \def\npu@value@ch@titlemark{#1}}
\renewcommand{\@title}{\npu@value@ch@titlemark}
\def\npu@value@ch@author{}
\renewcommand{\author}[1]{\def\npu@value@ch@author{#1}}
\def\npu@value@ch@number{}
\newcommand{\IDnumber}[1]{\def\npu@value@ch@number{#1}}
\newcommand{\npu@value@ch@classification}{tn911}
\newcommand{\Chineselibraryclassification}[1]{\def\npu@value@ch@classification{\MakeUppercase{#1}}}
\def\npu@value@ch@advisor{}
\newcommand{\advisor}[1]{\long\def\npu@value@ch@advisor{#1}}
\def\npu@value@ch@advisors{}
\newcommand{\advisors}[1]{\long\def\npu@value@ch@advisors{#1}}
\def\npu@value@ch@degreetype{}
\newcommand{\degreetype}[1]{\def\npu@value@ch@degreetype{#1}}
\def\npu@value@ch@major{}
\newcommand{\major}[1]{\def\npu@value@ch@major{#1}}
\def\npu@value@ch@institute{}
\newcommand{\institute}[1]{\long\def\npu@value@ch@institute{#1}}
\def\npu@value@ch@date{}
\renewcommand{\date}[1]{\def\npu@value@ch@date{#1}}
\newcommand{\Datum}[1]{
	\StrBehind[2]{#1}{/}[\Jahr]
	\StrBetween[1,2]{#1}{/}{/}[\Monat]
	\StrBefore[1]{#1}{/}[\Tag]
	\def\npu@value@ch@date{{\upshape\Jahr}~{年}~{\upshape\Monat}~{月}~{\upshape\Tag}~{日}}
	\def\npu@value@en@date{\monthname[\Monat],\enskip \Jahr}}
%-
%-> Redefine Chinese style
%-
\newcommand{\makecover}{%
	\ifnpu@Bachelor
		\def\npu@label@ch@degree{\npu@label@ch@bacdegree}%
		\def\npu@label@en@degree{Bachelor}%
	\else
		\ifnpu@Master
			\def\npu@label@ch@degree{\npu@label@ch@masdegree}%
			\def\npu@label@en@degree{Master}%
		\else
			\def\npu@label@ch@degree{\npu@label@ch@docdegree}%
			\def\npu@label@en@degree{Doctor}%
		\fi
	\fi
	\ifnpu@Bachelor
	    \cleardoublepage
		\thispagestyle{empty}
		{
		\begin{center}
			\zihao{4}\linespread{1.0}\selectfont
			\vspace*{\stretch{9}}
		
			{\npu@value@ch@schoollogo}
			
			\vspace*{\stretch{5}}
			
			{\zihao{0}\bfseries {本科毕业设计论文}}%\npu@label@ch@thesis}}
			
			\vspace*{\stretch{15}}
			
			{\zihao{3}\sffamily {题\hspace*{0.5em}目 \ulenhance[1.0pt]{\hbox to 330pt{\hfill \npu@value@ch@titlemark\hfill }}}}
			
			\vspace*{\stretch{5}}
			
			\def\tabcolsep{1pt}
			\def\arraystretch{1.0}
			\begin{tabular}{lc}
				专业名称 & \ulenhance[0.8pt]{\ulextend{\npu@value@ch@major}}\\[36pt]
				学生姓名 & \ulenhance[0.8pt]{\ulextend{\npu@value@ch@author}}\\[36pt]
				指导教师 & \npulntotab[0.8pt]{\npu@value@ch@advisor}\\[24pt]
				毕业时间 & \ulenhance[0.8pt]{\ulextend{\npu@value@ch@date}}
			\end{tabular}
			\vspace*{\stretch{3.5}}
		\end{center}
		}
	\else
		\cleardoublepage
		\thispagestyle{empty}
		{
		\begin{center}
			\zihao{5}\bfseries\linespread{1.0}\selectfont
			    	\noindent 
			    	\def\tabcolsep{5pt}
			    	\def\arraystretch{1.2}
			\newlength{\myfirstcode} 
			\settowidth{\myfirstcode}{\hspace{10em}}
			\begin{minipage}[t]{100pt}
				{}
			\end{minipage}
			\hfill
			\begin{minipage}[t]{\myfirstcode}
%				\vspace*{0.5pt}
				\begin{tabular}{|c|c|}\hline
					\makebox[5em][s]{学校代码} & 10699\\\hline
					\makebox[5em][s]{分类号} &\npuifstrbk{\npu@value@ch@classification}{}{\npu@value@ch@classification} \\\hline
					\makebox[5em][s]{密级} &\npuifstrbk{\npu@value@ch@confidential}{}{\bfseries\npu@value@ch@confidential}\\\hline
					\makebox[5em][s]{学号}& \hspace{5pt}\npu@value@ch@number\hspace{5pt}\\\hline
				\end{tabular}
			\end{minipage}
			\vspace*{\stretch{25}}\\
			\zihao{1}
			\raisebox{25pt}{题目}
			\linespread{1.5}\selectfont
			\hspace*{-10pt}
			    \begin{minipage}[c]{300pt}
			    	\zihao{2}
					\centering\ulenhance[1.5pt]{\npu@value@ch@title}
				\end{minipage}
			\vspace*{\stretch{6}}\\
			\zihao{3}
			作者\ulenhance[1.0pt]{\ulextend[120pt]{\npu@value@ch@author}}
			\vspace*{\stretch{5}}\\
			\def\tabcolsep{1pt}
			\def\arraystretch{1.0}
			\begin{tabular}{lc}
			\makebox[6em][s]{学科、专业}&\ulenhance[1.0pt]{\ulextend[300pt]{\npu@value@ch@major}}\\
			\makebox[6em][s]{指导教师}&\ulenhance[1.0pt]{\ulextend[300pt]{\npu@value@ch@advisor}}\\
			\makebox[6em][s]{申请学位日期}&\ulenhance[1.0pt]{\ulextend[300pt]{\npu@value@ch@date}}
			\end{tabular}
			\vspace*{\stretch{5}}
		\end{center}
		}
	\fi
	\clearpage
	\if@twoside
		\thispagestyle{empty}
			\ifnpu@versioninfo
				\vspace*{\stretch{1}}
				\begin{footnotesize}
					\noindent
					Draft Version (\today)
				\end{footnotesize}
			\fi
			\cleardoublepage[empty]
	\else
		\ifnpu@versioninfo
			\thispagestyle{empty}
			\vspace*{\stretch{1}}
			\begin{footnotesize}
				\noindent
				Draft Version (\today)
			\end{footnotesize}
			\cleardoublepage[empty]
		\fi
	\fi
}
\renewcommand{\maketitle}{%
    \ifnpu@Bachelor
		\def\npu@label@ch@thesis{\npu@label@ch@bacthesis}%
		\def\npu@label@ch@major{\npu@label@ch@und@major}%
		\def\npu@label@ch@institute{\npu@label@ch@und@institute}
	\else
		\ifnpu@Master
			\def\npu@label@ch@thesis{\npu@label@ch@masthesis}%
			\def\npu@label@ch@major{\npu@label@ch@grad@major}%
			\def\npu@label@ch@institute{\npu@label@ch@grad@institute}%
		\else
			\def\npu@label@ch@thesis{\npu@label@ch@docthesis}%
			\def\npu@label@ch@major{\npu@label@ch@grad@major}%
			\def\npu@label@ch@institute{\npu@label@ch@grad@institute}%
		\fi
	\fi
    \cleardoublepage
    \thispagestyle{empty}
    {
    	\zihao{5}\linespread{1.0}\selectfont
    	\noindent 
    	\newlength{\mysecondcode} 
    	\settowidth{\mysecondcode}{学\hspace{2em}号：\quad2019300000}
	    \begin{center}
	    	\begin{minipage}[t]{100pt}
	    		{\bfseries 分类号：\quad\npuifstrbk{\npu@value@ch@classification}{}{{\npu@value@ch@classification}} \\
	    		 密\hspace{1em}级：\quad\npuifstrbk{\npu@value@ch@confidential}{}{\npu@value@ch@confidential}}
	    	\end{minipage}
	    	\hfill
	    	\begin{minipage}[t]{\mysecondcode}
	        	{\bfseries 学校代号：\bfseries\quad10699 \\ 学\hspace{2em}号：\quad\npu@value@ch@number}
	        \end{minipage}
	    	\linespread{1.5}\selectfont
		    \vspace*{\stretch{4}}\\
		    {\bfseries 
		    	{\zihao{3} 西北工业大学}\\[5pt] 
		    	{\ziju{1}\zihao{3} \npu@label@ch@thesis}\\
		    	{\zihao{4} （学位{\npu@label@ch@degree}）}}
		    \vspace*{\stretch{4}}\\
		  	\def\tabcolsep{1pt}
		    \def\arraystretch{1.0}
		    \zihao{2}\bfseries
		    \begin{tabular}{c}
		    	\npu@value@ch@title
		    \end{tabular}
			\vspace*{\stretch{4}}\\
			\def\tabcolsep{1pt}
			\def\arraystretch{1.0}
			\zihao{3}
		   	\begin{tabular}{lc}
		    	{\bfseries\makebox[4.5em][s]{作\qquad 者：}} & {\bfseries\itshape\npu@value@ch@author}\\
		    	{\bfseries\makebox[4.5em][s]{学科专业：}} & \quad{\bfseries\itshape\npu@value@ch@major}\\
		    	{\bfseries\makebox[4.5em][s]{指导教师：}} & {\bfseries\itshape\npu@value@ch@advisor}
		    	\end{tabular}
			\vspace*{\stretch{4}}\\
			{\zihao{3}\mdseries{\npu@value@ch@institute \\ \npu@value@ch@date}}
			\vspace*{\stretch{1}}
	    \end{center}
	}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifnpu@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifnpu@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
}

%-
%-> English item commands
%-
\def\npu@value@en@title{}
\newcommand{\TITLE}[1]{\def\npu@value@en@title{#1}}
\def\npu@value@en@author{}
\newcommand{\AUTHOR}[1]{\def\npu@value@en@author{#1}}
\def\npu@value@en@advisor{}
\newcommand{\ADVISOR}[1]{\def\npu@value@en@advisor{#1}}
\def\npu@value@en@degreetype{}
\newcommand{\DEGREETYPE}[1]{\def\npu@value@en@degreetype{#1}}
\def\npu@value@en@thesistype{}
\newcommand{\THESISTYPE}[1]{\def\npu@value@en@thesistype{#1}}
\def\npu@value@en@major{}
\newcommand{\MAJOR}[1]{\def\npu@value@en@major{#1}}
\def\npu@value@en@institute{}
\newcommand{\INSTITUTE}[1]{\def\npu@value@en@institute{#1}}
\def\npu@value@en@date{}
\newcommand{\DATE}[1]{\def\npu@value@en@date{#1}}
%-
%-> Redefine English style
%-
\newcommand{\MAKETITLE}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
	    \begin{center}
	        \linespread{1.2}\selectfont
	        \zihao{3}\bfseries
	
	        \vspace*{\stretch{4}}
	
	        {\zihao{-3}\bfseries \ulenhance[1.5pt]{\npu@value@en@title}}
	
	        \vspace*{\stretch{6}}
	
	        {By}
	
	        {\npu@value@en@author}\\[\baselineskip]
	        {Under the Supervision of Professor}
	        
	        {\npu@value@en@advisor}
	        
	        \vspace*{\stretch{5}}
	        
	        {\npu@label@en@statement}
	        
			\vspace*{\stretch{5}}
			
	        {\npu@value@en@institute}
	
	        \vspace*{\stretch{1}}
	
	        {\npu@value@en@date}
	
	        \vspace*{\stretch{3}}
	    \end{center}
	}
    \clearpage
    \if@twoside
      \thispagestyle{empty}
      \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> Author's declaration
%---------------------------------------------------------------------------%
\newcommand{\makedeclaration}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
        
        \zihao{-4}

        \vspace*{2ex}

        \begin{center}
            {\zihao{4}\bfseries\sffamily \npu@label@ch@declare@creativity}
        \end{center}

        {\npu@value@ch@declare@creativity}

        \vspace*{3ex}

        {\hfill{} {\npu@label@ch@declare@author \hspace*{14em}}}

        {\hfill{} {\npu@label@ch@declare@date \hspace*{14em}}}

        \vspace*{6ex}

        \begin{center}
            {\zihao{4}\bfseries\sffamily \npu@label@ch@declare@rights}
        \end{center}

        {\npu@value@ch@declare@rights}

        {\npu@value@ch@declare@rule}

        \vspace*{3ex}

        {\hfill{} {\npu@label@ch@declare@author \hspace*{10em} \npu@label@ch@declare@advisor \hspace*{9em}}}

        {\hfill{} {\npu@label@ch@declare@date \hspace*{10em} \npu@label@ch@declare@date \hspace*{9em}}}

        \vspace*{3ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> New environments
%---------------------------------------------------------------------------%
%- define chinese keywords
\ifnpu@Bachelor
	\newcommand{\keywords}[1]{%
	    \vspace{0.5\baselineskip}
	    \noindent {\bfseries\sffamily \npu@label@ch@keywords} #1}
	%- define engish keywords
	\newcommand{\KEYWORDS}[1]{%
	    \vspace{0.5\baselineskip}
	    \noindent {\bfseries \npu@label@en@keywords} #1}
\else
	\newcommand{\keywords}[1]{%
		\vspace{1.5\baselineskip}
		\noindent {\bfseries\sffamily \npu@label@ch@keywords} #1}
	%- define engish keywords
	\newcommand{\KEYWORDS}[1]{%
		\vspace{1.5\baselineskip}
		\noindent {\bfseries \npu@label@en@keywords} #1}
\fi
%---------------------------------------------------------------------------%
%->> Structure elements
%---------------------------------------------------------------------------%
\ifnpu@plain%
	 \def\contentsname{\npu@label@en@tocname}
	 \def\listfigurename{\npu@label@en@lsfigname}
	 \def\listtablename{\npu@label@en@lstabname}
	 \def\bibname{\npu@label@en@bibname}
	 \def\refname{\npu@label@en@bibname}
	 \def\algname{\npu@label@en@algname}
	 \def\bibetal{\npu@label@en@bibetal}
	 \def\biband{\npu@label@en@biband}
	 \def\axiomname{\npu@label@en@axiomname}
	 \def\theoremname{\npu@label@en@theoremname}
	 \def\lemmaname{\npu@label@en@lemmaname}
	 \def\corollaryname{\npu@label@en@corollaryname}
	 \def\assertionname{\npu@label@en@assertionname}
	 \def\propositionname{\npu@label@en@propositionname}
	 \def\conjecturename{\npu@label@en@conjecturename}
	 \def\definitionname{\npu@label@en@definitionname}
	 \def\examplename{\npu@label@en@examplename}
	 \def\remarkname{\npu@label@en@remarkname}
     \def\proofname{\npu@label@en@proofname}
\else
    \def\contentsname{\npu@label@ch@tocname}
    \def\listfigurename{\npu@label@ch@lsfigname}
    \def\listtablename{\npu@label@ch@lstabname}
    \def\algname{\npu@label@ch@algname}
    \def\bibname{\npu@label@ch@bibname}
    \def\refname{\npu@label@ch@bibname}
    \def\bibetal{\npu@label@ch@bibetal}
    \def\biband{\npu@label@ch@biband}
    \def\axiomname{\npu@label@ch@axiomname}
    \def\theoremname{\npu@label@ch@theoremname}
    \def\lemmaname{\npu@label@ch@lemmaname}
    \def\corollaryname{\npu@label@ch@corollaryname}
    \def\assertionname{\npu@label@ch@assertionname}
    \def\propositionname{\npu@label@ch@propositionname}
    \def\conjecturename{\npu@label@ch@conjecturename}
    \def\definitionname{\npu@label@ch@definitionname}
    \def\examplename{\npu@label@ch@examplename}
    \def\remarkname{\npu@label@ch@remarkname}
    \def\proofname{\npu@label@ch@proofname}
\fi
%---------------------------------------------------------------------------%
%->> Structure layout
%---------------------------------------------------------------------------%
%- chapter
\ifnpu@plain
	\ctexset {
	    chapter = {
	        format = \zihao{3}\sffamily\centering,
	        number = \arabic{chapter},
			nameformat = {},
			titleformat = {},
	        numberformat = \rmfamily,
	        aftername = \quad,
	        beforeskip = {28.8pt},
	        fixskip = true,
	        afterskip = {14.4pt},
	    }
	}
\else
	\ctexset {
		chapter = {
			format = \zihao{3}\sffamily\centering,
			number = \chinese{chapter},
			nameformat = {},
			titleformat = {},
	        %numberformat = \rmfamily,
			aftername = \quad,
			beforeskip = {28.8pt},
			fixskip = true,
			afterskip = {14.4pt},
		}
	}
\fi
%- section
\ctexset {
    section = {
        format = \zihao{4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {1.0ex},%Bachelor 0
%        fixskip = true,
        afterskip = {0pt},
    }
}
%- subsection
\ctexset {
    subsection = {
        format = \zihao{-4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {1.0ex},%Bachelor 0
%        fixskip = true,
        afterskip = {0pt},
    }
}
%- subsubsection
\ctexset {
    subsubsection = {
        format = \zihao{-4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {1.0ex},%Bachelor 0
%        fixskip = true,
        afterskip = {0pt},
    }
}
%- appendix

\ctexset {
    appendix = {
%        numbering = true|false,
%        number = \rmfamily\Alph{chapter},
    }
}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- the table of contents is specified by defining \l@chapter, \l@section, ...
%- most commands are then defined with the \@dottedtocline:
%- \@dottedtocline{⟨level⟩}{⟨indent⟩}{⟨numwidth⟩}{⟨title⟩}{⟨page⟩}
%- ⟨level⟩    an entry is produced only if ⟨level⟩ <= value of the tocdepth counter
%-            note, \chapter is level 0, \section is level 1, etc
%- ⟨indent⟩   indentation from the outer left margin of the start of the contents line
%- ⟨numwidth⟩ width of a box in which the section number is to go
%- <title>    title
%- <page>     page number

%- parameters for spacing and length in toc
\def\@dotsep{1.5mu}% separation between dots in mu units
\def\@pnumwidth{2em}% width of a box in which the page number is put
\def\@tocrmarg{2em}% right margin for multiple line entries, \@tocrmarg ≥ \@pnumwidth
\def\@chaptervspace{0.25ex}% vertical space between chapter titles

%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}\rmfamily
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{4}\sffamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \addvspace{\@chaptervspace \@plus\p@} %\vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{4}\bfseries
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss \normalsize \normalfont #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi
}
%- redefine indentation for others
\renewcommand*\l@section{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{2.8em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{3em}{3.8em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{4em}{4.8em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{5em}{5.8em}}
\renewcommand*\l@figure{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@table{\@dottedtocline{1}{1em}{1.8em}}
%-

%---------------------------------------------------------------------------%
\endinput

