DROP TABLE IF EXISTS public.nymaster;

CREATE TABLE IF NOT EXISTS public.nymaster (
	testdate date NOT NULL,
	county varchar(20) NOT NULL,
	newpositives int4 NULL,
	cummpositives int4 NULL,
	totaltests int4 NULL,
	cummtests int4 NULL,
	testpositive varchar(20) NULL,
	geography varchar(20) NULL,
	loaddate date NULL
);