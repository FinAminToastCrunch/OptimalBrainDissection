#!/bin/sh
#
# Run this script from INPUT directory like this:
# ./run_me_first_to_preprocess_your_predicion_file.sh
# This script presumes you are working on a UNIX command line
# (e.g., Linux, Cygwin, Mac).
#
# This script replaces the strings "NOT AVAILABLE" and "NA"
# with the string "NaN" (what Matlab accepts).
# Otherwise, you need to do this editing manually and put the 
# edited file in INPUT/my_processed_prediction.

cd my_prediction
for f in *
	do

	outfile="../my_processed_prediction/$f"

	echo
	echo "Processing prediction file in INPUT/my_prediction"
	echo

	## change these strings to NaN (what Matlab likes)
	cat $f | sed 's/NOT AVAILABLE/NaN/g' | sed 's/NA/NaN/g' | sed 's/"//g' > $outfile

	echo "Wrote output file to INPUT/my_processed_prediction"
	echo

done
cd ..
