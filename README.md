# Documentation for SMOS toolbox
## An analysis of watermass (trans)formation from space
### Overview
The SMOS toolbox is a novel numerical model which derives information about the distribution and properties of watermasses from air-sea fluxes utilising satellite date.

The study was driven by a need to use salinity data taken from SMOS in order to better understand the water cycle and it's temporal variability through understanding of watermasses in the worlds oceans.

The oceans can be thought of as comprising of multiple bodies of water each having their own unique temperature and salinity characteristcs. When and where these unique bodies of water appear (formation) or move away from a specific location (destruction) can be related to the exchange of heat and freshwater with the atmosphere.
The transformation is the mass flow of water through a constant property surface (i.e the mass flux per unit area) and the formation is the difference in transformation between two successive constant property surfaces.

| ![](3-Figure2-1.png) |
|:--:|
|  The transformation in this figure is given by a diapycnal flux or the mass flux of water through a constant density surface (a). A positive or negative formation can result if the mass flux accross one of the constat density surfaces is greater (b) or smaller (c) than through the subsequent density surface, respectively. |

The goals of the model are to:

	- Model propogation of satellite uncertainties into water mass (trans)formation calculations
		* through the use of a Monte-Carlo simulation
	- To understand distribution and location of water mass (trans)formation in:
		* denisty space
		* temperature - salinity space
		* geographic space

### Technical Information
**NOTE: The code is highly experimental and is still under development and as such much work is needed in order for the model to work as intended**

#### How to run the code

	- clone the github repository
	- Open MATLAB and navigate to the folder in which the repository was cloned and run the following two commands
```matlab
addpath(genpath("TSbox"))
addpath(genpath("TSdiag"))
```
	- Then you can run the following command
```matlab
wm_code_main()
```
This will execute the main function of the numerical model which automatically calls all relevant functions to run the model and genrate outputs


