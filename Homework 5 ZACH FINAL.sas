data cars;
infile "C:\users\zetvzb\Downloads\cars.txt" FIRSTOBS=4;
INPUT SIZE $ 1-10 manufact $ 11-21 model $ 22-37 mileage 38-47 reliable 48-50; 
run;
 title "Question Number 1 part 1";
 */Find the number of non-missing observations of numeric variables /*;
 */Find the number of missing observations of numeric variables /*;
 proc format; 
 value $missfmt ' '='Missing' other='Not Missing';
 value missfmt  . ='Missing' other='Not Missing';
 run;
*/Display the number of non-missing and missing observations for each variable in the data set/*;
 proc freq data =cars;
 format _CHAR_ $missfmt.;
 tables _CHAR_/ missing missprint nocum nopercent;
 format _NUMERIC_ missfmt.;
 tables _NUMERIC_ / missing nocum nopercent;
 run;

*/Calculate the Mean for the variables RELIABLE and MILEAGE/*;

PROC MEANS data=cars MEAN MAXDEC=1;
var mileage reliable;
run;


title "Question Number 1 part 2";
*/Compute the requested statistics for each car SIZE. Use a CLASS statement instead of first sortig the data and using a BY statement/*;


PROC MEANS data=cars MEAN MAXDEC=1;
class SIZE;
run;
*/This is an alternative and much simpler way to do parts a and b from question number one. I worked hard the other way thats why I kept it that way. /*;
proc means data=cars nmiss n;
 class SIZE;
 run;

 title "Question Number 1 part 3";
*/Plot stem and leaf plots of variables RELIABLE and MILEAGE/*;
ods listing;
ods graphics off;
proc univariate data=cars plot; 
 var mileage reliable;
 run;

title "Question Number 1 part 4";
*/Test if the mean of MILEAGE is 25 with alpha =0.10/*;

proc ttest data=cars h0=25 alpha=0.1;
var mileage; 
run; 

title "Question Number 1 part 5";
*/Test if there is a mean difference of mileage difference between the two groups of 'Reliable=1' and 'reliable=5'. Intepret the result/*;
proc ttest data=cars;
class Reliable; 
var mileage;
where Reliable=1 or Reliable=5;
run;







title "Question Number 2 part 1";

*/Compute the number of non-missing observations, the mean, the standard deviation, and the standard error (all to three decimal places) of the variables Weight, Mom_Age, and M-WTgain for all patients/*;
proc contents data=sashelp.bweight; 
run; 

title "Question Number 2 part 1";
proc means data=sashelp.bweight n MEAN STD STDERR MAXDEC=3; 
var  Weight MomAge MomWtGain;
run;

title "Question Number 2 part 2"; 
*/Compute the same statistics as part 1 but by boys and girls/*;
proc means data=sashelp.bweight n MEAN STD STDERR MAXDEC=3;
class boy;
var Weight MomAge MomWtGain;
run;


title "Question Number 2 part 3";
*/Plot a stem and leaf plot for weight/*;
ods listing;
ods graphics off; 

proc univariate data=sashelp.bweight(obs=50) plots; 
 var Weight;
 run;



title "Question Number 2 Part 4"; 
*/Test if the distribution is significantly different from a normal distribution with alpha equal to 0l05 for Weight/*;
proc univariate data=sashelp.bweight normal alpha=0.05 ;
var weight; 
run; 




title "Question Number 2 Part 5";
 */Test if the mean of Weight is 3400 g with alpha=0.05/*;
proc ttest data=sashelp.bweight h0=3400 alpha=0.05;
var weight; 
run; 

title "Question Number 2 Part 6"; 
*/Test if the smoking status of a mother(Smoke) makes a signifcant difference of the weight (Weight) with alpha equal to 0.05/*;
proc ttest data=sashelp.bweight alpha=0.05;
class Momsmoke;
var weight; 
run; 
