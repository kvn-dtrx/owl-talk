# ---
# title: justfile for owl-talk
# ---

# ---

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

root := justfile_directory()
latexmkrc := root / ".latexmkrc"
examples := root / "examples"
build-dir := "build"

# Shows available recipes
default:
    @just --list --unsorted

# Prepare build directory
prepare:
    mkdir -p {{build-dir}}

# Compile examples/demo for dark and light (-jobname)
compile: prepare
    #!/usr/bin/env bash
    for mode in dark light; do
        latexmk -cd -r "{{latexmkrc}}" -jobname="${mode}" "{{examples}}/demo/main.tex"
    done

# Alias for compile
build: compile

# Removes intermediate files; keeps pdf/png/tex
clean:
    find {{build-dir}} -mindepth 1 \
        ! \( -iname "*.pdf" -o -iname "*.png" -o -iname "*.tex" -o -iname ".gitkeep" \) \
        -delete

# Wipes build directory except .gitkeep
reset:
    find {{build-dir}} -mindepth 1 ! -iname ".gitkeep" -delete

# Resets and rebuilds examples
rebuild: reset build
