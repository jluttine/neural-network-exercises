
EXERCISES=ex01_problems.pdf ex02_problems.pdf ex03_problems.pdf ex04_problems.pdf ex05_problems.pdf ex06_problems.pdf ex07_problems.pdf ex08_problems.pdf ex09_problems.pdf ex10_problems.pdf ex11_problems.pdf
SOLUTIONS=ex01_solutions.pdf ex02_solutions.pdf ex03_solutions.pdf ex04_solutions.pdf ex05_solutions.pdf ex06_solutions.pdf ex07_solutions.pdf ex08_solutions.pdf ex09_solutions.pdf ex10_solutions.pdf ex11_solutions.pdf

all: exercises solutions

exercises: $(EXERCISES)
	pdftk \
	ex01/ex01_problems.pdf \
	ex02/ex02_problems.pdf \
	ex03/ex03_problems.pdf \
	ex04/ex04_problems.pdf \
	ex05/ex05_problems.pdf \
	ex06/ex06_problems.pdf \
	ex07/ex07_problems.pdf \
	ex08/ex08_problems.pdf \
	ex09/ex09_problems.pdf \
	ex10/ex10_problems.pdf \
	ex11/ex11_problems.pdf \
	output \
	exercises.pdf

solutions: $(SOLUTIONS)
	pdftk \
	ex01/ex01_solutions.pdf \
	ex02/ex02_solutions.pdf \
	ex03/ex03_solutions.pdf \
	ex04/ex04_solutions.pdf \
	ex05/ex05_solutions.pdf \
	ex06/ex06_solutions.pdf \
	ex07/ex07_solutions.pdf \
	ex08/ex08_solutions.pdf \
	ex09/ex09_solutions.pdf \
	ex10/ex10_solutions.pdf \
	ex11/ex11_solutions.pdf \
	output \
	solutions.pdf

ex%_solutions.pdf:
	cd ex$*; \
	TEXINPUTS="..:" latex ex$*_solutions.tex; \
	dvips ex$*_solutions.dvi; \
	ps2pdf ex$*_solutions.ps;

ex%_problems.pdf:
	cd ex$*; \
	TEXINPUTS="..:" latex ex$*_problems.tex; \
	dvips ex$*_problems.dvi; \
	ps2pdf ex$*_problems.ps;
