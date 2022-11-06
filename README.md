# Final_year_project
Slice to Volume Registration for medical imaging:

This repository contains all the code used for my Final Year Project.

There are two folders with relevant code and information.

MATLAB_code:
	"ReferencesMATLAB.txt" - all MATLAB references used in this project
	
	"SliceToMat.m" - code that uniformly slices an input 3D volume reconstructed using DICOM files
	"PoseDisplay.m" - code to display the slices cut in SliceToMat.m	
	"Rot.m" - code to display the orientation of the slices cut in SliceToMat.m	
	"PoseDisplayTestSlices.m" - code to display the slices used in the Test subset of the data
	"RotTestSlices.m" - code to display the orientation of the slices used in the Test subset of the data	
	"PoseDisplayOutputSlice.m" - code to display the angle error as slices (for each regression model)


Python_code:
	"ReferencesPython.txt" - all Python references used in this project

	"Siamese_network.ipynb" - Jupyter notebook containing the Siamese network for creating a single output image from two different modality inputs
	"Regression_model-1input.ipynb" - Jupyter notebook containing regression model for the implicit case
	"Regression_model-2input.ipynb" - Jupyter notebook containing regression model for the explicit case
	"Combined_program.ipynb" - Jupyter notebook containing a composite of the Siamese and regression networks
