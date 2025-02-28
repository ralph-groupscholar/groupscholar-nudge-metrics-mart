create or replace view groupscholar_nudge_metrics_mart.nudge_response_rates as
select
  n.nudge_id,
  c.cohort_name,
  ch.name as channel,
  n.nudge_type,
  n.message_theme,
  n.sent_at,
  n.audience_size,
  count(r.response_id) as response_count,
  case
    when n.audience_size = 0 then 0
    else round((count(r.response_id)::numeric / n.audience_size) * 100, 2)
  end as response_rate_pct
from groupscholar_nudge_metrics_mart.nudges n
join groupscholar_nudge_metrics_mart.cohorts c on c.cohort_id = n.cohort_id
join groupscholar_nudge_metrics_mart.channels ch on ch.channel_id = n.channel_id
left join groupscholar_nudge_metrics_mart.responses r on r.nudge_id = n.nudge_id
group by n.nudge_id, c.cohort_name, ch.name, n.nudge_type, n.message_theme, n.sent_at, n.audience_size;

create or replace view groupscholar_nudge_metrics_mart.nudge_response_latency as
select
  n.nudge_id,
  n.sent_at,
  min(r.response_at) as first_response_at,
  round(extract(epoch from (min(r.response_at) - n.sent_at)) / 3600, 2) as hours_to_first_response
from groupscholar_nudge_metrics_mart.nudges n
left join groupscholar_nudge_metrics_mart.responses r on r.nudge_id = n.nudge_id
group by n.nudge_id, n.sent_at;

create or replace view groupscholar_nudge_metrics_mart.action_item_load as
select
  n.nudge_id,
  c.cohort_name,
  count(a.action_item_id) as total_items,
  count(a.action_item_id) filter (where a.status = 'open') as open_items,
  count(a.action_item_id) filter (where a.status = 'completed') as completed_items
from groupscholar_nudge_metrics_mart.nudges n
join groupscholar_nudge_metrics_mart.cohorts c on c.cohort_id = n.cohort_id
left join groupscholar_nudge_metrics_mart.action_items a on a.nudge_id = n.nudge_id
group by n.nudge_id, c.cohort_name;
