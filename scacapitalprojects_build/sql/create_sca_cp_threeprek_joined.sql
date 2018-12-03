-- creating temp table for pre k capacity projects for sca_cp_capacity_projects
DROP TABLE IF EXISTS sca_cp_threeprek_joined;
CREATE TABLE sca_cp_threeprek_joined AS (
	SELECT a.existingsiteidentified, 
		a.proposedleasedfacility, 
		a.forecastcapacity,
		a.district, 
		a.school, 
		a.projectnum, 
		'pre-k capacity projects'::text AS description, 
		b.location, 
		b.latitude, 
		b.longitude, 
		a.actualestcompl, 
		(CASE 
			WHEN (LEFT(a.actualestcompl,2)) IN ('07','08', '09', '10', '11', '12') THEN RIGHT(a.actualestcompl,4)::integer+1
			ELSE RIGHT(a.actualestcompl,4)::integer
		END) AS fy,
		a.designstart, 
		a.constrstart, 
		a.totalestcost, 
		a.previousappropriations, 
		a.fundingreqdfy1519, 
		a.neededtocomplete,
		'sca_cp_prek_schools'::text AS source
	FROM sca_cp_threeprek_schools a
	LEFT JOIN sca_cp_threeprek_location b
	ON a.school = b.school);