CREATE TABLE IF NOT EXISTS public.nymaster (
	testdate date NOT NULL,
	county varchar(20) NOT NULL,
	newpositives int4 NULL,
	cummpositives int4 NULL,
	totaltests int4 NULL,
	cummtests int4 NULL,
	loaddate date NULL
);

CREATE TABLE IF NOT EXISTS public.ny_{{ params.countyname }} (
	testdate date NOT NULL,
	newpositives int4 NULL,
	cummpositives int4 NULL,
	totaltests int4 NULL,
	cummtests int4 NULL,
	loaddate date NULL
);

