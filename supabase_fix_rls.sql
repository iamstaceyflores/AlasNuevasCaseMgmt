-- ============================================================
-- Temporary fix: allow saves to work before staff login exists.
-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run
--
-- The original policies required a signed-in ("authenticated") user,
-- but the app doesn't have a login screen yet, so every save was
-- being silently rejected. This opens read/write to anyone with the
-- app link for now. Once staff login is added, we'll tighten this
-- back down to real accounts only.
-- ============================================================

drop policy if exists "staff full access" on residents;
drop policy if exists "staff full access" on rc_checks;
drop policy if exists "staff full access" on feed_entries;
drop policy if exists "staff full access" on trips;
drop policy if exists "staff full access" on incidents;
drop policy if exists "staff full access" on med_reimb_requests;
drop policy if exists "staff full access" on shift_notes;

create policy "open access (temporary, until login is added)" on residents
  for all using (true) with check (true);
create policy "open access (temporary, until login is added)" on rc_checks
  for all using (true) with check (true);
create policy "open access (temporary, until login is added)" on feed_entries
  for all using (true) with check (true);
create policy "open access (temporary, until login is added)" on trips
  for all using (true) with check (true);
create policy "open access (temporary, until login is added)" on incidents
  for all using (true) with check (true);
create policy "open access (temporary, until login is added)" on med_reimb_requests
  for all using (true) with check (true);
create policy "open access (temporary, until login is added)" on shift_notes
  for all using (true) with check (true);
