#127 Feature Selection for Biomedical Patterns
Author: Yilong Wang

Thid folder contains several code files:
BPSO: Proposed Binary Particle Swarm genetic search, the popution sizeis 30 and generation is 100. This gives 6000 evaluations as the 
program terminates.
BPSO_C: Binary Particle Swarm genetic search, the popution size is 30 and generation is 200. This gives 6000 evaluations as the 
program terminates.
BPSO_main: A file is used to call BPSO and record its performance in 10 independent runs.
BPSO_Cmain:A file is used to call BPSO_C and record its performance in 10 independent runs.
fhd.m: Fitness evaluation function(KNN,k=5), takes feature subsets( ant paths) as input, ouputs accuracy fitness.
Tenfold.m: 10 fold cross validation(KNN,k=5), takes gbest(Glbal best feature subset) as input, outputs accuracy fitness

