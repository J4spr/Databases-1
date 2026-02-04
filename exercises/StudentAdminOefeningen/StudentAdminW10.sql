-- oef 1
CREATE INDEX IF NOT EXISTS ind_section_id_grade_type_code
ON grades (section_id, grade_type_code);

