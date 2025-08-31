# Owl Talk

## Synopsis

This repository contains a template for presentation slides. It is based upon the LaTeX class [beamer](https://ctan.org/pkg/beamer) and a reverence to the themes [metropolis](https://github.com/matze/mtheme) and [beamercolortheme-owl](https://github.com/rchurchley/beamercolortheme-owl).

## Template Preview

Precompiled PDF versions of this template are provided in the **[Releases](https://github.com/kvn-dtrx/owl-talk/releases)** section for your convenience. Alternatively, after downloading the repository (see below), you may navigate to the `examples/` subdirectory and run `latexmk`.

## Installation

### Requirements

Any recent TeXLive distribution ($\geq 2020$) ought to be capable of compiling this template.

### Setup

1. Navigate to a working directory of your choice—such as `${XDG_DATA_HOME}`—then clone the repository and enter it:

   ``` shell
   git clone https://github.com/kvn-dtrx/owl-talk.git &&
       cd owl-talk
   ```

2. Choose a setup option based on your intended use. If you prefer to run the commands manually yourself or want to inspect what each make target does first, use the -n flag for a dry run. This prints the commands without executing them:

   ``` shell
   make -n <target>
   ```

## Usage

You may specify the document class in your TeX source file as follows:

``` tex
\documentclass[ 
   mode={<mode>},%
   accentcolor={<colour>},%
]{owl-talk}
```

In this snippet, `<mode>` should be either light or dark, and `<colour>` should be an xcolor-compatible colour name defined in the preamble.

## Colophon

**Author:** [kvn-dtrx](https://github.com/kvn-dtrx)

**License:** [MIT License](license.txt)
