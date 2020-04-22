/* library for the Provider files */
libname t1 "P:/H24.2019.SS_ACOcomposition/dat/ACOSSP/ACOSSP_Provider File";
/* library for the Public-Use files */
libname t2 "P:/H24.2019.SS_ACOcomposition/dat/ACOSSP/ACO _Public Use File";
/* library for the project data */
libname t3 "P:/H24.2019.SS_ACOcomposition/dat/Project";

/* create temp datasets to work with. */
data pro2013; set t1.provider_aco_ssp_2013; run;
data pub2013; set t2.y2013; run;


/****************************** STEP 1: Physicians by specialty *****************************/

/* Create reduced dataset from 2013 Provider file with only NPI, ACO_NUM, and PRVDR_SPCLTY_CD.
   Also, create new ID var with which to transpose data in a couple of steps.*/
data pro2013_1;
	set pro2013;
	keep NPI ACO_NUM PRVDR_SPCLTY_CD id;
	id = _N_;
run;

/* use PROC TRANSPOSE to reshape data from a long format to a wide format. */
proc sort data=pro2013_1; by ACO_NUM id PRVDR_SPCLTY_CD NPI;
proc transpose data=pro2013_1
			   out=pro2013_1
			   prefix=PHYS_SPEC; 
	by ACO_NUM id;
	id PRVDR_SPCLTY_CD;
	var NPI;
run;
*note: "11722 observations ommitted due to missing ID value" 
11722 rows represented practices or groups that weren't recorded a specialty, 
**oddly, regardless, the same amount of rows are outputted as that inputted...;

/* drop "id", "_LABEL_", and "_NAME_" */
data pro2013_1;
	set pro2013_1;
	drop id _NAME_ _LABEL_;
run;

/* Use PROC SQL to count all NPIs associated with every ACO_NUM for each specialty */
proc sql;
	create table pro2013_11 as
		select ACO_NUM, count(distinct PHYS_SPEC01) as PHYS_SPEC01, count(distinct PHYS_SPEC02) as PHYS_SPEC02,
			count(distinct PHYS_SPEC03) as PHYS_SPEC03, count(distinct PHYS_SPEC04) as PHYS_SPEC04,
			count(distinct PHYS_SPEC05) as PHYS_SPEC05, count(distinct PHYS_SPEC06) as PHYS_SPEC06, count(distinct PHYS_SPEC07) as PHYS_SPEC07,
			count(distinct PHYS_SPEC08) as PHYS_SPEC08, count(distinct PHYS_SPEC09) as PHYS_SPEC09, count(distinct PHYS_SPEC10) as PHYS_SPEC10,
			count(distinct PHYS_SPEC11) as PHYS_SPEC11, count(distinct PHYS_SPEC12) as PHYS_SPEC12, count(distinct PHYS_SPEC13) as PHYS_SPEC13,
			count(distinct PHYS_SPEC14) as PHYS_SPEC14, count(distinct PHYS_SPEC15) as PHYS_SPEC15, count(distinct PHYS_SPEC16) as PHYS_SPEC16,
			count(distinct PHYS_SPEC17) as PHYS_SPEC17, count(distinct PHYS_SPEC18) as PHYS_SPEC18, count(distinct PHYS_SPEC19) as PHYS_SPEC19,
			count(distinct PHYS_SPEC20) as PHYS_SPEC20, count(distinct PHYS_SPEC21) as PHYS_SPEC21, count(distinct PHYS_SPEC22) as PHYS_SPEC22,
			count(distinct PHYS_SPEC23) as PHYS_SPEC23, count(distinct PHYS_SPEC24) as PHYS_SPEC24, count(distinct PHYS_SPEC25) as PHYS_SPEC25,
			count(distinct PHYS_SPEC26) as PHYS_SPEC26, count(distinct PHYS_SPEC27) as PHYS_SPEC27, count(distinct PHYS_SPEC28) as PHYS_SPEC28,
			count(distinct PHYS_SPEC29) as PHYS_SPEC29, count(distinct PHYS_SPEC30) as PHYS_SPEC30, count(distinct PHYS_SPEC32) as PHYS_SPEC32,
			count(distinct PHYS_SPEC33) as PHYS_SPEC33, count(distinct PHYS_SPEC34) as PHYS_SPEC34, count(distinct PHYS_SPEC35) as PHYS_SPEC35,
			count(distinct PHYS_SPEC36) as PHYS_SPEC36, count(distinct PHYS_SPEC37) as PHYS_SPEC37, count(distinct PHYS_SPEC38) as PHYS_SPEC38,
			count(distinct PHYS_SPEC39) as PHYS_SPEC39, count(distinct PHYS_SPEC40) as PHYS_SPEC40, count(distinct PHYS_SPEC41) as PHYS_SPEC41,
			count(distinct PHYS_SPEC42) as PHYS_SPEC42, count(distinct PHYS_SPEC43) as PHYS_SPEC43, count(distinct PHYS_SPEC44) as PHYS_SPEC44,
			count(distinct PHYS_SPEC46) as PHYS_SPEC46, count(distinct PHYS_SPEC48) as PHYS_SPEC48, count(distinct PHYS_SPEC50) as PHYS_SPEC50,
			count(distinct PHYS_SPEC62) as PHYS_SPEC62, count(distinct PHYS_SPEC64) as PHYS_SPEC64, count(distinct PHYS_SPEC65) as PHYS_SPEC65,
			count(distinct PHYS_SPEC66) as PHYS_SPEC66, count(distinct PHYS_SPEC67) as PHYS_SPEC67, count(distinct PHYS_SPEC68) as PHYS_SPEC68,
			count(distinct PHYS_SPEC71) as PHYS_SPEC71, count(distinct PHYS_SPEC72) as PHYS_SPEC72, count(distinct PHYS_SPEC76) as PHYS_SPEC76,
			count(distinct PHYS_SPEC77) as PHYS_SPEC77, count(distinct PHYS_SPEC78) as PHYS_SPEC78, count(distinct PHYS_SPEC79) as PHYS_SPEC79,
			count(distinct PHYS_SPEC80) as PHYS_SPEC80, count(distinct PHYS_SPEC81) as PHYS_SPEC81, count(distinct PHYS_SPEC82) as PHYS_SPEC82,
			count(distinct PHYS_SPEC83) as PHYS_SPEC83, count(distinct PHYS_SPEC84) as PHYS_SPEC84, count(distinct PHYS_SPEC85) as PHYS_SPEC85,
			count(distinct PHYS_SPEC86) as PHYS_SPEC86, count(distinct PHYS_SPEC88) as PHYS_SPEC88, count(distinct PHYS_SPEC89) as PHYS_SPEC89,
			count(distinct PHYS_SPEC90) as PHYS_SPEC90, count(distinct PHYS_SPEC91) as PHYS_SPEC91, count(distinct PHYS_SPEC92) as PHYS_SPEC92,
			count(distinct PHYS_SPEC93) as PHYS_SPEC93, count(distinct PHYS_SPEC94) as PHYS_SPEC94, count(distinct PHYS_SPEC97) as PHYS_SPEC97,
			count(distinct PHYS_SPEC98) as PHYS_SPEC98, count(distinct PHYS_SPEC99) as PHYS_SPEC99, count(distinct PHYS_SPECC0) as PHYS_SPECC0
	from pro2013_1
	group by ACO_NUM;
quit;

/* Create indicator columns for whether or not there were any physicians representing the specialties in the ACO,
   tacking these on to the back of the previous dataset*/
proc sql;
	create table pro2013_12 as
		select *,       case when PHYS_SPEC01 > 0 then 1 else 0 end as DUM_PHYS_SPEC01,
						case when PHYS_SPEC02 > 0 then 1 else 0 end as DUM_PHYS_SPEC02,
						case when PHYS_SPEC03 > 0 then 1 else 0 end as DUM_PHYS_SPEC03,
						case when PHYS_SPEC04 > 0 then 1 else 0 end as DUM_PHYS_SPEC04,
						case when PHYS_SPEC05 > 0 then 1 else 0 end as DUM_PHYS_SPEC05,
						case when PHYS_SPEC06 > 0 then 1 else 0 end as DUM_PHYS_SPEC06,
						case when PHYS_SPEC07 > 0 then 1 else 0 end as DUM_PHYS_SPEC07,
						case when PHYS_SPEC08 > 0 then 1 else 0 end as DUM_PHYS_SPEC08,
						case when PHYS_SPEC09 > 0 then 1 else 0 end as DUM_PHYS_SPEC09,
						case when PHYS_SPEC10 > 0 then 1 else 0 end as DUM_PHYS_SPEC10,
						case when PHYS_SPEC11 > 0 then 1 else 0 end as DUM_PHYS_SPEC11,
						case when PHYS_SPEC12 > 0 then 1 else 0 end as DUM_PHYS_SPEC12,
						case when PHYS_SPEC13 > 0 then 1 else 0 end as DUM_PHYS_SPEC13,
						case when PHYS_SPEC14 > 0 then 1 else 0 end as DUM_PHYS_SPEC14,
						case when PHYS_SPEC15 > 0 then 1 else 0 end as DUM_PHYS_SPEC15,
						case when PHYS_SPEC16 > 0 then 1 else 0 end as DUM_PHYS_SPEC16,
						case when PHYS_SPEC17 > 0 then 1 else 0 end as DUM_PHYS_SPEC17,
						case when PHYS_SPEC18 > 0 then 1 else 0 end as DUM_PHYS_SPEC18,
						case when PHYS_SPEC19 > 0 then 1 else 0 end as DUM_PHYS_SPEC19,
						case when PHYS_SPEC20 > 0 then 1 else 0 end as DUM_PHYS_SPEC20,
						case when PHYS_SPEC21 > 0 then 1 else 0 end as DUM_PHYS_SPEC21,
						case when PHYS_SPEC22 > 0 then 1 else 0 end as DUM_PHYS_SPEC22,
						case when PHYS_SPEC23 > 0 then 1 else 0 end as DUM_PHYS_SPEC23,
						case when PHYS_SPEC24 > 0 then 1 else 0 end as DUM_PHYS_SPEC24,
						case when PHYS_SPEC25 > 0 then 1 else 0 end as DUM_PHYS_SPEC25,
						case when PHYS_SPEC26 > 0 then 1 else 0 end as DUM_PHYS_SPEC26,
						case when PHYS_SPEC27 > 0 then 1 else 0 end as DUM_PHYS_SPEC27,
						case when PHYS_SPEC28 > 0 then 1 else 0 end as DUM_PHYS_SPEC28,
						case when PHYS_SPEC29 > 0 then 1 else 0 end as DUM_PHYS_SPEC29,
						case when PHYS_SPEC30 > 0 then 1 else 0 end as DUM_PHYS_SPEC30,
						case when PHYS_SPEC32 > 0 then 1 else 0 end as DUM_PHYS_SPEC32,
						case when PHYS_SPEC33 > 0 then 1 else 0 end as DUM_PHYS_SPEC33,
						case when PHYS_SPEC34 > 0 then 1 else 0 end as DUM_PHYS_SPEC34,
						case when PHYS_SPEC35 > 0 then 1 else 0 end as DUM_PHYS_SPEC35,
						case when PHYS_SPEC36 > 0 then 1 else 0 end as DUM_PHYS_SPEC36,
						case when PHYS_SPEC37 > 0 then 1 else 0 end as DUM_PHYS_SPEC37,
						case when PHYS_SPEC38 > 0 then 1 else 0 end as DUM_PHYS_SPEC38,
						case when PHYS_SPEC39 > 0 then 1 else 0 end as DUM_PHYS_SPEC39,
						case when PHYS_SPEC40 > 0 then 1 else 0 end as DUM_PHYS_SPEC40,
						case when PHYS_SPEC41 > 0 then 1 else 0 end as DUM_PHYS_SPEC41,
						case when PHYS_SPEC42 > 0 then 1 else 0 end as DUM_PHYS_SPEC42,
						case when PHYS_SPEC43 > 0 then 1 else 0 end as DUM_PHYS_SPEC43,
						case when PHYS_SPEC44 > 0 then 1 else 0 end as DUM_PHYS_SPEC44,
						case when PHYS_SPEC46 > 0 then 1 else 0 end as DUM_PHYS_SPEC46,
						case when PHYS_SPEC48 > 0 then 1 else 0 end as DUM_PHYS_SPEC48,
						case when PHYS_SPEC50 > 0 then 1 else 0 end as DUM_PHYS_SPEC50,
						case when PHYS_SPEC62 > 0 then 1 else 0 end as DUM_PHYS_SPEC62,
						case when PHYS_SPEC64 > 0 then 1 else 0 end as DUM_PHYS_SPEC64,
						case when PHYS_SPEC65 > 0 then 1 else 0 end as DUM_PHYS_SPEC65,
						case when PHYS_SPEC66 > 0 then 1 else 0 end as DUM_PHYS_SPEC66,
						case when PHYS_SPEC67 > 0 then 1 else 0 end as DUM_PHYS_SPEC67,
						case when PHYS_SPEC68 > 0 then 1 else 0 end as DUM_PHYS_SPEC68,
						case when PHYS_SPEC71 > 0 then 1 else 0 end as DUM_PHYS_SPEC71,
						case when PHYS_SPEC72 > 0 then 1 else 0 end as DUM_PHYS_SPEC72,
						case when PHYS_SPEC76 > 0 then 1 else 0 end as DUM_PHYS_SPEC76,
						case when PHYS_SPEC77 > 0 then 1 else 0 end as DUM_PHYS_SPEC77,
						case when PHYS_SPEC78 > 0 then 1 else 0 end as DUM_PHYS_SPEC78,
						case when PHYS_SPEC79 > 0 then 1 else 0 end as DUM_PHYS_SPEC79,
						case when PHYS_SPEC80 > 0 then 1 else 0 end as DUM_PHYS_SPEC80,
						case when PHYS_SPEC81 > 0 then 1 else 0 end as DUM_PHYS_SPEC81,
						case when PHYS_SPEC82 > 0 then 1 else 0 end as DUM_PHYS_SPEC82,
						case when PHYS_SPEC83 > 0 then 1 else 0 end as DUM_PHYS_SPEC83,
						case when PHYS_SPEC84 > 0 then 1 else 0 end as DUM_PHYS_SPEC84,
						case when PHYS_SPEC85 > 0 then 1 else 0 end as DUM_PHYS_SPEC85,
						case when PHYS_SPEC86 > 0 then 1 else 0 end as DUM_PHYS_SPEC86,
						case when PHYS_SPEC88 > 0 then 1 else 0 end as DUM_PHYS_SPEC88,
						case when PHYS_SPEC89 > 0 then 1 else 0 end as DUM_PHYS_SPEC89,
						case when PHYS_SPEC90 > 0 then 1 else 0 end as DUM_PHYS_SPEC90,
						case when PHYS_SPEC91 > 0 then 1 else 0 end as DUM_PHYS_SPEC91,
						case when PHYS_SPEC92 > 0 then 1 else 0 end as DUM_PHYS_SPEC92,
						case when PHYS_SPEC93 > 0 then 1 else 0 end as DUM_PHYS_SPEC93,
						case when PHYS_SPEC94 > 0 then 1 else 0 end as DUM_PHYS_SPEC94,
						case when PHYS_SPEC97 > 0 then 1 else 0 end as DUM_PHYS_SPEC97,
						case when PHYS_SPEC98 > 0 then 1 else 0 end as DUM_PHYS_SPEC98,
						case when PHYS_SPEC99 > 0 then 1 else 0 end as DUM_PHYS_SPEC99,
						case when PHYS_SPECC0 > 0 then 1 else 0 end as DUM_PHYS_SPECC0
	from pro2013_11
	group by ACO_NUM;
quit;




/****************************** STEP 2: Groups by specialty *****************************/

/* Create reduced dataset from 2013 Provider file with only TIN, NPI, ACO_NUM, and PRVDR_SPCLTY_CD.
   Also, create new ID var with which to transpose data in a couple of steps.*/
data pro2013_2;
	set pro2013;
	keep TIN NPI ACO_NUM PRVDR_SPCLTY_CD id;
	id = _N_;
run;

proc sql;
	create table pro2013_2_temp as
		select * from pro2013_2 where NPI is not null;			*<-- want to only count practices where where a physician is present;
quit;

/* use PROC TRANSPOSE to reshape data from a long format to a wide format. */
proc sort data=pro2013_2_temp; by ACO_NUM id PRVDR_SPCLTY_CD TIN;
proc transpose data=pro2013_2_temp
			   out=pro2013_2
			   prefix=GRP_SPEC; 
	by ACO_NUM id;
	id PRVDR_SPCLTY_CD;
	var TIN;
run;
*note: "11722 observations ommitted due to missing ID value" 
11722 rows represented practices or groups that weren't recorded a specialty, 
**oddly, regardless, the same amount of rows are outputted as inputted...;

/* drop "id", "_LABEL_", and "_NAME_" */
data pro2013_2;
	set pro2013_2;
	drop id _NAME_ _LABEL_;
run;

/* Use PROC SQL to count all TINs associated with every ACO_NUM for each specialty */
proc sql;
	create table pro2013_21 as
		select ACO_NUM, count(distinct GRP_SPEC01) as GRP_SPEC01, count(distinct GRP_SPEC02) as GRP_SPEC02,
			count(distinct GRP_SPEC03) as GRP_SPEC03, count(distinct GRP_SPEC04) as GRP_SPEC04,
			count(distinct GRP_SPEC05) as GRP_SPEC05, count(distinct GRP_SPEC06) as GRP_SPEC06, count(distinct GRP_SPEC07) as GRP_SPEC07,
			count(distinct GRP_SPEC08) as GRP_SPEC08, count(distinct GRP_SPEC09) as GRP_SPEC09, count(distinct GRP_SPEC10) as GRP_SPEC10,
			count(distinct GRP_SPEC11) as GRP_SPEC11, count(distinct GRP_SPEC12) as GRP_SPEC12, count(distinct GRP_SPEC13) as GRP_SPEC13,
			count(distinct GRP_SPEC14) as GRP_SPEC14, count(distinct GRP_SPEC15) as GRP_SPEC15, count(distinct GRP_SPEC16) as GRP_SPEC16,
			count(distinct GRP_SPEC17) as GRP_SPEC17, count(distinct GRP_SPEC18) as GRP_SPEC18, count(distinct GRP_SPEC19) as GRP_SPEC19,
			count(distinct GRP_SPEC20) as GRP_SPEC20, count(distinct GRP_SPEC21) as GRP_SPEC21, count(distinct GRP_SPEC22) as GRP_SPEC22,
			count(distinct GRP_SPEC23) as GRP_SPEC23, count(distinct GRP_SPEC24) as GRP_SPEC24, count(distinct GRP_SPEC25) as GRP_SPEC25,
			count(distinct GRP_SPEC26) as GRP_SPEC26, count(distinct GRP_SPEC27) as GRP_SPEC27, count(distinct GRP_SPEC28) as GRP_SPEC28,
			count(distinct GRP_SPEC29) as GRP_SPEC29, count(distinct GRP_SPEC30) as GRP_SPEC30, count(distinct GRP_SPEC32) as GRP_SPEC32,
			count(distinct GRP_SPEC33) as GRP_SPEC33, count(distinct GRP_SPEC34) as GRP_SPEC34, count(distinct GRP_SPEC35) as GRP_SPEC35,
			count(distinct GRP_SPEC36) as GRP_SPEC36, count(distinct GRP_SPEC37) as GRP_SPEC37, count(distinct GRP_SPEC38) as GRP_SPEC38,
			count(distinct GRP_SPEC39) as GRP_SPEC39, count(distinct GRP_SPEC40) as GRP_SPEC40, count(distinct GRP_SPEC41) as GRP_SPEC41,
			count(distinct GRP_SPEC42) as GRP_SPEC42, count(distinct GRP_SPEC43) as GRP_SPEC43, count(distinct GRP_SPEC44) as GRP_SPEC44,
			count(distinct GRP_SPEC46) as GRP_SPEC46, count(distinct GRP_SPEC48) as GRP_SPEC48, count(distinct GRP_SPEC50) as GRP_SPEC50,
			count(distinct GRP_SPEC62) as GRP_SPEC62, count(distinct GRP_SPEC64) as GRP_SPEC64, count(distinct GRP_SPEC65) as GRP_SPEC65,
			count(distinct GRP_SPEC66) as GRP_SPEC66, count(distinct GRP_SPEC67) as GRP_SPEC67, count(distinct GRP_SPEC68) as GRP_SPEC68,
			count(distinct GRP_SPEC71) as GRP_SPEC71, count(distinct GRP_SPEC72) as GRP_SPEC72, count(distinct GRP_SPEC76) as GRP_SPEC76,
			count(distinct GRP_SPEC77) as GRP_SPEC77, count(distinct GRP_SPEC78) as GRP_SPEC78, count(distinct GRP_SPEC79) as GRP_SPEC79,
			count(distinct GRP_SPEC80) as GRP_SPEC80, count(distinct GRP_SPEC81) as GRP_SPEC81, count(distinct GRP_SPEC82) as GRP_SPEC82,
			count(distinct GRP_SPEC83) as GRP_SPEC83, count(distinct GRP_SPEC84) as GRP_SPEC84, count(distinct GRP_SPEC85) as GRP_SPEC85,
			count(distinct GRP_SPEC86) as GRP_SPEC86, count(distinct GRP_SPEC88) as GRP_SPEC88, count(distinct GRP_SPEC89) as GRP_SPEC89,
			count(distinct GRP_SPEC90) as GRP_SPEC90, count(distinct GRP_SPEC91) as GRP_SPEC91, count(distinct GRP_SPEC92) as GRP_SPEC92,
			count(distinct GRP_SPEC93) as GRP_SPEC93, count(distinct GRP_SPEC94) as GRP_SPEC94, count(distinct GRP_SPEC97) as GRP_SPEC97,
			count(distinct GRP_SPEC98) as GRP_SPEC98, count(distinct GRP_SPEC99) as GRP_SPEC99, count(distinct GRP_SPECC0) as GRP_SPECC0
	from pro2013_2
	group by ACO_NUM;
quit;




/****************************** STEP 3: Grouped PCPs, nurse practitioners, and Radiologists *****************************/

/* Create dummies for the grouped specialties to use for counts and an indicator of presence in a subsequent data/proc step. */
data pro2013_3;
	set pro2013;
	keep ACO_NUM NPI dum_rad dum_PCP dum_NP dum_other;
	if PRVDR_SPCLTY_CD in ("30", "92", "94") then dum_rad = 1;
		else if PRVDR_SPCLTY_CD not in ("30", "92", "94") then dum_rad = 0;
	if PRVDR_SPCLTY_CD in ("01", "08", "11", "38") then dum_PCP = 1;
		else if PRVDR_SPCLTY_CD not in ("01", "08", "11", "38") then dum_PCP = 0;
	if PRVDR_SPCLTY_CD = "50" then dum_NP = 1;
		else if PRVDR_SPCLTY_CD ne "50" then dum_NP = 0;
	if PRVDR_SPCLTY_CD in ("30", "92", "94", "01", "08", "11", "38", "50") then dum_other = 0;
		else if PRVDR_SPCLTY_CD not in ("30", "92", "94", "01", "08", "11", "38", "50") and 
			PRVDR_SPCLTY_CD ne " " then dum_other = 1;
run;

proc sql;
	create table pro2013_31 as
		select ACO_NUM, count(distinct NPI) as RADs from pro2013_3 where dum_rad = 1
		group by ACO_NUM;
quit;																								***<--- missing rows - need to account for the rest with 0s;

proc sql;
	create table pro2013_32 as
		select ACO_NUM, count(distinct NPI) as PCPs from pro2013_3 where dum_PCP = 1
		group by ACO_NUM;
quit;

proc sql;
	create table pro2013_33 as
		select ACO_NUM, count(distinct NPI) as NPs from pro2013_3 where dum_NP = 1
		group by ACO_NUM;
quit;																								***<--- missing rows - need to account for the rest with 0s;

proc sql;
	create table pro2013_34 as
		select ACO_NUM, count(distinct NPI) as Others from pro2013_3 where dum_other = 1
		group by ACO_NUM;
quit;


/* Merge the three datasets to get three columns with the counts for each of the specialty groupings for each ACO. */
proc sql;
	create table ACO_NUM_list as
		select distinct ACO_NUM from t1.provider_aco_ssp_2013;
quit;																	   	   ***<---provides all ACO_NUMs so those w/o a PCP, Rad, Other, or NP still get their '0' vs. a '.'; 

proc sort data=pro2013_31; by ACO_NUM; run;
proc sort data=pro2013_32; by ACO_NUM; run;
proc sort data=pro2013_33; by ACO_NUM; run;
proc sort data=pro2013_34; by ACO_NUM; run;
proc sort data=ACO_NUM_list; by ACO_NUM; run;
data pro2013_35;
	merge ACO_NUM_list pro2013_31 pro2013_32 pro2013_33 pro2013_34;
	by ACO_NUM;
run;

/* Insert 0s for missing values for (all numeric variables) Rads and NPs.  */
data pro2013_35;
   set pro2013_35;
   array change _numeric_;
        do over change;
            if change=. then change=0;
        end;
run;

/* Create indicator columns for the specialty groupings */
proc sql;
	create table pro2013_36 as
		select *, case when RADs > 0 then 1 else 0 end as DUM_RADs,
				  case when PCPs > 0 then 1 else 0 end as DUM_PCPs,
				  case when NPs > 0 then 1 else 0 end as DUM_NPs,
				  case when Others > 0 then 1 else 0 end as DUM_Others
		from pro2013_35;
quit;




/****************************** STEP 4: Hospitals in ACO *****************************/




/****************************** STEP 5: 2013 Masterfile *****************************/

/* Combine the datasets for 2013 Masterfile */
proc sort data=pro2013_12; by ACO_NUM; run;
proc sort data=pro2013_21; by ACO_NUM; run;
proc sort data=pro2013_36; by ACO_NUM; run;
data t3.pro2013;
	merge pro2013_12 pro2013_21 pro2013_36;
	by ACO_NUM;
run;




