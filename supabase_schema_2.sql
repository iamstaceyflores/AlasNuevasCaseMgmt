-- ============================================================
-- Alas Nuevas Case Management — initial Supabase schema
-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run
-- ============================================================

-- ---------- RESIDENTS / ROSTER ----------
create table if not exists residents (
  id              text primary key,        -- e.g. "MW-4334"
  name            text not null,
  dob             date,
  admit_date      date,
  phase           text,
  pv              text,
  sv              text,
  sponsor         text,
  edu             text,
  program         text,
  loc             text,
  insurance       text,
  active          boolean not null default true,
  discharge_date  date,
  discharge_reason text,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

-- ---------- RC CHECK LOG (time-slot check-ins on the roster tab) ----------
create table if not exists rc_checks (
  id            bigint generated always as identity primary key,
  resident_id   text not null references residents(id) on delete cascade,
  log_date      date not null default current_date,
  slot_index    int not null,
  slot_label    text,
  code          text,
  staff         text,
  updated_at    timestamptz not null default now(),
  unique (resident_id, log_date, slot_index)
);

-- ---------- ACTIVITY FEED (live feed of RC check-ins) ----------
create table if not exists feed_entries (
  id            bigint generated always as identity primary key,
  created_at    timestamptz not null default now(),
  resident_id   text references residents(id) on delete set null,
  resident_name text,
  staff         text,
  code          text,
  slot_label    text
);

-- ---------- TRANSPORT / TRIPS ----------
create table if not exists trips (
  numeric_id   bigint generated always as identity primary key,
  id           text generated always as ('T-' || numeric_id) stored,
  resident_id  text not null references residents(id) on delete cascade,
  destination  text,
  trip_date    date,
  trip_time    text,
  phone        text,
  visit        text,
  uber_status  text,
  notes        text,
  created_at   timestamptz not null default now()
);

-- ---------- INCIDENT REPORTS ----------
create table if not exists incidents (
  numeric_id      bigint generated always as identity primary key,
  id              text generated always as ('IR-' || numeric_id) stored,
  incident_date   date,
  incident_time   text,
  names_involved  text,
  resident_ids    text[] default '{}',
  observer        text,
  types           text[] default '{}',
  other_text      text,
  description     text,
  med_errors      text[] default '{}',
  actions_taken   text[] default '{}',
  completed_by    text,
  submitted_at    timestamptz not null default now(),
  emailed         boolean not null default false,
  emailed_at      timestamptz
);

-- ---------- MED REIMBURSEMENT REQUESTS ----------
create table if not exists med_reimb_requests (
  numeric_id        bigint generated always as identity primary key,
  id                text generated always as ('MR-' || numeric_id) stored,
  last              text,
  first             text,
  mi                text,
  resident_id       text references residents(id) on delete set null,
  dob               date,
  so                text,
  gender            text,
  referral_date     date,
  release_date      date,
  status            text,
  ref_agency        text,
  ref_external_text text,
  ref_contact       text,
  ref_phone         text,
  ref_email         text,
  client_phone      text,
  client_email      text,
  emergency_contact text,
  urgency           text,
  services          text[] default '{}',
  service_other_text text,
  cost_estimate     text,
  vendor            text,
  cost_type         text,
  insurance_status  text,
  doc_confirm       text[] default '{}',
  justice_involved  text,
  co_occurring      text,
  comments          text,
  approval          text,
  approved_amount   text,
  coord_name        text,
  coord_signature   text,
  coord_date        date,
  coord_notes       text,
  submitted_at      timestamptz not null default now()
);

-- ---------- SHIFT NOTES ----------
create table if not exists shift_notes (
  numeric_id    bigint generated always as identity primary key,
  id            text generated always as ('SN-' || numeric_id) stored,
  note_date     date,
  note_time     text,
  staff         text,
  observations  text,
  submitted_at  timestamptz not null default now()
);

-- ============================================================
-- Row Level Security — only signed-in staff can read/write.
-- (Everyone who logs in currently has full access to everything;
-- this can be split by role/program later once basic sync works.)
-- ============================================================
alter table residents          enable row level security;
alter table rc_checks          enable row level security;
alter table feed_entries       enable row level security;
alter table trips              enable row level security;
alter table incidents          enable row level security;
alter table med_reimb_requests enable row level security;
alter table shift_notes        enable row level security;

create policy "staff full access" on residents
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "staff full access" on rc_checks
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "staff full access" on feed_entries
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "staff full access" on trips
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "staff full access" on incidents
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "staff full access" on med_reimb_requests
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
create policy "staff full access" on shift_notes
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

-- ============================================================
-- Realtime — let the app get live updates when someone else saves.
-- ============================================================
alter publication supabase_realtime add table residents;
alter publication supabase_realtime add table rc_checks;
alter publication supabase_realtime add table feed_entries;
alter publication supabase_realtime add table trips;
alter publication supabase_realtime add table incidents;
alter publication supabase_realtime add table med_reimb_requests;
alter publication supabase_realtime add table shift_notes;
