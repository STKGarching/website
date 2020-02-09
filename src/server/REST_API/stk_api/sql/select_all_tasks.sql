SELECT
    t.task_no,
    t.title,
    CAST(t.description AS char),
    CAST(t.created_at AS char),
    CAST(t.modified_at AS char),
    t.due_date,
    t.resolution_date,
    tp.task_priority,
    ts.task_status
FROM
    club.task t
        LEFT JOIN
    club.task_priority tp ON t.task_priority_id = tp.task_priority_id
        LEFT JOIN
    club.task_status ts ON t.task_status_id = ts.task_status_id