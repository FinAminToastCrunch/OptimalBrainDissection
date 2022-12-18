Hi Fin, 

Here are the timestamps of each of the datasets:

- Col-tot3: 0, 12, 24, 36, 48, and 60 minutes 6 total
- Dorrit: 0, 3, 6, 9, and 12 minutes 5 total
- DatasetJelle: 0, 10, 20, 40 minutes 4 total 
- Nighttimecourse: 15, 30, 120, and 960 minutes 4 total

Let me know if I missed anything, 
Cheers,

Note that the first column has time stamps which are numbered sequentially. This is wrong. Each CSV file has an independent experiment. So 
the time values should always start from 0.



___________________________________TODO________________________________________6/8/22
Train on datasets with time points are fixed to the Columbia Total
then do the following changes

For Dorrit: Just add 15 min
For Jelle: Add 30 min and 50 min
For Nighttime: Add 60 min and 540 min

Then train again on this^^

Read "NETFORCE" section in Shiny_Paper. Do NOT edit the Shiny Paper	
rMD_10.rmd R file line 31 and 36 should be changed. The corresponding files are in your email. 
And this is the code described in the shiny paper. Use as reference for writing methods paper