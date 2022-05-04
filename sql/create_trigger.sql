create or replace
function public.nymaster_insert_trigger() returns trigger language plpgsql as $function$ begin if ( NEW.county = 'Albany' ) then
insert
	into
	ny_Albany
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Allegany' ) then
insert
	into
	ny_Allegany
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Bronx' ) then
insert
	into
	ny_Bronx
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Broome' ) then
insert
	into
	ny_Broome
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Cattaraugus' ) then
insert
	into
	ny_Cattaraugus
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Cayuga' ) then
insert
	into
	ny_Cayuga
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Chautauqua' ) then
insert
	into
	ny_Chautauqua
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Chemung' ) then
insert
	into
	ny_Chemung
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Chenango' ) then
insert
	into
	ny_Chenango
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Clinton' ) then
insert
	into
	ny_Clinton
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Columbia' ) then
insert
	into
	ny_Columbia
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Cortland' ) then
insert
	into
	ny_Cortland
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Delaware' ) then
insert
	into
	ny_Delaware
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Dutchess' ) then
insert
	into
	ny_Dutchess
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Erie' ) then
insert
	into
	ny_Erie
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Essex' ) then
insert
	into
	ny_Essex
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Franklin' ) then
insert
	into
	ny_Franklin
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Fulton' ) then
insert
	into
	ny_Fulton
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Genesee' ) then
insert
	into
	ny_Genesee
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Greene' ) then
insert
	into
	ny_Greene
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Hamilton' ) then
insert
	into
	ny_Hamilton
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Herkimer' ) then
insert
	into
	ny_Herkimer
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Jefferson' ) then
insert
	into
	ny_Jefferson
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Kings' ) then
insert
	into
	ny_Kings
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Lewis' ) then
insert
	into
	ny_Lewis
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Livingston' ) then
insert
	into
	ny_Livingston
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Madison' ) then
insert
	into
	ny_Madison
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Monroe' ) then
insert
	into
	ny_Monroe
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Montgomery' ) then
insert
	into
	ny_Montgomery
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Nassau' ) then
insert
	into
	ny_Nassau
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'New York' ) then
insert
	into
	ny_NewYork
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Niagara' ) then
insert
	into
	ny_Niagara
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Oneida' ) then
insert
	into
	ny_Oneida
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Onondaga' ) then
insert
	into
	ny_Onondaga
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Ontario' ) then
insert
	into
	ny_Ontario
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Orange' ) then
insert
	into
	ny_Orange
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Orleans' ) then
insert
	into
	ny_Orleans
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Oswego' ) then
insert
	into
	ny_Oswego
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Otsego' ) then
insert
	into
	ny_Otsego
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Putnam' ) then
insert
	into
	ny_Putnam
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Queens' ) then
insert
	into
	ny_Queens
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Rensselaer' ) then
insert
	into
	ny_Rensselaer
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Richmond' ) then
insert
	into
	ny_Richmond
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Rockland' ) then
insert
	into
	ny_Rockland
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Saratoga' ) then
insert
	into
	ny_Saratoga
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Schenectady' ) then
insert
	into
	ny_Schenectady
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Schoharie' ) then
insert
	into
	ny_Schoharie
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Schuyler' ) then
insert
	into
	ny_Schuyler
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Seneca' ) then
insert
	into
	ny_Seneca
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'St. Lawrence' ) then
insert
	into
	ny_StLawrence
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Steuben' ) then
insert
	into
	ny_Steuben
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Suffolk' ) then
insert
	into
	ny_Suffolk
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Sullivan' ) then
insert
	into
	ny_Sullivan
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Tioga' ) then
insert
	into
	ny_Tioga
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Tompkins' ) then
insert
	into
	ny_Tompkins
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Ulster' ) then
insert
	into
	ny_Ulster
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Warren' ) then
insert
	into
	ny_Warren
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Washington' ) then
insert
	into
	ny_Washington
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Wayne' ) then
insert
	into
	ny_Wayne
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Westchester' ) then
insert
	into
	ny_Westchester
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Wyoming' ) then
insert
	into
	ny_Wyoming
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);

elseif ( NEW.county = 'Yates' ) then
insert
	into
	ny_Yates
values (NEW.testdate, new.newpositives, new.cummpositives, new.totaltests, new.cummtests, new.testpositive, new.geography, new.loaddate);
else return new;
end if;

return null;
end;

$function$ ;

DROP TRIGGER IF EXISTS insert_nymaster_trigger on public.nymaster;

CREATE TRIGGER insert_nymaster_trigger
    AFTER INSERT
    ON public.nymaster
    FOR EACH ROW
        EXECUTE PROCEDURE public.nymaster_insert_trigger();


