-- Im Zeitraum (hier '2019-01-01 00:00:00' bis '2012-01-01 00:00:00') soll pro Spieler ermittelt werden welche Benefits ein Spieler genießt
-- Parameter müssen sein:
-- 1. Spieler (member_no)
-- 2. Zeitraum (von bis: z.B. Geschäftsjahr und Sommer + Wintersaison als Voreinstellungen: View?)
set @var_member_no:=2;
set @var_from:='2019-01-01 00:00:00';
set @var_to:='2020-01-01 00:00:00';

SELECT
    basis.member_no,
    basis.description,
    basis.sum_part_time,
    IF(basis.is_claimable,
        basis.sum_claim,
        basis.sum_part_time) AS sum_claim
FROM
    (SELECT
        p.member_no,
            b.description,
            -- Benefits die vom Betrachtungszeitraum abweichen sollen nur anteilig eingerechnet werden.
            sport.date_period_part(@var_from,@var_to,b.valid_from,b.valid_to) * IF(ISNULL(b.value), b.cap_sum_value, b.count * b.value) / cnt_team_members AS sum_part_time,
            c.value / cnt_team_members AS sum_claim,
            b.is_claimable
    FROM
        sport.benefit b
    -- Die Summe der tatsächlich eingeforderten Benefitsumme pro benefit_id
    LEFT JOIN (SELECT
        c.benefit_id, SUM(c.value) AS value
    FROM
        sport.claim c
    WHERE
        1 = 1 AND c.created_at >= @var_from
            AND c.created_at < @var_to
    GROUP BY c.benefit_id) c ON c.benefit_id = b.benefit_id
    LEFT JOIN sport.team t ON b.entity_id = t.team_id
    LEFT JOIN sport.team_members tm ON t.team_id = tm.team_id
    LEFT JOIN (SELECT
        team_id, COUNT(*) AS cnt_team_members
    FROM
        sport.team_members
    GROUP BY team_id) tm_count ON tm.team_id = tm_count.team_id
    LEFT JOIN sport.player p ON tm.player_id = p.player_id
    LEFT JOIN club.person pers ON p.member_no = pers.member_no
    WHERE
        1 = 1 AND entity = 'team'
            AND p.member_no = @var_member_no
            AND ((b.valid_from <= @var_from
            AND b.valid_to > @var_from)
            OR (b.valid_from < @var_to
            AND b.valid_to >= @var_to)
            OR (b.valid_from >= @var_from
            AND b.valid_from < @var_to))
	UNION
  -- Benefits pro Einzelspieler
    SELECT
        p.member_no,
            b.description,
            -- Benefits die vom Betrachtungszeitraum abweichen sollen nur anteilig eingerechnet werden.
            sport.date_period_part(@var_from,@var_to,b.valid_from,b.valid_to) * IF(ISNULL(b.value), b.cap_sum_value, b.count * b.value) AS sum_part_time,
            c.value AS sum_claim,
            b.is_claimable
    FROM
        sport.benefit b
    LEFT JOIN sport.player p ON b.entity_id = p.player_id
    -- Die Summe der tatsächlich eingeforderten Benefitsumme pro benefit_id
    LEFT JOIN (SELECT
        c.benefit_id, SUM(c.value) AS value
    FROM
        sport.claim c
    WHERE
        1 = 1 AND c.created_at >= @var_from
            AND c.created_at < @var_to
    GROUP BY c.benefit_id) c ON c.benefit_id = b.benefit_id
    LEFT JOIN club.person pers ON p.member_no = pers.member_no
    WHERE
        1 = 1 AND entity = 'player'
            AND p.member_no = @var_member_no
            AND ((b.valid_from <= @var_from
            AND b.valid_to > @var_from)
            OR (b.valid_from < @var_to
            AND b.valid_to >= @var_to)
            OR (b.valid_from >= @var_from
            AND b.valid_from < @var_to))) basis
