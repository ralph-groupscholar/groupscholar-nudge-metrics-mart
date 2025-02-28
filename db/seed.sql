insert into groupscholar_nudge_metrics_mart.channels (name, description)
values
  ('email', 'Operational email outreach'),
  ('sms', 'Short text nudges'),
  ('whatsapp', 'WhatsApp check-ins'),
  ('in_app', 'In-app alerts')
on conflict (name) do nothing;

insert into groupscholar_nudge_metrics_mart.cohorts (cohort_name, start_date, region, notes)
values
  ('Fall 2025 Scholars', '2025-08-15', 'Northeast', 'First-gen focus cohort'),
  ('Spring 2026 Scholars', '2026-01-20', 'Midwest', 'Transfer student cohort'),
  ('STEM Bridge 2025', '2025-06-05', 'South', 'Bridge program for STEM scholars')
on conflict (cohort_name) do nothing;

insert into groupscholar_nudge_metrics_mart.nudges
  (cohort_id, channel_id, nudge_type, message_theme, sender, sent_at, audience_size, followup_due_date, status)
values
  ((select cohort_id from groupscholar_nudge_metrics_mart.cohorts where cohort_name = 'Fall 2025 Scholars'),
   (select channel_id from groupscholar_nudge_metrics_mart.channels where name = 'email'),
   're_enrollment', 'FAFSA reminder', 'ops@groupscholar.com', '2026-01-12 14:00:00+00', 84, '2026-01-20', 'sent'),
  ((select cohort_id from groupscholar_nudge_metrics_mart.cohorts where cohort_name = 'Spring 2026 Scholars'),
   (select channel_id from groupscholar_nudge_metrics_mart.channels where name = 'sms'),
   'check_in', 'Welcome back check-in', 'coach@groupscholar.com', '2026-01-25 18:30:00+00', 65, '2026-01-30', 'sent'),
  ((select cohort_id from groupscholar_nudge_metrics_mart.cohorts where cohort_name = 'STEM Bridge 2025'),
   (select channel_id from groupscholar_nudge_metrics_mart.channels where name = 'whatsapp'),
   'academic', 'Midterm support', 'mentor@groupscholar.com', '2025-10-10 16:15:00+00', 42, '2025-10-15', 'sent');

insert into groupscholar_nudge_metrics_mart.responses
  (nudge_id, response_at, response_type, sentiment, notes)
values
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'FAFSA reminder'),
   '2026-01-12 17:05:00+00', 'reply', 'positive', 'Submitted FAFSA, thanks!'),
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'FAFSA reminder'),
   '2026-01-12 21:40:00+00', 'reply', 'neutral', 'Working on it this week.'),
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'Welcome back check-in'),
   '2026-01-25 19:10:00+00', 'reply', 'positive', 'All set for the term.'),
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'Midterm support'),
   '2025-10-10 19:45:00+00', 'reply', 'concerned', 'Need tutoring in calculus.');

insert into groupscholar_nudge_metrics_mart.action_items
  (nudge_id, owner, due_date, status, completed_at, notes)
values
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'FAFSA reminder'),
   'ops@groupscholar.com', '2026-01-20', 'open', null, 'Follow up with non-responders.'),
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'Welcome back check-in'),
   'coach@groupscholar.com', '2026-01-30', 'completed', '2026-01-28', 'Scheduled 1:1s for 4 scholars.'),
  ((select nudge_id from groupscholar_nudge_metrics_mart.nudges where message_theme = 'Midterm support'),
   'mentor@groupscholar.com', '2025-10-15', 'open', null, 'Connect with tutoring partner.');
