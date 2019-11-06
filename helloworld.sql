SELECT DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || ' Days' || ' + ') ||
TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON,
v$session.SID, v$session.SERIAL#, v$process.SPID spid, v$session.process CLPRID,v$session.BLOCKING_SESSION_STATUS, v$session.BLOCKING_INSTANCE,v$session.BLOCKING_SESSION,
v$session.USERNAME, STATUS, OSUSER, MACHINE, v$session.PROGRAM, MODULE, action, SQL_HASH_VALUE,v$session.SQL_ADDRESS,v$session.SQL_ID,v$session.PREV_SQL_ID,
v$session.CLIENT_INFO,
'alter system kill session ' || '''' || v$session.SID || ', ' || v$session.SERIAL# || '''' || ' immediate;' kill_sql
FROM v$session, v$process
WHERE v$session.paddr = v$process.addr and v$session.type = 'USER' and v$session.sid = 1234
--AND v$process.spid = 23832
--and v$session.process = '26432'
--AND v$session.status = 'INACTIVE'
--AND v$session.username LIKE '%KAPARELIS SPYROS%'
--AND v$session.SID = 4392
--and v$session.sid in (select sid from v$session where SADDR in (select session_addr from v$sort_usage)) --(v$temp_usage)
and v$session.osuser like 'oracle%'
--and osuser='uidea'
--AND v$session.module LIKE '%qot%'
--and v$session.machine like '%PLHROFORIK92%'
--AND v$session.program LIKE '%QMN%'
--AND v$session.action LIKE 'FRM%'
--and action like '%FRM%OTE%'
ORDER BY logon_time ASC;
