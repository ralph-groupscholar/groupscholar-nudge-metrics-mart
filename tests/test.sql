begin;

do $$
begin
  if (select count(*) from groupscholar_nudge_metrics_mart.channels) < 4 then
    raise exception 'Expected at least 4 channels';
  end if;
  if (select count(*) from groupscholar_nudge_metrics_mart.cohorts) < 3 then
    raise exception 'Expected at least 3 cohorts';
  end if;
  if (select count(*) from groupscholar_nudge_metrics_mart.nudges) < 3 then
    raise exception 'Expected at least 3 nudges';
  end if;
  if (select count(*) from groupscholar_nudge_metrics_mart.responses) < 4 then
    raise exception 'Expected at least 4 responses';
  end if;
end $$;

rollback;
