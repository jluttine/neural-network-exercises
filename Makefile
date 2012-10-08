
EXERCISES=ex01.pdf ex02.pdf ex03.pdf ex04.pdf ex05.pdf ex06.pdf ex07.pdf ex08.pdf ex09.pdf ex10.pdf ex11.pdf
ANSWERS=ex01_answer.pdf ex02_answer.pdf ex03_answer.pdf ex04_answer.pdf ex05_answer.pdf ex06_answer.pdf ex07_answer.pdf ex08_answer.pdf ex09_answer.pdf ex10_answer.pdf ex11_answer.pdf

all: exercises solutions

exercises: $(EXERCISES)
	pdftk \
	ex01/ex01.pdf \
	ex02/ex02.pdf \
	ex03/ex03.pdf \
	ex04/ex04.pdf \
	ex05/ex05.pdf \
	ex06/ex06.pdf \
	ex07/ex07.pdf \
	ex08/ex08.pdf \
	ex09/ex09.pdf \
	ex10/ex10.pdf \
	ex11/ex11.pdf \
	output \
	exercises.pdf

solutions: $(ANSWERS)
	pdftk \
	ex01/ex01.pdf \
	ex01/ex01_answer.pdf \
	ex02/ex02.pdf \
	ex02/ex02_answer.pdf \
	ex03/ex03.pdf \
	ex03/ex03_answer.pdf \
	ex04/ex04.pdf \
	ex04/ex04_answer.pdf \
	ex05/ex05.pdf \
	ex05/ex05_answer.pdf \
	ex06/ex06.pdf \
	ex06/ex06_answer.pdf \
	ex07/ex07.pdf \
	ex07/ex07_answer.pdf \
	ex08/ex08.pdf \
	ex08/ex08_answer.pdf \
	ex09/ex09.pdf \
	ex09/ex09_answer.pdf \
	ex10/ex10.pdf \
	ex10/ex10_answer.pdf \
	ex11/ex11.pdf \
	ex11/ex11_answer.pdf \
	output \
	solutions.pdf

ex%_answer.pdf:
	cd ex$*; \
	latex ex$*_answer.tex; \
	dvips ex$*_answer.dvi; \
	ps2pdf ex$*_answer.ps;

ex%.pdf:
	cd ex$*; \
	latex ex$*.tex; \
	dvips ex$*.dvi; \
	ps2pdf ex$*.ps;
