INSERT INTO public.university(
  university_id,
  university_active,
  university_name,
  university_prof_email_domain,
  university_student_email_domain,
  university_verify_institutional_email,
  created_at,
  updated_at,
  university_paid_until
)
  VALUES
(
  DEFAULT, -- university_id
  DEFAULT, -- university_active
  'Rederly', -- university_name
  'prof.rederly.com', -- university_prof_email_domain
  'stu.rederly.com', -- university_student_email_domain
  false, -- university_verify_institutional_email
  NOW(), -- created_at
  NOW(), -- updated_at
  '1/1/2222' -- university_paid_until
) RETURNING *;