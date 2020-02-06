/* This code will query the ring buffer running the health extended events session.  It will come back with the xml.
In order for you to see the graph, you'll need to click on an item, get the xml and then save it as .xdl and open it again
using ssms.  The xml will however give you more details on what code was executed, and which process was the victim and survivor. */

SELECT XEvent.query('(event/data/value/deadlock)[1]') AS DeadlockGraph
FROM (
    SELECT XEvent.query('.') AS XEvent
    FROM (
        SELECT CAST(target_data AS XML) AS TargetData
        FROM sys.dm_xe_session_targets st
        INNER JOIN sys.dm_xe_sessions s ON s.address = st.event_session_address
        WHERE s.NAME = 'system_health'
            AND st.target_name = 'ring_buffer'
        ) AS Data
CROSS APPLY TargetData.nodes('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData(XEvent)
) AS source;

