-- ============================================================
-- Seed data: the current roster, so trips/incidents/med reimb
-- requests for these residents don't fail with a missing-
-- resident error before anyone has edited them in the app.
-- Safe to re-run -- existing residents are left untouched.
-- ============================================================
insert into residents (id, name, dob, admit_date, phase, pv, sv, sponsor, edu, program, loc, insurance, active)
values
  ('MW-4334', 'Alvarez, Marissa', '1988-02-12', '2026-04-10', 'SL', 'Rey', 'Nicole', 'Marci', 'Associates', 'MAT', 'Alas Nuevas', NULL, true),
  ('MW-4341', 'Avvocato, Sage', '2001-02-14', '2026-05-08', 'SL', 'Amara', 'Victoria', 'Tracey', 'N/A', 'BHRTC/MAT', 'Alas Nuevas', NULL, true),
  ('MW-4308', 'Callines, Kionna', '1991-01-31', '2026-01-13', 'SL', 'Nina', 'Nicole', 'Desirae', 'Associates', 'SL', 'Yandell', NULL, true),
  ('SV-4383', 'Darby, Kane', '1974-01-25', '2026-07-22', '90 Day', 'Amara', 'Victoria', 'Christine Z', 'N/A', 'BHRTC', 'Alas Nuevas', NULL, true),
  ('SV-4238', 'Elias, Miranda', '1996-11-15', '2026-06-15', '90 Day', 'Paul', 'Sanders', 'Liz N', 'Some College', 'MAT', 'Alas Nuevas', NULL, true),
  ('SV-4317', 'Fredrickson, Destiny', '1992-08-04', '2026-03-20', 'SL', 'Amara', 'Sanders', 'Katie', 'GED', 'ARPA', 'Yandell', NULL, true),
  ('SV-3531', 'Hill, Samantha', '1968-08-27', '2025-11-19', 'SL', 'Amara', 'Claudia', 'Gina', 'Bachelors', 'ARPA', 'Yandell', NULL, true),
  ('SV-4401', 'Leu, Monica', '1989-04-05', '2026-08-28', '90 Day', 'Amara', 'Nicole', '—', 'N/A', 'BHRTC', 'Alas Nuevas', NULL, true),
  ('MW-4259', 'Lopez, Angelica', '1996-03-03', '2026-02-18', 'SL', 'Paul', 'Nicole', 'Val', 'Bachelors', 'SL', 'Yandell', NULL, true),
  ('SV-4361', 'Monarez, Alexis', '1998-07-12', '2026-06-12', '90 Day', 'Nina', 'Sanders', 'Christine Z', 'Vocational', 'ARPA', 'Alas Nuevas', NULL, true),
  ('MW-4397', 'Orozco, Martha', '1968-07-29', '2026-08-24', '90 Day', 'Nina', 'Ruben', '—', 'N/A', 'MAT', 'Alas Nuevas', NULL, true),
  ('MW-4344', 'Pinales, Riki', '1997-12-16', '2026-05-12', '90 Day', 'Amara', 'Victoria', '—', 'Diploma', 'MAT', 'Alas Nuevas', NULL, true),
  ('MW-4251', 'Reyes, Alexis', '1990-11-23', '2026-08-24', '90 Day', 'Nina', 'Ruben', '—', 'Some College', 'MAT', 'Alas Nuevas', NULL, true),
  ('SV-4278', 'Sias, Melissa', '1982-07-18', '2026-01-06', 'SL', 'Rey', 'Sanders', 'Cynthia', 'GED', 'ARPA', 'Alas Nuevas', NULL, true),
  ('SV-4351', 'Solomon, Jasmine', '1997-07-17', '2026-05-20', 'SL', 'Amara', 'Victoria', 'Monica', 'Diploma', 'ARPA', 'Alas Nuevas', NULL, true),
  ('SV-4074', 'Soto, Jacqueline', '1988-05-07', '2026-05-15', '90 Day', 'Rey', 'Victoria', 'Liz N', 'Some College', 'SV', 'Alas Nuevas', NULL, true),
  ('W-3651', 'Stogden, Ernestina', '1970-07-07', '2022-07-15', 'SL', NULL, 'Sanders', 'Elena', 'GED', NULL, 'Yandell', NULL, true),
  ('SV-4385', 'Sunderman, Tammy', '1972-06-18', '2026-07-29', '90 Day', 'Amara', 'Sanders', 'Patty', 'Some College', 'BHRTC', 'Alas Nuevas', NULL, true),
  ('MW-4340', 'Ulloa, Isabel', '1989-05-27', '2026-05-08', '90 Day', 'Amara', 'Victoria', 'Christine Z', 'GED', 'BHRTC/MAT', 'Alas Nuevas', NULL, true),
  ('SV-4188', 'Weaver, Alene', '1992-06-07', '2025-06-18', 'SL', 'Rey', 'Sanders', 'Andrea', 'Diploma', 'SV', 'Yandell', NULL, true),
  ('SV-3615', 'Williams, Hanifah', '1985-10-30', '2025-12-12', 'SL', 'Amara', 'Nicole', 'Rosie', 'N/A', 'ARPA', 'Yandell', NULL, true)
on conflict (id) do nothing;
