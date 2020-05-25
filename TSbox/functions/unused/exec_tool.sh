#!/bin/bash
USER=apiracha
module load MATLAB/R2017a
matlab -nodesktop -nodisplay -nosplash -r "first_path; frontiers_paper_figures; exit"
