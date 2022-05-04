DROP TABLE IF EXISTS public.ny_{{ params.countyname }};

CREATE TABLE IF NOT EXISTS public.ny_{{ params.countyname }} (
	testdate date NOT NULL,
	newpositives int4 NULL,
	cummpositives int4 NULL,
	totaltests int4 NULL,
	cummtests int4 NULL,
	testpositive varchar(20) NULL,
	geography varchar(20) NULL,
	loaddate date NULL
);

