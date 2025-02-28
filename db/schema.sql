create schema if not exists groupscholar_nudge_metrics_mart;

create table if not exists groupscholar_nudge_metrics_mart.channels (
  channel_id serial primary key,
  name text not null unique,
  description text,
  created_at timestamptz not null default now()
);

create table if not exists groupscholar_nudge_metrics_mart.cohorts (
  cohort_id serial primary key,
  cohort_name text not null unique,
  start_date date not null,
  region text not null,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists groupscholar_nudge_metrics_mart.nudges (
  nudge_id serial primary key,
  cohort_id integer not null references groupscholar_nudge_metrics_mart.cohorts(cohort_id),
  channel_id integer not null references groupscholar_nudge_metrics_mart.channels(channel_id),
  nudge_type text not null,
  message_theme text not null,
  sender text not null,
  sent_at timestamptz not null,
  audience_size integer not null check (audience_size >= 0),
  followup_due_date date,
  status text not null default 'sent',
  created_at timestamptz not null default now()
);

create table if not exists groupscholar_nudge_metrics_mart.responses (
  response_id serial primary key,
  nudge_id integer not null references groupscholar_nudge_metrics_mart.nudges(nudge_id),
  response_at timestamptz not null,
  response_type text not null,
  sentiment text not null,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists groupscholar_nudge_metrics_mart.action_items (
  action_item_id serial primary key,
  nudge_id integer not null references groupscholar_nudge_metrics_mart.nudges(nudge_id),
  owner text not null,
  due_date date not null,
  status text not null,
  completed_at date,
  notes text,
  created_at timestamptz not null default now()
);

create index if not exists nudges_sent_at_idx
  on groupscholar_nudge_metrics_mart.nudges(sent_at);

create index if not exists responses_nudge_id_idx
  on groupscholar_nudge_metrics_mart.responses(nudge_id);

create index if not exists action_items_status_idx
  on groupscholar_nudge_metrics_mart.action_items(status);
