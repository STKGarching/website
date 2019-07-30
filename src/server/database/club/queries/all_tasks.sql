SELECT
    t.task_no,
    t.title,
    t.description,
    t.created_at,
    t.modified_at,
    t.due_date,
    t.resolution_date,
    tp.priority,
    ts.task_status
FROM
    club.task t
        LEFT JOIN
    club.task_priority tp ON t.priority_id = tp.priority_id
        LEFT JOIN
    club.task_status ts ON t.task_status_id = ts.task_status_id;
