
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{owl-talk}[%
    1970/01/01 v0.0-dev A Custom LaTeX Beamer Template.
]

% For some inspiration on how to design a Beamer theme, one may consult:
% - [Design a custom Beamer theme from scratch](https://tex.stackexchange.com/questions/146529)
% - [Make beamer not look like beamer](https://tex.stackexchange.com/questions/158638)

% ---

% expl3 – Wrapper package for experimental LaTeX3.
\RequirePackage{expl3}

% ---

% Class Options

\ExplSyntaxOn

% Global variable to store class options.
\tl_new:N \g__owl_mode_tl
\tl_new:N \g__owl_accent_color_tl

\keys_define:nn { owl }
{
    mode .choice:,
    mode / dark .code:n = { \tl_gset:Nn \g__owl_mode_tl { dark } },
    mode / light .code:n = { \tl_gset:Nn \g__owl_mode_tl { light } },
    mode .initial:n = dark,
    accentcolor .tl_set:N = \g__owl_accent_color_tl,
    accentcolor .initial:n = {OwlRed},
}

\ExplSyntaxOff

% Parses class options.
\ProcessKeyOptions[owl]

% ---

% Loading Class and Packages

\LoadClass{beamer}

% This colour definition is just provisory to avoid
% undefined colour errors in the preamble; the chosen
% colour definition will be assigned in the hook.
\definecolor{accentcolor}{rgb}{0.5, 0.5, 0.5}
\ExplSyntaxOn
\AtBeginDocument{
    \colorlet{accentcolor}{\g__owl_accent_color_tl}
}
\ExplSyntaxOff

% fontspec – Advanced font selection in XeLaTeX and LuaLaTeX.
\RequirePackage{fontspec}

% appendixnumberbeamer – Manage frame numbering in appendixes in beamer.
\RequirePackage{appendixnumberbeamer}

% mathtools - Mathematical tools to use with amsmath.
\RequirePackage{mathtools}

% amssymb - Defines all the symbols found in the AMS symbol fonts msam and msbm.
\RequirePackage{amssymb}

% fontawesome5 – Font Awesome 5 with LATEX support.
\RequirePackage{fontawesome5}

% ---

% Loading Metropolis

% This ignominious redefinition prevents Metropolis from resetting the
% frame title appearance to the default in the appendix section.

\let\oldappendix\appendix
\let\olddocument\document
\renewcommand{\document}{%
    \olddocument%
    \renewcommand{\appendix}{%
        % Disables new bookmarks temporarily.
        \hypersetup{bookmarksdepth=0}
        \oldappendix
        % Restores the bookmark depth for subsequent sections.
        \hypersetup{bookmarksdepth=2}
        % Restores the old bookmark setting.
        \setcounter{framenumber}{0}
        \renewcommand*{\insertframenumber}{\Alph{framenumber}}
        \setbeamertemplate{page number in head/foot}[framenumber]
        \section*{Appendix}
    }
}

% Loads the Metropolis theme.
\usetheme[]{metropolis}

% Loads the chosen Metropolis colour theme.
\ExplSyntaxOn
\str_case:VnF \g__owl_mode_tl
{
    { dark }  { \usecolortheme{owl} }
        { light } { \usecolortheme[snowy]{owl} }
}
{ }
\ExplSyntaxOff

% ---

% Template Customisations

\setbeamertemplate{enumerate item}{%
    \color{accentcolor}\arabic{enumi}.%
}

\setbeamertemplate{enumerate subitem}{%
    \color{accentcolor}\normalfont\roman{enumii}.%
}

\setbeamertemplate{itemize item}{%
    \color{accentcolor}\ensuremath{\star}%
}

\setbeamertemplate{itemize subitem}{%
    \color{accentcolor}\ensuremath{\bullet}%
}

\setbeamertemplate{description item}{%
    \scshape\insertdescriptionitem%
}

\setbeamertemplate{qed symbol}{%
    \ensuremath{\square}%
}

\setbeamertemplate{section in toc}{%
    \makebox[3em][r]{%
        {\color{accentcolor}\@Roman\inserttocsectionnumber.}%
    }~\inserttocsection%
}

\setbeamertemplate{page number in head/foot}[totalframenumber]

% % ENIGMA: Why does Metropolis not respect this setting?
% \setbeamertemplate{navigation symbols}{}

\defbeamertemplate{headline}{infolines theme}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[
                wd={1.0\paperwidth},
                ht={2.65ex},
                dp={1.5ex},
                left,
            ]{section in head/foot}
            \usebeamerfont{section in head/foot}%
            \hspace{1.5em}%
            \insertsectionhead%
            \hspace*{1em}%
        \end{beamercolorbox}%
    }%
    {\color{accentcolor}\hrule}%
    \vspace{0ex}%
}

\defbeamertemplate*{frametitle}{infolines theme}
{%
    \vskip 1ex
    \begin{beamercolorbox}[left]{frame title}%
        \insertframetitle\\%
        \usebeamercolor[fg]{framesubtitle}%
        \usebeamerfont{framesubtitle}%
        \insertframesubtitle%
    \end{beamercolorbox}%
}

\defbeamertemplate{footline}{infolines theme}{%
    \leavevmode%
    {\color{accentcolor} \hrule}%
    \hbox{%
        \begin{beamercolorbox}[
                wd={.333333\paperwidth},
                ht={2.25ex},
                dp={1ex},
                left,
            ]{author in head/foot}%
            \usebeamerfont{author in head/foot}\hspace*{4ex}%
            \insertshortauthor%
            \expandafter\ifblank\expandafter{\beamer@shortinstitute}{%
            }{%
            ~~[\insertshortinstitute]%
            }
        \end{beamercolorbox}%
        \begin{beamercolorbox}[
                wd={.333333\paperwidth},
                ht={2.25ex},
                dp={1ex},
                center
            ]{title in head/foot}%
            \usebeamerfont{title in head/foot}%
            \insertshorttitle%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[
                wd={.333333\paperwidth},
                ht={2.25ex},
                dp={1ex},
                right,
            ]{date in head/foot}%
            \usebeamerfont{date in head/foot}\insertshortdate{}\hspace*{2em}
            % Puts page number into a box –
            % visually more appealing if font is not monospaced.
            \makebox[2em][r]{%
                \usebeamertemplate{page number in head/foot}%
            }%
            \hspace*{1.5em}
        \end{beamercolorbox}}%
    \vspace{0ex}%
}

\defbeamertemplate{footline}{reduced infolines theme}{%
    \leavevmode%
    {\color{accentcolor} \hrule}%
    \hbox{%
        \begin{beamercolorbox}[
                wd={.499999\paperwidth},
                ht={2.25ex},
                dp={1ex},
                left,
            ]{author in head/foot}%
            \hspace*{1.5em}%
            \usebeamerfont{title in head/foot}%
            \insertshorttitle%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[
                wd={.499999\paperwidth},
                ht={2.25ex},
                dp={1ex},
                right,
            ]{date in head/foot}%
            \usebeamerfont{date in head/foot}
            % Puts page number into a box –
            % visually more appealing if font is not monospaced.
            \makebox[2em][r]{%
                \usebeamertemplate{page number in head/foot}%
            }%
            \hspace*{1.5em}%
        \end{beamercolorbox}}%
    \vspace{0ex}%
}

\setbeamertemplate{headline}[infolines theme]

\setbeamertemplate{footline}[reduced infolines theme]

\setbeamertemplate{frametitle}[infolines theme]

\setbeamersize{
    text margin left={1em},
    text margin right={1em},
}

% ---

% Color Settings

\setbeamercolor{block title}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
    bg=normal text.bg!90!normal text.fg,
}

\setbeamercolor{block body}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
    bg=normal text.bg!90!normal text.fg,
}

\setbeamercolor{alerted text}{
    fg=accentcolor,
}

\setbeamercolor{example text}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
}

\setbeamercolor{author}{
    fg=accentcolor,
}

\setbeamercolor{author in head/foot}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
    bg=normal text.bg!100!normal text.fg,
}

\setbeamercolor{title in head/foot}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
    bg=normal text.bg!100!normal text.fg,
}

\setbeamercolor{date in head/foot}{
    use=normal text,
    fg=accentcolor,
    bg=normal text.bg!100!normal text.fg,
}

%\setbeamercolor{normal text}{}

\setbeamercolor{section in head/foot}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
    bg=normal text.bg!100!normal text.fg,
}

\setbeamercolor{title separator}{
    fg=accentcolor,
}
\setbeamercolor{structure}{
    use=normal text,
    fg=normal text.fg!90!normal text.bg,
}

\setbeamercolor{qed symbol}{
    fg=accentcolor,
}

\setbeamercolor{verse}{
    fg=accentcolor,
}

% \setbeamercolor{title}{
%     fg=black,
% }

% \setbeamercolor{institute}{
%     fg=black,
% }

% \setbeamercolor{date}{
%     fg=black,
% }

% ---

% Font Settings

% Compare with:
% [What are all the possible first arguments to `\setbeamerfont`?](https://tex.stackexchange.com/questions/183052)

\setmainfont{Libertinus Serif}[Ligatures=TeX]
\setsansfont{Libertinus Sans}[Ligatures=TeX]
\setmonofont{Libertinus Mono}[Ligatures=TeX]

\setbeamerfont{frametitle}{
    shape={\scshape},
}

\setbeamerfont{section in toc}{
    shape={\scshape},
    series={\bfseries},
}

\setbeamerfont{headline}{
    shape={\scshape},
}

\setbeamerfont{footline}{
    shape={\scshape},
}

\setbeamerfont{title}{
    shape={\scshape},
    series={\bfseries},
}

\setbeamerfont{title in head/foot}{
    shape={\scshape},
    series={\bfseries},
}

% ---

% Math

% Places equation tags to the left hand side
% ENIGMA The following high-level alternatives do not work:
% - Passing leqno to beamer from the wrapper class.
% - Calling the wrapper class with leqno.
\tagsleft@true
\let\veqno\@@leqno

% Embraces tags by square brackets.
\newtagform{brakbold}{%
\color{accentcolor}\textbf[}{\textbf]\normalcolor
}
\usetagform{brakbold}

% Environments

\renewenvironment{exampleblock}[1]{
    \begin{block}
        {\color{accentcolor}\faLightbulb\enspace\scshape#1}%
        }{%
    \end{block}
}

\renewenvironment{alertblock}[1]{
    \begin{block}
        {\color{accentcolor}\faExclamationTriangle\enspace\scshape#1}%
        }{%
    \end{block}
}

\newenvironment{mathblock}[1]{
    \begin{block}
        {\faCoffee\enspace\scshape#1}%
        }{%
    \end{block}
}

% \renewenvironment{theorem}[1]{
%     \begin{block}{#1}%
%         }{
%     \end{block}%
% }

\renewenvironment{proof}{
    {\scshape\bfseries Proof.}%
}{%
    \hfill%
    \ensuremath{\qedsymbol}%
    \ignorespacesafterend%
}

% ---

% Title Page, Table of Contents, Standout Frames

% Template corrections in order to avoid some visual artifacts –
% for instance, horizontal lines on the title slide.

\defbeamertemplate{headline}{titleFix}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[
                wd={1.0\paperwidth},
                ht={2.8ex},
                dp={1.5ex},
                left,
            ]{background canvas}%
        \end{beamercolorbox}%
    }%
    \vspace{0ex}%
}

\defbeamertemplate{headline}{tocFix}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[
                wd={1.0\paperwidth},
                ht={2.8ex},
                dp={1.5ex},
                left,
            ]{background canvas}%
        \end{beamercolorbox}%
    }%
    {\color{accentcolor}\hrule}%
    \vspace{0ex}%
}

% NOTE: This definition is not different titleFix, yet.
\defbeamertemplate{headline}{standoutFix}{
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[
                wd={1.0\paperwidth},
                ht={2.8ex},
                dp={1.5ex},
                left,
            ]{background canvas}%
        \end{beamercolorbox}%
    }%
    \vspace{0ex}%
}

% Inserts a ToC slide at the beginning of each section.
\AtBeginSection[]{{
            \setbeamertemplate{headline}[tocFix]%
            \frame{\tableofcontents[currentsection]}%
        }}

\newcommand{\make@title@page}{%
    \begingroup
    \setbeamertemplate{headline}[titleFix]{%
        \setbeamertemplate{footline}{}%
        % There will be an overful vbox on the
        % title page inherited from Metropolis.
        \frame{\titlepage}%
    }%
    \endgroup
}

\newcommand{\make@toc}{%
    \begingroup
    \setbeamertemplate{headline}[tocFix]%
    \frame{\tableofcontents}%
    \endgroup
}

\AtBeginDocument{%
    \make@title@page%
    \make@toc%
}

% Subtraction frome the frame number counter due
% to the title page and the (hopefully) single-paged toc.
\addtocounter{framenumber}{-2}

\newenvironment{standoutframe}{%
    \begingroup
    \setbeamertemplate{headline}{%
        \leavevmode%
        \hbox{%
            \begin{beamercolorbox}[
                    wd={1.0\paperwidth},
                    ht={2.8ex},
                    dp={1.5ex},
                    left,
                ]{background canvas}%
            \end{beamercolorbox}%
        }%
        \vskip 0ex%
    }%
    \setbeamertemplate{footline}{}
    \begin{frame}[standout]%
        }{%
    \end{frame}
    \endgroup
}

% ---

% References

\newcommand*{\bibitemarticle}{
    \setbeamertemplate{bibliography item}{\color{accentcolor}\faFile}%
    \bibitem%
}

\newcommand*{\bibitembook}{
    \setbeamertemplate{bibliography item}{\color{accentcolor}\faBook}%
    \bibitem%
}

\newcommand*{\bibitemonline}{
    \setbeamertemplate{bibliography item}{\color{accentcolor}\faGlobe}%
    \bibitem%
}
