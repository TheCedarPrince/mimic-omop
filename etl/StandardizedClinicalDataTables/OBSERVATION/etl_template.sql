 WITH chartevents AS (SELECT row_id as observation_id, subject_id as person_id, charttime::date as observation_date, charttime as observation_datetime,  as value_as_number,  as value_as_string, cgid as provider_id, hadm_id as visit_occurrence_id, itemid as visit_detail_id, itemid as observation_source_concept_id, valueuom as unit_source_value FROM mimic.chartevents),
d_items AS (SELECT label as observation_source_value FROM mimic.d_items) 
 INSERT INTO omop.OBSERVATION (observation_id, person_id, observation_date, observation_datetime, value_as_number, value_as_string, provider_id, visit_occurrence_id, visit_detail_id, observation_source_concept_id, unit_source_value, observation_source_value)
 SELECT chartevents.observation_id, chartevents.person_id, chartevents.observation_date, chartevents.observation_datetime, chartevents.value_as_number, chartevents.value_as_string, chartevents.provider_id, chartevents.visit_occurrence_id, chartevents.visit_detail_id, d_items.observation_source_value, chartevents.observation_source_concept_id, chartevents.unit_source_value 
FROM chartevents
 LEFT JOIN d_items USING () 