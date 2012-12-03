
EXERCISES=ex01/problems.pdf ex02/problems.pdf ex03/problems.pdf ex04/problems.pdf ex05/problems.pdf ex06/problems.pdf ex07/problems.pdf ex08/problems.pdf ex09/problems.pdf ex10/problems.pdf ex11/problems.pdf
SOLUTIONS=ex01/solutions.pdf ex02/solutions.pdf ex03/solutions.pdf ex04/solutions.pdf ex05/solutions.pdf ex06/solutions.pdf ex07/solutions.pdf ex08/solutions.pdf ex09/solutions.pdf ex10/solutions.pdf ex11/solutions.pdf

all: exercises solutions
exercises: exercises.pdf
solutions: solutions.pdf

exercises.pdf: $(EXERCISES)
	pdftk \
	ex01/problems.pdf \
	ex02/problems.pdf \
	ex03/problems.pdf \
	ex04/problems.pdf \
	ex05/problems.pdf \
	ex06/problems.pdf \
	ex07/problems.pdf \
	ex08/problems.pdf \
	ex09/problems.pdf \
	ex10/problems.pdf \
	ex11/problems.pdf \
	output \
	exercises.pdf

solutions.pdf: $(SOLUTIONS)
	pdftk \
	ex01/solutions.pdf \
	ex02/solutions.pdf \
	ex03/solutions.pdf \
	ex04/solutions.pdf \
	ex05/solutions.pdf \
	ex06/solutions.pdf \
	ex07/solutions.pdf \
	ex08/solutions.pdf \
	ex09/solutions.pdf \
	ex10/solutions.pdf \
	ex11/solutions.pdf \
	output \
	solutions.pdf

ex%/solutions.pdf: ex%/solutions.tex ex%/exercise.tex
	cd ex$*; \
	TEXINPUTS="..:" pdflatex solutions.tex; \
	TEXINPUTS="..:" pdflatex solutions.tex; \
	#TEXINPUTS="..:" latex solutions.tex; \
	#TEXINPUTS="..:" latex solutions.tex; \
	#dvips solutions.dvi; \
	#ps2pdf solutions.ps;

ex%/problems.pdf: ex%/problems.tex ex%/exercise.tex
	cd ex$*; \
	TEXINPUTS="..:" pdflatex problems.tex; \
	TEXINPUTS="..:" pdflatex problems.tex; \
	#TEXINPUTS="..:" latex problems.tex; \
	#TEXINPUTS="..:" latex problems.tex; \
	#dvips problems.dvi; \
	#ps2pdf problems.ps;

clean:
	rm $(EXERCISES) $(SOLUTIONS) exercises.pdf solutions.pdf ex*/*.log ex*/*.aux
