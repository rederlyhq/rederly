INSERT INTO public.curriculum(
	curriculum_id,
	university_id,
	curriculum_name,
	curriculum_textbooks,
	curriculum_subject,
	curriculum_comment,
	curriculum_active,
	curriculum_public,
	created_at,
	updated_at
)
VALUES (
	default, -- curriculum_id,
	1, -- university_id,
	'Blank', -- curriculum_name,
	'', -- curriculum_textbooks,
	'', -- curriculum_subject,
	'', -- curriculum_comment,
	true, -- curriculum_active,
	false, -- curriculum_public,
	NOW(), -- created_at,
	NOW() -- updated_at
) RETURNING *;
