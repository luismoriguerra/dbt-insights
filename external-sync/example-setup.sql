-- Copyright The Linux Foundation and each contributor to LFX.
-- SPDX-License-Identifier: MIT

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10
-- Dumped by pg_dump version 13.4 (Ubuntu 13.4-4.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: crowd_public; Type: SCHEMA; Schema: -; Owner: crowd
--

CREATE SCHEMA crowd_public;


ALTER SCHEMA crowd_public OWNER TO crowd;

--
-- Name: datadog; Type: SCHEMA; Schema: -; Owner: crowd
--

CREATE SCHEMA datadog;


ALTER SCHEMA datadog OWNER TO crowd;

--
-- Name: hll; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hll WITH SCHEMA crowd_public;


--
-- Name: EXTENSION hll; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hll IS 'type for storing hyperloglog data';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA crowd_public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: explain_statement(text); Type: FUNCTION; Schema: datadog; Owner: crowd
--

CREATE FUNCTION datadog.explain_statement(l_query text, OUT explain json) RETURNS SETOF json
    LANGUAGE plpgsql STRICT SECURITY DEFINER
    AS $$
DECLARE
curs REFCURSOR;
plan JSON;

BEGIN
   OPEN curs FOR EXECUTE pg_catalog.concat('EXPLAIN (FORMAT JSON) ', l_query);
   FETCH curs INTO plan;
   CLOSE curs;
   RETURN QUERY SELECT plan;
END;
$$;


ALTER FUNCTION datadog.explain_statement(l_query text, OUT explain json) OWNER TO crowd;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.activities (
    id character varying(256) NOT NULL,
    type character varying(256),
    "timestamp" timestamp with time zone,
    platform character varying(256),
    iscontribution boolean,
    score integer,
    sourceid character varying(256),
    sourceparentid character varying(1020),
    attributes jsonb,
    channel character varying(256),
    body character varying(262144),
    title character varying(1024),
    url character varying(512),
    sentiment jsonb,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    memberid character varying(256),
    conversationid character varying(256),
    parentid character varying(256),
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    username character varying(512),
    objectmemberid character varying(256),
    objectmemberusername character varying(256),
    segmentid character varying(256),
    organizationid character varying(256),
    searchsyncedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.activities OWNER TO crowd;

--
-- Name: activitytasks; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.activitytasks (
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    activityid character varying(256) NOT NULL,
    taskid character varying(256) NOT NULL,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.activitytasks OWNER TO crowd;

--
-- Name: auditlogs; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.auditlogs (
    id character varying(256) NOT NULL,
    entityname character varying(1020),
    entityid character varying(1020),
    tenantid character varying(256),
    action character varying(128),
    createdbyid character varying(256),
    createdbyemail character varying(1020),
    "timestamp" timestamp with time zone,
    "values" jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.auditlogs OWNER TO crowd;

--
-- Name: automationexecutions; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.automationexecutions (
    id character varying(256) NOT NULL,
    automationid character varying(256),
    type character varying(320),
    tenantid character varying(256),
    trigger character varying(320),
    state character varying(320),
    error jsonb,
    executedat timestamp with time zone,
    eventid character varying(1020),
    payload jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.automationexecutions OWNER TO crowd;

--
-- Name: automations; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.automations (
    id character varying(256) NOT NULL,
    type character varying(320),
    tenantid character varying(256),
    trigger character varying(320),
    settings jsonb,
    state character varying(320),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    createdbyid character varying(256),
    updatedbyid character varying(256),
    name character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.automations OWNER TO crowd;

--
-- Name: awsdms_ddl_audit; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.awsdms_ddl_audit (
    c_key bigint NOT NULL,
    c_time timestamp without time zone,
    c_user character varying(256),
    c_txn character varying(64),
    c_tag character varying(96),
    c_oid integer,
    c_name character varying(256),
    c_schema character varying(256),
    c_ddlqry character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.awsdms_ddl_audit OWNER TO crowd;

--
-- Name: conversations; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.conversations (
    id character varying(256) NOT NULL,
    title character varying(262144),
    slug character varying(8192),
    published boolean,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    segmentid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.conversations OWNER TO crowd;

--
-- Name: conversationsettings; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.conversationsettings (
    id character varying(256) NOT NULL,
    enabled boolean,
    customurl character varying(256),
    logourl character varying(256),
    faviconurl character varying(256),
    theme jsonb,
    autopublish jsonb,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.conversationsettings OWNER TO crowd;

--
-- Name: dt_now; Type: VIEW; Schema: crowd_public; Owner: crowd
--

CREATE VIEW crowd_public.dt_now AS
 SELECT now() AS dt_now,
    date_trunc('day'::text, now()) AS today_midnight,
    (date_trunc('day'::text, now()) + '1 day'::interval) AS tomorrow_midnight,
    (date_trunc('day'::text, now()) + '23:59:59'::interval) AS today_last_second;


ALTER TABLE crowd_public.dt_now OWNER TO crowd;

--
-- Name: curr_time_ranges; Type: VIEW; Schema: crowd_public; Owner: crowd
--

CREATE VIEW crowd_public.curr_time_ranges AS
 SELECT '7d'::text AS time_range_name,
    (dt_now.tomorrow_midnight - '7 days'::interval) AS time_range_from,
    dt_now.today_last_second AS time_range_to
   FROM crowd_public.dt_now
UNION
 SELECT '30d'::text AS time_range_name,
    (dt_now.tomorrow_midnight - '30 days'::interval) AS time_range_from,
    dt_now.today_last_second AS time_range_to
   FROM crowd_public.dt_now
UNION
 SELECT 'q'::text AS time_range_name,
    (date_trunc('quarter'::text, dt_now.tomorrow_midnight) - '3 mons'::interval) AS time_range_from,
    (date_trunc('quarter'::text, dt_now.today_last_second) - '00:00:01'::interval) AS time_range_to
   FROM crowd_public.dt_now
UNION
 SELECT 'ty'::text AS time_range_name,
    date_trunc('year'::text, dt_now.tomorrow_midnight) AS time_range_from,
    dt_now.today_last_second AS time_range_to
   FROM crowd_public.dt_now
UNION
 SELECT 'y'::text AS time_range_name,
    (date_trunc('year'::text, dt_now.tomorrow_midnight) - '1 year'::interval) AS time_range_from,
    (date_trunc('year'::text, dt_now.tomorrow_midnight) - '00:00:01'::interval) AS time_range_to
   FROM crowd_public.dt_now
UNION
 SELECT '2y'::text AS time_range_name,
    (dt_now.today_midnight - '2 years'::interval) AS time_range_from,
    dt_now.today_last_second AS time_range_to
   FROM crowd_public.dt_now
UNION
 SELECT 'a'::text AS time_range_name,
    '1970-01-01 00:00:00+00'::timestamp with time zone AS time_range_from,
    dt_now.today_last_second AS time_range_to
   FROM crowd_public.dt_now;


ALTER TABLE crowd_public.curr_time_ranges OWNER TO crowd;

--
-- Name: eagleeyeactions; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.eagleeyeactions (
    id character varying(256) NOT NULL,
    type character varying(256),
    "timestamp" timestamp with time zone,
    contentid character varying(256),
    tenantid character varying(256),
    actionbyid character varying(256),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.eagleeyeactions OWNER TO crowd;

--
-- Name: eagleeyecontents; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.eagleeyecontents (
    id character varying(256) NOT NULL,
    platform character varying(256),
    url character varying(256),
    post jsonb,
    tenantid character varying(256),
    postedat timestamp with time zone,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.eagleeyecontents OWNER TO crowd;

--
-- Name: files; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.files (
    id character varying(256) NOT NULL,
    belongsto character varying(1020),
    belongstoid character varying(1020),
    belongstocolumn character varying(1020),
    name character varying(8332),
    sizeinbytes integer,
    privateurl character varying(8332),
    publicurl character varying(8332),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.files OWNER TO crowd;

--
-- Name: fivetran_audit; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.fivetran_audit (
    id character varying(256) NOT NULL,
    message character varying(256),
    update_started timestamp with time zone,
    update_id character varying(256),
    schema character varying(256),
    "table" character varying(256),
    start timestamp with time zone,
    done timestamp with time zone,
    rows_updated_or_inserted bigint,
    status character varying(256),
    progress timestamp with time zone,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.fivetran_audit OWNER TO crowd;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(200),
    description character varying(800),
    type character varying(80),
    script character varying(4000),
    checksum integer,
    installed_by character varying(400),
    installed_on timestamp without time zone,
    execution_time integer,
    success boolean,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.flyway_schema_history OWNER TO crowd;

--
-- Name: githubrepos; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.githubrepos (
    id character varying(256) NOT NULL,
    createdat timestamp without time zone,
    updatedat timestamp without time zone,
    tenantid character varying(256),
    integrationid character varying(256),
    segmentid character varying(256),
    url character varying(4096),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.githubrepos OWNER TO crowd;

--
-- Name: incomingwebhooks; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.incomingwebhooks (
    id character varying(256) NOT NULL,
    tenantid character varying(256),
    integrationid character varying(256),
    state character varying(1020),
    type character varying(1020),
    payload jsonb,
    processedat timestamp with time zone,
    error jsonb,
    createdat timestamp with time zone,
    retries integer,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.incomingwebhooks OWNER TO crowd;

--
-- Name: integrationruns; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.integrationruns (
    id character varying(256) NOT NULL,
    tenantid character varying(256),
    integrationid character varying(256),
    microserviceid character varying(256),
    onboarding boolean,
    state character varying(1020),
    delayeduntil timestamp with time zone,
    processedat timestamp with time zone,
    error jsonb,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.integrationruns OWNER TO crowd;

--
-- Name: integrations; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.integrations (
    id character varying(256) NOT NULL,
    platform character varying(256),
    status character varying(256),
    limitcount integer,
    limitlastresetat timestamp with time zone,
    token character varying(256),
    refreshtoken character varying(256),
    settings jsonb,
    integrationidentifier character varying(256),
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    emailsentat timestamp without time zone,
    segmentid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.integrations OWNER TO crowd;

--
-- Name: integrationstreams; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.integrationstreams (
    id character varying(256) NOT NULL,
    runid character varying(256),
    tenantid character varying(256),
    integrationid character varying(256),
    microserviceid character varying(256),
    state character varying(1020),
    name character varying(256),
    metadata jsonb,
    processedat timestamp with time zone,
    error jsonb,
    retries integer,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.integrationstreams OWNER TO crowd;

--
-- Name: memberattributesettings; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.memberattributesettings (
    id character varying(256) NOT NULL,
    type character varying(256),
    candelete boolean,
    show boolean,
    label character varying(256),
    name character varying(256),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    options jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.memberattributesettings OWNER TO crowd;

--
-- Name: memberenrichmentcache; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.memberenrichmentcache (
    memberid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    data jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.memberenrichmentcache OWNER TO crowd;

--
-- Name: memberidentities; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.memberidentities (
    memberid character varying(256) NOT NULL,
    platform character varying(256) NOT NULL,
    username character varying(512) NOT NULL,
    sourceid character varying(256),
    tenantid character varying(256),
    integrationid character varying(256),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.memberidentities OWNER TO crowd;

--
-- Name: membernomerge; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membernomerge (
    memberid character varying(256) NOT NULL,
    nomergeid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membernomerge OWNER TO crowd;

--
-- Name: membernotes; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membernotes (
    memberid character varying(256) NOT NULL,
    noteid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membernotes OWNER TO crowd;

--
-- Name: memberorganizations; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.memberorganizations (
    id character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    memberid character varying(256),
    organizationid character varying(256),
    datestart timestamp with time zone,
    dateend timestamp with time zone,
    title character varying(1020),
    source character varying(1020),
    deletedat timestamp without time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.memberorganizations OWNER TO crowd;

--
-- Name: members; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.members (
    id character varying(256) NOT NULL,
    usernameold jsonb,
    attributes jsonb,
    displayname character varying(512),
    emails jsonb,
    score integer,
    joinedat timestamp with time zone,
    importhash character varying(1020),
    reach jsonb,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    lastenriched timestamp without time zone,
    contributions jsonb,
    enrichedby jsonb,
    weakidentities jsonb,
    searchsyncedat timestamp with time zone,
    manuallycreated boolean,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.members OWNER TO crowd;

--
-- Name: membersegmentaffiliations; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membersegmentaffiliations (
    id character varying(256) NOT NULL,
    memberid character varying(256),
    segmentid character varying(256),
    organizationid character varying(256),
    datestart timestamp with time zone,
    dateend timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membersegmentaffiliations OWNER TO crowd;

--
-- Name: membersegments; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membersegments (
    _fivetran_id character varying(256) NOT NULL,
    memberid character varying(256),
    segmentid character varying(256),
    tenantid character varying(256),
    createdat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membersegments OWNER TO crowd;

--
-- Name: memberssyncremote; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.memberssyncremote (
    id character varying(256) NOT NULL,
    memberid character varying(256),
    sourceid character varying(256),
    integrationid character varying(256),
    syncfrom character varying(256),
    metadata character varying(256),
    lastsyncedat timestamp with time zone,
    status character varying(256),
    lastsyncedpayload jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.memberssyncremote OWNER TO crowd;

--
-- Name: membertags; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membertags (
    memberid character varying(256) NOT NULL,
    tagid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membertags OWNER TO crowd;

--
-- Name: membertasks; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membertasks (
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    memberid character varying(256) NOT NULL,
    taskid character varying(256) NOT NULL,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membertasks OWNER TO crowd;

--
-- Name: membertomerge; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.membertomerge (
    memberid character varying(256) NOT NULL,
    tomergeid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    similarity double precision,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.membertomerge OWNER TO crowd;

--
-- Name: microservices; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.microservices (
    id character varying(256) NOT NULL,
    init boolean,
    running boolean,
    type character varying(256),
    variant character varying(256),
    settings jsonb,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.microservices OWNER TO crowd;

--
-- Name: mv_active_days; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_active_days AS
 SELECT ((((((((((((((i.aggregation_type || '/'::text) || (i.ymd)::text) || '/'::text) || (i.segment_id)::text) || '/'::text) || i.repo_organization) || '/'::text) || (i.repository_url)::text) || '/'::text) || (i.member_id)::text) || '/'::text) || (COALESCE(i.platform, '-'::character varying))::text) || '/'::text) || (COALESCE(i.username, '-'::character varying))::text) AS pk_id,
    i.segment_id,
    i.repo_organization,
    i.repository_url,
    i.member_id,
    i.platform,
    i.username,
    i.ymd,
    i.aggregation_type,
    i.hll_contributions,
    i.hll_members
   FROM ( SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            (date_trunc('day'::text, a."timestamp"))::date AS ymd,
            'SRMD'::text AS aggregation_type,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE a.sourceid
                END)::text)) AS hll_contributions,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.memberid)::text)) AS hll_members
           FROM (crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))
          GROUP BY a.segmentid, a.channel, a.memberid, a.platform, a.username, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            '00000000-0000-0000-0000-000000000000'::character varying AS member_id,
            ''::character varying AS platform,
            ''::character varying AS username,
            (date_trunc('day'::text, a."timestamp"))::date AS ymd,
            'SRD'::text AS aggregation_type,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE a.sourceid
                END)::text)) AS hll_contributions,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.memberid)::text)) AS hll_members
           FROM (crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))
          GROUP BY a.segmentid, a.channel, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            (date_trunc('day'::text, a."timestamp"))::date AS ymd,
            'SMD'::text AS aggregation_type,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE a.sourceid
                END)::text)) AS hll_contributions,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.memberid)::text)) AS hll_members
           FROM (crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))
          GROUP BY a.segmentid, a.memberid, a.platform, a.username, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            '00000000-0000-0000-0000-000000000000'::character varying AS member_id,
            ''::character varying AS platform,
            ''::character varying AS username,
            (date_trunc('day'::text, a."timestamp"))::date AS ymd,
            'SD'::text AS aggregation_type,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE a.sourceid
                END)::text)) AS hll_contributions,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.memberid)::text)) AS hll_members
           FROM (crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))
          GROUP BY a.segmentid, ((date_trunc('day'::text, a."timestamp"))::date)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_active_days OWNER TO crowd;

--
-- Name: mv_time_ranges; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_time_ranges AS
 SELECT true AS curr,
    curr_time_ranges.time_range_name,
    curr_time_ranges.time_range_from,
    curr_time_ranges.time_range_to
   FROM crowd_public.curr_time_ranges
UNION
 SELECT false AS curr,
    (curr_time_ranges.time_range_name || 'p'::text) AS time_range_name,
    ((curr_time_ranges.time_range_from - (curr_time_ranges.time_range_to - curr_time_ranges.time_range_from)) - '00:00:01'::interval) AS time_range_from,
    (curr_time_ranges.time_range_from - '00:00:01'::interval) AS time_range_to
   FROM crowd_public.curr_time_ranges
  WHERE (curr_time_ranges.time_range_name <> 'a'::text)
  WITH NO DATA;


ALTER TABLE crowd_public.mv_time_ranges OWNER TO crowd;

--
-- Name: mv_commits_bus_factor; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_commits_bus_factor AS
 WITH member_repo AS (
         SELECT i.row_number,
            i.time_range_name,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to))
                  GROUP BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.segment_id, i.repo_organization, i.repository_url, i.cnt DESC
        ), member_org AS (
         SELECT i.row_number,
            i.time_range_name,
            i.segment_id,
            i.repo_organization,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)) ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to))
                  GROUP BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.segment_id, i.repo_organization, i.cnt DESC
        ), member_segment AS (
         SELECT i.row_number,
            i.time_range_name,
            i.segment_id,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, a.segmentid ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.segmentid AS segment_id,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to))
                  GROUP BY tr.time_range_name, a.segmentid, a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.segment_id, i.cnt DESC
        ), member_all AS (
         SELECT i.row_number,
            i.time_range_name,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to))
                  GROUP BY tr.time_range_name, a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.cnt DESC
        ), all_repo AS (
         SELECT member_repo.time_range_name,
            member_repo.segment_id,
            member_repo.repo_organization,
            member_repo.repository_url,
            sum(member_repo.cnt) AS cnt
           FROM member_repo
          GROUP BY member_repo.time_range_name, member_repo.segment_id, member_repo.repo_organization, member_repo.repository_url
        ), all_org AS (
         SELECT member_org.time_range_name,
            member_org.segment_id,
            member_org.repo_organization,
            sum(member_org.cnt) AS cnt
           FROM member_org
          GROUP BY member_org.time_range_name, member_org.segment_id, member_org.repo_organization
        ), all_segment AS (
         SELECT member_segment.time_range_name,
            member_segment.segment_id,
            sum(member_segment.cnt) AS cnt
           FROM member_segment
          GROUP BY member_segment.time_range_name, member_segment.segment_id
        ), all_all AS (
         SELECT member_all.time_range_name,
            sum(member_all.cnt) AS cnt
           FROM member_all
          GROUP BY member_all.time_range_name
        ), cum_repo AS (
         SELECT mr.time_range_name,
            mr.segment_id,
            mr.repo_organization,
            mr.repository_url,
            mr.row_number,
            mr.cnt,
            mr.member_id,
            mr.platform,
            mr.username,
            ((100.0 * (mr.cnt)::numeric) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS percent,
            ((100.0 * sum(mr.cnt) OVER (PARTITION BY mr.time_range_name, mr.segment_id, mr.repo_organization, mr.repository_url ORDER BY mr.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS cumulative_percent
           FROM (member_repo mr
             JOIN all_repo ar ON ((((mr.segment_id)::text = (ar.segment_id)::text) AND (mr.repo_organization = ar.repo_organization) AND ((mr.repository_url)::text = (ar.repository_url)::text) AND (mr.time_range_name = ar.time_range_name))))
          WHERE (mr.row_number <= 200)
          ORDER BY mr.time_range_name, mr.segment_id, mr.repo_organization, mr.repository_url, mr.row_number
        ), cum_org AS (
         SELECT mo.time_range_name,
            mo.segment_id,
            mo.repo_organization,
            mo.row_number,
            mo.cnt,
            mo.member_id,
            mo.platform,
            mo.username,
            ((100.0 * (mo.cnt)::numeric) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS percent,
            ((100.0 * sum(mo.cnt) OVER (PARTITION BY mo.time_range_name, mo.segment_id, mo.repo_organization ORDER BY mo.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS cumulative_percent
           FROM (member_org mo
             JOIN all_org ao ON ((((mo.segment_id)::text = (ao.segment_id)::text) AND (mo.repo_organization = ao.repo_organization) AND (mo.time_range_name = ao.time_range_name))))
          WHERE (mo.row_number <= 500)
          ORDER BY mo.time_range_name, mo.segment_id, mo.repo_organization, mo.row_number
        ), cum_segment AS (
         SELECT ms.time_range_name,
            ms.segment_id,
            ms.row_number,
            ms.cnt,
            ms.member_id,
            ms.platform,
            ms.username,
            ((100.0 * (ms.cnt)::numeric) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS percent,
            ((100.0 * sum(ms.cnt) OVER (PARTITION BY ms.time_range_name, ms.segment_id ORDER BY ms.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS cumulative_percent
           FROM (member_segment ms
             JOIN all_segment asg ON ((((ms.segment_id)::text = (asg.segment_id)::text) AND (ms.time_range_name = asg.time_range_name))))
          WHERE (ms.row_number <= 1000)
          ORDER BY ms.time_range_name, ms.segment_id, ms.row_number
        ), cum_all AS (
         SELECT ma.time_range_name,
            ma.row_number,
            ma.cnt,
            ma.member_id,
            ma.platform,
            ma.username,
            ((100.0 * (ma.cnt)::numeric) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS percent,
            ((100.0 * sum(ma.cnt) OVER (PARTITION BY ma.time_range_name ORDER BY ma.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS cumulative_percent
           FROM (member_all ma
             JOIN all_all aa ON ((ma.time_range_name = aa.time_range_name)))
          WHERE (ma.row_number <= 2000)
          ORDER BY ma.row_number
        ), bf_data AS (
         SELECT ((((((i.time_range_name || (i.segment_id)::text) || i.repo_organization) || (i.repository_url)::text) || (i.member_id)::text) || (i.platform)::text) || (i.username)::text) AS pk_id,
            i.tenant_id,
            i.time_range_name,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.member_id,
            i.platform,
            i.username,
            i.row_number,
            i.cnt,
            i.percent,
            i.cumulative_percent,
            tr.time_range_from,
            tr.time_range_to
           FROM (( SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_repo.time_range_name,
                    cum_repo.segment_id,
                    cum_repo.repo_organization,
                    cum_repo.repository_url,
                    cum_repo.member_id,
                    cum_repo.platform,
                    cum_repo.username,
                    cum_repo.row_number,
                    cum_repo.cnt,
                    cum_repo.percent,
                    cum_repo.cumulative_percent
                   FROM cum_repo
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_org.time_range_name,
                    cum_org.segment_id,
                    cum_org.repo_organization,
                    ((cum_org.repo_organization || '/'::text) || 'all-repos-combined'::text),
                    cum_org.member_id,
                    cum_org.platform,
                    cum_org.username,
                    cum_org.row_number,
                    cum_org.cnt,
                    cum_org.percent,
                    cum_org.cumulative_percent
                   FROM cum_org
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_segment.time_range_name,
                    cum_segment.segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_segment.member_id,
                    cum_segment.platform,
                    cum_segment.username,
                    cum_segment.row_number,
                    cum_segment.cnt,
                    cum_segment.percent,
                    cum_segment.cumulative_percent
                   FROM cum_segment
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_all.time_range_name,
                    '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_all.member_id,
                    cum_all.platform,
                    cum_all.username,
                    cum_all.row_number,
                    cum_all.cnt,
                    cum_all.percent,
                    cum_all.cumulative_percent
                   FROM cum_all) i
             JOIN crowd_public.mv_time_ranges tr ON ((i.time_range_name = tr.time_range_name)))
        ), bf AS (
         SELECT bf_data.time_range_name,
            bf_data.segment_id,
            bf_data.repo_organization,
            bf_data.repository_url,
            min(bf_data.row_number) AS bus_factor,
            min(bf_data.cumulative_percent) AS min_percent,
            (max(bf_data.row_number) - min(bf_data.row_number)) AS others_count,
            (100.0 - min(bf_data.cumulative_percent)) AS others_percent
           FROM bf_data
          WHERE (bf_data.cumulative_percent > 50.0)
          GROUP BY bf_data.time_range_name, bf_data.segment_id, bf_data.repo_organization, bf_data.repository_url
        )
 SELECT d.pk_id,
    d.tenant_id,
    d.time_range_name,
    d.segment_id,
    d.repo_organization,
    d.repository_url,
    d.member_id,
    d.platform,
    d.username,
    d.row_number,
    d.cnt,
    d.percent,
    d.cumulative_percent,
    d.time_range_from,
    d.time_range_to,
    b.bus_factor,
    b.min_percent,
    b.others_count,
    b.others_percent
   FROM (bf_data d
     JOIN bf b ON (((b.time_range_name = d.time_range_name) AND ((b.segment_id)::text = (d.segment_id)::text) AND (b.repo_organization = d.repo_organization) AND ((b.repository_url)::text = (d.repository_url)::text))))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_commits_bus_factor OWNER TO crowd;

--
-- Name: organizations; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizations (
    id character varying(256) NOT NULL,
    description character varying(16384),
    emails jsonb,
    phonenumbers jsonb,
    logo character varying(1024),
    tags jsonb,
    twitter jsonb,
    linkedin jsonb,
    crunchbase jsonb,
    employees integer,
    revenuerange jsonb,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    location character varying(256),
    github jsonb,
    website character varying(1024),
    isteamorganization boolean,
    lastenrichedat timestamp with time zone,
    employeecountbycountry jsonb,
    type character varying(256),
    geolocation character varying(256),
    size character varying(256),
    ticker character varying(256),
    headline character varying(256),
    profiles jsonb,
    naics jsonb,
    address jsonb,
    industry character varying(256),
    founded integer,
    displayname character varying(512),
    attributes jsonb,
    searchsyncedat timestamp with time zone,
    affiliatedprofiles jsonb,
    allsubsidiaries jsonb,
    alternativedomains jsonb,
    alternativenames jsonb,
    averageemployeetenure double precision,
    averagetenurebylevel jsonb,
    averagetenurebyrole jsonb,
    directsubsidiaries jsonb,
    employeechurnrate jsonb,
    employeecountbymonth jsonb,
    employeegrowthrate jsonb,
    employeecountbymonthbylevel jsonb,
    employeecountbymonthbyrole jsonb,
    gicssector character varying(256),
    grossadditionsbymonth jsonb,
    grossdeparturesbymonth jsonb,
    ultimateparent character varying(256),
    immediateparent character varying(256),
    manuallycreated boolean,
    weakidentities jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizations OWNER TO crowd;

--
-- Name: segments; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.segments (
    id character varying(256) NOT NULL,
    url character varying(256),
    name character varying(256),
    parentname character varying(256),
    grandparentname character varying(256),
    slug character varying(256),
    parentslug character varying(256),
    grandparentslug character varying(256),
    status character varying(256),
    description character varying(256),
    sourceid character varying(256),
    sourceparentid character varying(256),
    customactivitytypes jsonb,
    activitychannels jsonb,
    tenantid character varying(256),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.segments OWNER TO crowd;

--
-- Name: mv_contributors_first_contributions; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_contributors_first_contributions AS
 WITH contributions AS (
         SELECT a.id,
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN (a.sourceid)::text
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN (a.sourceparentid)::text
                    ELSE (a.id)::text
                END AS contribution_id,
            s.slug AS project,
            s.grandparentslug AS foundation,
            a.channel,
            (a."timestamp")::date AS "timestamp",
            (((a.memberid)::text || (a.username)::text) || (a.platform)::text) AS unique_id,
            a.memberid AS member_id,
            a.username,
            ((m.attributes -> 'avatarUrl'::text) ->> 'default'::text) AS logo_url,
            a.platform,
                CASE
                    WHEN (((m.attributes -> 'isBot'::text) ->> 'default'::text) = 'true'::text) THEN true
                    ELSE false
                END AS is_bot
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s ON (((a.segmentid)::text = (s.id)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND ((m.tenantid)::text = (a.tenantid)::text))))
             LEFT JOIN crowd_public.organizations o ON ((((a.organizationid)::text = (o.id)::text) AND ((o.tenantid)::text = (a.tenantid)::text))))
          WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))
        ), first_contributions AS (
         SELECT co.foundation,
            co.project,
            co.channel,
            co.member_id,
            co.platform,
            co.username,
            co.logo_url,
            co.is_bot,
            min(co."timestamp") AS first_activity,
            count(DISTINCT co."timestamp") AS total_active_days,
            count(DISTINCT co.contribution_id) AS total_contributions
           FROM contributions co
          GROUP BY GROUPING SETS ((co.member_id, co.username, co.logo_url, co.is_bot, co.foundation), (co.member_id, co.username, co.logo_url, co.is_bot, co.foundation, co.project), (co.member_id, co.username, co.logo_url, co.is_bot, co.foundation, co.project, co.channel), (co.member_id, co.username, co.logo_url, co.is_bot, co.foundation, co.project, co.channel, co.platform))
        )
 SELECT concat_ws('|'::text, f.member_id, f.username, f.logo_url, f.is_bot, f.foundation, f.project, f.channel, f.platform, f.first_activity) AS pkid,
    f.foundation,
    f.project,
    f.channel,
    f.member_id,
    f.platform,
    f.username,
    f.logo_url,
    f.is_bot,
    f.first_activity,
    f.total_active_days,
    f.total_contributions
   FROM first_contributions f
  WITH NO DATA;


ALTER TABLE crowd_public.mv_contributors_first_contributions OWNER TO crowd;

--
-- Name: mv_da_committers; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_da_committers AS
 WITH prev_committers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), prev_org_committers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), prev_segment_committers AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), prev_all_committers AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), curr_committers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), curr_org_committers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), curr_segment_committers AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), curr_all_committers AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), committers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.username,
            i_1.platform,
            i_1.commits
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.memberid AS member_id,
                    a.username,
                    a.platform,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS commits
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.commits >= 5)
        ), org_committers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.commits
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS commits
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.memberid, a.platform, a.username) i_1
          WHERE (i_1.commits >= 5)
        ), segment_committers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.commits
           FROM ( SELECT a.segmentid AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS commits
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL))
                  GROUP BY a.segmentid, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.commits >= 5)
        ), all_committers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.commits
           FROM ( SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS commits
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND (a.deletedat IS NULL))
                  GROUP BY a.memberid, a.platform, a.username) i_1
          WHERE (i_1.commits >= 5)
        )
 SELECT (((((((((((i.segment_id)::text || '/'::text) || i.repo_organization) || '/'::text) || (i.repository_url)::text) || '/'::text) || (i.member_id)::text) || '/'::text) || (COALESCE(i.platform, '-'::character varying))::text) || '/'::text) || (COALESCE(i.username, '-'::character varying))::text) AS pk_id,
    now() AS "timestamp",
    i.segment_id,
    i.repo_organization,
    i.repository_url,
    i.member_id,
    i.platform,
    i.username,
    i.commits,
    i.last_activity_at
   FROM ( SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.commits,
            pc.last_activity_at
           FROM ((prev_committers pc
             LEFT JOIN curr_committers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.repository_url)::text = (cc.repository_url)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN committers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.repository_url)::text = (atc.repository_url)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.commits,
            pc.last_activity_at
           FROM ((prev_org_committers pc
             LEFT JOIN curr_org_committers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN org_committers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.commits,
            pc.last_activity_at
           FROM ((prev_segment_committers pc
             LEFT JOIN curr_segment_committers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN segment_committers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.commits,
            pc.last_activity_at
           FROM ((prev_all_committers pc
             LEFT JOIN curr_all_committers cc ON ((((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN all_committers_all_time atc ON ((((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_da_committers OWNER TO crowd;

--
-- Name: mv_da_contributors; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_da_contributors AS
 WITH prev_contributors AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), prev_org_contributors AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), prev_segment_contributors AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), prev_all_contributors AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), curr_contributors AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), curr_org_contributors AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), curr_segment_contributors AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), curr_all_contributors AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), contributors_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.contributions
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            WHEN ((a.type)::text !~~ '%commit%'::text) THEN (split_part((a.url)::text, '#'::text, 1))::character varying
                            ELSE NULL::character varying
                        END) AS contributions
                   FROM crowd_public.activities a
                  WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.contributions >= 5)
        ), org_contributors_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.contributions
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            WHEN ((a.type)::text !~~ '%commit%'::text) THEN (split_part((a.url)::text, '#'::text, 1))::character varying
                            ELSE NULL::character varying
                        END) AS contributions
                   FROM crowd_public.activities a
                  WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.memberid, a.platform, a.username) i_1
          WHERE (i_1.contributions >= 5)
        ), segment_contributors_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.contributions
           FROM ( SELECT a.segmentid AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            WHEN ((a.type)::text !~~ '%commit%'::text) THEN (split_part((a.url)::text, '#'::text, 1))::character varying
                            ELSE NULL::character varying
                        END) AS contributions
                   FROM crowd_public.activities a
                  WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.contributions >= 5)
        ), all_contributors_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.contributions
           FROM ( SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            WHEN ((a.type)::text !~~ '%commit%'::text) THEN (split_part((a.url)::text, '#'::text, 1))::character varying
                            ELSE NULL::character varying
                        END) AS contributions
                   FROM crowd_public.activities a
                  WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.memberid, a.platform, a.username) i_1
          WHERE (i_1.contributions >= 5)
        )
 SELECT (((((((((((i.segment_id)::text || '/'::text) || i.repo_organization) || '/'::text) || (i.repository_url)::text) || '/'::text) || (i.member_id)::text) || '/'::text) || (COALESCE(i.platform, '-'::character varying))::text) || '/'::text) || (COALESCE(i.username, '-'::character varying))::text) AS pk_id,
    now() AS "timestamp",
    i.segment_id,
    i.repo_organization,
    i.repository_url,
    i.member_id,
    i.platform,
    i.username,
    i.contributions,
    i.last_activity_at
   FROM ( SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.contributions,
            pc.last_activity_at
           FROM ((prev_contributors pc
             LEFT JOIN curr_contributors cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.repository_url)::text = (cc.repository_url)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN contributors_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.repository_url)::text = (atc.repository_url)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.contributions,
            pc.last_activity_at
           FROM ((prev_org_contributors pc
             LEFT JOIN curr_org_contributors cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN org_contributors_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.contributions,
            pc.last_activity_at
           FROM ((prev_segment_contributors pc
             LEFT JOIN curr_segment_contributors cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN segment_contributors_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.contributions,
            pc.last_activity_at
           FROM ((prev_all_contributors pc
             LEFT JOIN curr_all_contributors cc ON ((((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN all_contributors_all_time atc ON ((((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_da_contributors OWNER TO crowd;

--
-- Name: mv_da_issue_contributors; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_da_issue_contributors AS
 WITH prev_issuers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), prev_org_issuers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), prev_segment_issuers AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), prev_all_issuers AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), curr_issuers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), curr_org_issuers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), curr_segment_issuers AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), curr_all_issuers AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), issuers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.issues_opened,
            i_1.issues_closed,
            i_1.issues
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_closed,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.issues >= 5)
        ), org_issuers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.issues_opened,
            i_1.issues_closed,
            i_1.issues
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_closed,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.memberid, a.platform, a.username) i_1
          WHERE (i_1.issues >= 5)
        ), segment_issuers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.issues_opened,
            i_1.issues_closed,
            i_1.issues
           FROM ( SELECT a.segmentid AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_closed,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.issues >= 5)
        ), all_issuers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.issues_opened,
            i_1.issues_closed,
            i_1.issues
           FROM ( SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'issues-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS issues_closed,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.memberid, a.platform, a.username) i_1
          WHERE (i_1.issues >= 5)
        )
 SELECT (((((((((((i.segment_id)::text || '/'::text) || i.repo_organization) || '/'::text) || (i.repository_url)::text) || '/'::text) || (i.member_id)::text) || '/'::text) || (COALESCE(i.platform, '-'::character varying))::text) || '/'::text) || (COALESCE(i.username, '-'::character varying))::text) AS pk_id,
    now() AS "timestamp",
    i.segment_id,
    i.repo_organization,
    i.repository_url,
    i.member_id,
    i.platform,
    i.username,
    i.issues,
    i.issues_opened,
    i.issues_closed,
    i.last_activity_at
   FROM ( SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.issues,
            atc.issues_opened,
            atc.issues_closed,
            pc.last_activity_at
           FROM ((prev_issuers pc
             LEFT JOIN curr_issuers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.repository_url)::text = (cc.repository_url)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN issuers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.repository_url)::text = (atc.repository_url)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.issues,
            atc.issues_opened,
            atc.issues_closed,
            pc.last_activity_at
           FROM ((prev_org_issuers pc
             LEFT JOIN curr_org_issuers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN org_issuers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.issues,
            atc.issues_opened,
            atc.issues_closed,
            pc.last_activity_at
           FROM ((prev_segment_issuers pc
             LEFT JOIN curr_segment_issuers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN segment_issuers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.issues,
            atc.issues_opened,
            atc.issues_closed,
            pc.last_activity_at
           FROM ((prev_all_issuers pc
             LEFT JOIN curr_all_issuers cc ON ((((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN all_issuers_all_time atc ON ((((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_da_issue_contributors OWNER TO crowd;

--
-- Name: mv_da_pr_contributors; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_da_pr_contributors AS
 WITH prev_pullers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            split_part((a.channel)::text, '/pull/'::text, 1) AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), (split_part((a.channel)::text, '/pull/'::text, 1)), a.platform, a.username, a.memberid
        ), prev_org_pullers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), prev_segment_pullers AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), prev_all_pullers AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id,
            max(a."timestamp") AS last_activity_at
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '6 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), curr_pullers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            split_part((a.channel)::text, '/pull/'::text, 1) AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), (split_part((a.channel)::text, '/pull/'::text, 1)), a.platform, a.username, a.memberid
        ), curr_org_pullers AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), curr_segment_pullers AS (
         SELECT a.segmentid AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), curr_all_pullers AS (
         SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            a.platform,
            a.username,
            a.memberid AS member_id
           FROM crowd_public.activities a
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a."timestamp" >= (now() - '3 mons'::interval)))
          GROUP BY a.platform, a.username, a.memberid
        ), pullers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.pulls_opened,
            i_1.pulls_closed,
            i_1.pulls_merged,
            i_1.pulls_reviewed,
            i_1.pulls_comment,
            i_1.pulls
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    split_part((a.channel)::text, '/pull/'::text, 1) AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_closed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-merged'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_merged,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-reviewed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_reviewed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-comment'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_comment,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS pulls
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), (split_part((a.channel)::text, '/pull/'::text, 1)), a.memberid, a.platform, a.username) i_1
          WHERE (i_1.pulls >= 5)
        ), org_pullers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.pulls_opened,
            i_1.pulls_closed,
            i_1.pulls_merged,
            i_1.pulls_reviewed,
            i_1.pulls_comment,
            i_1.pulls
           FROM ( SELECT a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_closed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-merged'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_merged,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-reviewed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_reviewed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-comment'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_comment,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS pulls
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.memberid, a.platform, a.username) i_1
          WHERE (i_1.pulls >= 5)
        ), segment_pullers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.pulls_opened,
            i_1.pulls_closed,
            i_1.pulls_merged,
            i_1.pulls_reviewed,
            i_1.pulls_comment,
            i_1.pulls
           FROM ( SELECT a.segmentid AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_closed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-merged'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_merged,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-reviewed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_reviewed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-comment'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_comment,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS pulls
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.segmentid, a.memberid, a.platform, a.username) i_1
          WHERE (i_1.pulls >= 5)
        ), all_pullers_all_time AS (
         SELECT i_1.segment_id,
            i_1.repo_organization,
            i_1.repository_url,
            i_1.member_id,
            i_1.platform,
            i_1.username,
            i_1.pulls_opened,
            i_1.pulls_closed,
            i_1.pulls_merged,
            i_1.pulls_reviewed,
            i_1.pulls_comment,
            i_1.pulls
           FROM ( SELECT '00000000-0000-0000-0000-000000000000'::text AS segment_id,
                    'all-orgs-combined'::text AS repo_organization,
                    'all-repos-combined'::text AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-opened'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_opened,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-closed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_closed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-merged'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_merged,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-reviewed'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_reviewed,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'pull_request-comment'::text) THEN split_part((a.url)::text, '#'::text, 1)
                            ELSE NULL::text
                        END) AS pulls_comment,
                    count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS pulls
                   FROM crowd_public.activities a
                  WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.deletedat IS NULL) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
                  GROUP BY a.memberid, a.platform, a.username) i_1
          WHERE (i_1.pulls >= 5)
        )
 SELECT (((((((((((i.segment_id)::text || '/'::text) || i.repo_organization) || '/'::text) || i.repository_url) || '/'::text) || (i.member_id)::text) || '/'::text) || (COALESCE(i.platform, '-'::character varying))::text) || '/'::text) || (COALESCE(i.username, '-'::character varying))::text) AS pk_id,
    now() AS "timestamp",
    i.segment_id,
    i.repo_organization,
    i.repository_url,
    i.member_id,
    i.platform,
    i.username,
    i.pulls,
    i.pulls_opened,
    i.pulls_closed,
    i.pulls_merged,
    i.pulls_reviewed,
    i.pulls_comment,
    i.last_activity_at
   FROM ( SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.pulls,
            atc.pulls_opened,
            atc.pulls_closed,
            atc.pulls_merged,
            atc.pulls_reviewed,
            atc.pulls_comment,
            pc.last_activity_at
           FROM ((prev_pullers pc
             LEFT JOIN curr_pullers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND (pc.repository_url = cc.repository_url) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN pullers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND (pc.repository_url = atc.repository_url) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.pulls,
            atc.pulls_opened,
            atc.pulls_closed,
            atc.pulls_merged,
            atc.pulls_reviewed,
            atc.pulls_comment,
            pc.last_activity_at
           FROM ((prev_org_pullers pc
             LEFT JOIN curr_org_pullers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND (pc.repo_organization = cc.repo_organization) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN org_pullers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND (pc.repo_organization = atc.repo_organization) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.pulls,
            atc.pulls_opened,
            atc.pulls_closed,
            atc.pulls_merged,
            atc.pulls_reviewed,
            atc.pulls_comment,
            pc.last_activity_at
           FROM ((prev_segment_pullers pc
             LEFT JOIN curr_segment_pullers cc ON ((((pc.segment_id)::text = (cc.segment_id)::text) AND ((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN segment_pullers_all_time atc ON ((((pc.segment_id)::text = (atc.segment_id)::text) AND ((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)
        UNION
         SELECT pc.segment_id,
            pc.repo_organization,
            pc.repository_url,
            pc.member_id,
            pc.platform,
            atc.username,
            atc.pulls,
            atc.pulls_opened,
            atc.pulls_closed,
            atc.pulls_merged,
            atc.pulls_reviewed,
            atc.pulls_comment,
            pc.last_activity_at
           FROM ((prev_all_pullers pc
             LEFT JOIN curr_all_pullers cc ON ((((pc.member_id)::text = (cc.member_id)::text) AND ((pc.platform)::text = (cc.platform)::text) AND ((pc.username)::text = (cc.username)::text))))
             JOIN all_pullers_all_time atc ON ((((pc.member_id)::text = (atc.member_id)::text) AND ((pc.platform)::text = (atc.platform)::text) AND ((pc.username)::text = (atc.username)::text))))
          WHERE (cc.member_id IS NULL)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_da_pr_contributors OWNER TO crowd;

--
-- Name: mv_member_contributions; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_member_contributions AS
 WITH member_identities AS (
         SELECT mi_1.memberid AS member_id,
            concat_ws('|'::text, mi_1.platform, mi_1.username) AS identifier,
            mi_1.username,
            row_number() OVER (PARTITION BY mi_1.memberid ORDER BY
                CASE
                    WHEN ((mi_1.platform)::text = 'github'::text) THEN 1
                    WHEN ((mi_1.platform)::text = 'git'::text) THEN 2
                    ELSE 3
                END, mi_1.username) AS rn
           FROM crowd_public.memberidentities mi_1
          WHERE (((mi_1.username)::text <> ''::text) AND ((mi_1.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
        UNION ALL
         SELECT m_1.id AS member_id,
            concat_ws('|'::text, 'email', jsonb_array_elements(m_1.emails)) AS identifier,
            'email'::character varying AS username,
            0 AS rn
           FROM crowd_public.members m_1
          WHERE ((m_1.emails <> '{}'::jsonb) AND ((m_1.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
        )
 SELECT a.id,
    a.organizationid AS organization_id,
    o.website AS organization_url,
    a.segmentid AS segment_id,
    a.channel,
    a."timestamp",
    a.type,
    a.sourceparentid AS source_parent_id,
    a.sourceid AS source_id,
    a.memberid AS member_id,
    a.username,
    m.displayname AS member_display_name,
    ((m.attributes -> 'country'::text) ->> 'enrichment'::text) AS country,
    ((m.attributes -> 'avatarUrl'::text) ->> 'default'::text) AS logo_url,
    ((m.attributes -> 'url'::text) ->> 'github'::text) AS github_url,
    ((m.attributes -> 'url'::text) ->> 'linkedin'::text) AS linkedin_url,
    ((m.attributes -> 'url'::text) ->> 'twitter'::text) AS twitter_url,
    (m.joinedat)::timestamp without time zone AS member_joinedat,
        CASE
            WHEN ((m.reach ->> 'github'::text) IS NOT NULL) THEN ((m.reach ->> 'github'::text))::integer
            ELSE 0
        END AS github_followers,
        CASE
            WHEN ((m.reach ->> 'twitter'::text) IS NOT NULL) THEN ((m.reach ->> 'twitter'::text))::integer
            ELSE 0
        END AS twitter_followers,
    concat_ws('|'::text, a.id, mi.identifier) AS pkid,
    mi.identifier,
    mi1.username AS member_username
   FROM ((((crowd_public.activities a
     LEFT JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND ((m.tenantid)::text = (a.tenantid)::text))))
     LEFT JOIN member_identities mi ON (((mi.member_id)::text = (a.memberid)::text)))
     LEFT JOIN member_identities mi1 ON ((((mi1.member_id)::text = (m.id)::text) AND (mi1.rn = 1))))
     LEFT JOIN crowd_public.organizations o ON ((((a.organizationid)::text = (o.id)::text) AND ((o.tenantid)::text = (a.tenantid)::text))))
  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_member_contributions OWNER TO crowd;

--
-- Name: mv_members; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_members AS
 SELECT m.id,
    m.displayname,
    m.attributes,
    m.emails,
    m.usernameold,
    m.tenantid,
    (m.joinedat)::timestamp without time zone AS joinedat,
        CASE
            WHEN (((m.attributes -> 'avatarUrl'::text) ->> 'github'::text) <> ''::text) THEN ((m.attributes -> 'avatarUrl'::text) ->> 'github'::text)
            WHEN (((m.attributes -> 'avatarUrl'::text) ->> 'linkedin'::text) <> ''::text) THEN ((m.attributes -> 'avatarUrl'::text) ->> 'linkedin'::text)
            WHEN (((m.attributes -> 'avatarUrl'::text) ->> 'twitter'::text) <> ''::text) THEN ((m.attributes -> 'avatarUrl'::text) ->> 'twitter'::text)
            WHEN (((m.attributes -> 'avatarUrl'::text) ->> 'slack'::text) <> ''::text) THEN ((m.attributes -> 'avatarUrl'::text) ->> 'slack'::text)
            WHEN (((m.attributes -> 'avatarUrl'::text) ->> 'enrichment'::text) <> ''::text) THEN ((m.attributes -> 'avatarUrl'::text) ->> 'enrichment'::text)
            WHEN (((m.attributes -> 'avatarUrl'::text) ->> 'custom'::text) <> ''::text) THEN ((m.attributes -> 'avatarUrl'::text) ->> 'custom'::text)
            ELSE ((m.attributes -> 'avatarUrl'::text) ->> 'default'::text)
        END AS logo_url,
    ((m.attributes -> 'country'::text) ->> 'enrichment'::text) AS country,
        CASE
            WHEN (((m.attributes -> 'isBot'::text) ->> 'default'::text) = 'true'::text) THEN true
            ELSE false
        END AS is_bot,
    ((m.attributes -> 'url'::text) ->> 'github'::text) AS github,
    ((m.attributes -> 'url'::text) ->> 'linkedin'::text) AS linkedin,
    ((m.attributes -> 'url'::text) ->> 'twitter'::text) AS twitter
   FROM crowd_public.members m
  WHERE ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text)
  WITH NO DATA;


ALTER TABLE crowd_public.mv_members OWNER TO crowd;

--
-- Name: mv_new_activities; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_new_activities AS
 WITH first_contribution AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.memberid AS member_id,
            a.platform,
            a.username,
            min(a."timestamp") AS first_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid
        ), first_org_contribution AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.memberid AS member_id,
            a.platform,
            a.username,
            min(a."timestamp") AS first_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL))
          GROUP BY a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid
        ), first_segment_contribution AS (
         SELECT a.segmentid AS segment_id,
            a.memberid AS member_id,
            a.platform,
            a.username,
            min(a."timestamp") AS first_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL))
          GROUP BY a.segmentid, a.platform, a.username, a.memberid
        ), first_all_contribution AS (
         SELECT a.memberid AS member_id,
            a.platform,
            a.username,
            min(a."timestamp") AS first_activity_at
           FROM crowd_public.activities a
          WHERE ((((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL))
          GROUP BY a.platform, a.username, a.memberid
        )
 SELECT ((((((((((((((((i.aggregation_period || '/'::text) || i.contribution_type) || '/'::text) || (i."timestamp")::text) || '/'::text) || (i.segment_id)::text) || '/'::text) || i.repo_organization) || '/'::text) || (i.repository_url)::text) || '/'::text) || (i.member_id)::text) || '/'::text) || (COALESCE(i.platform, '-'::character varying))::text) || '/'::text) || (COALESCE(i.username, '-'::character varying))::text) AS pk_id,
    i.segment_id,
    i.repo_organization,
    i.repository_url,
    i.member_id,
    i.platform,
    i.username,
    i.first_activity_at,
    i.contribution_type,
    i."timestamp",
    i.aggregation_period,
    i.hll_ids,
    i.hll_commit_shas
   FROM ( SELECT fc.segment_id,
            fc.repo_organization,
            fc.repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('day'::text, a."timestamp"))::date AS "timestamp",
            'd'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.channel)::text = (fc.repository_url)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '366 days'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.repository_url, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('day'::text, a."timestamp"))::date AS "timestamp",
            'd'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_org_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '366 days'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('day'::text, a."timestamp"))::date AS "timestamp",
            'd'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_segment_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '366 days'::interval))
          GROUP BY fc.segment_id, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('day'::text, a."timestamp"))::date AS "timestamp",
            'd'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_all_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '366 days'::interval))
          GROUP BY fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('day'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            fc.repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('week'::text, a."timestamp"))::date AS "timestamp",
            'w'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.channel)::text = (fc.repository_url)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.repository_url, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('week'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('week'::text, a."timestamp"))::date AS "timestamp",
            'w'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_org_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('week'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('week'::text, a."timestamp"))::date AS "timestamp",
            'w'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_segment_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY fc.segment_id, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('week'::text, a."timestamp"))::date)
        UNION ALL
         SELECT '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('week'::text, a."timestamp"))::date AS "timestamp",
            'w'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_all_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('week'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            fc.repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('month'::text, a."timestamp"))::date AS "timestamp",
            'm'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.channel)::text = (fc.repository_url)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.repository_url, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('month'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('month'::text, a."timestamp"))::date AS "timestamp",
            'm'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_org_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('month'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('month'::text, a."timestamp"))::date AS "timestamp",
            'm'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_segment_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY fc.segment_id, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('month'::text, a."timestamp"))::date)
        UNION ALL
         SELECT '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('month'::text, a."timestamp"))::date AS "timestamp",
            'm'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_all_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('month'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            fc.repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('quarter'::text, a."timestamp"))::date AS "timestamp",
            'q'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.channel)::text = (fc.repository_url)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '11 years'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.repository_url, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('quarter'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('quarter'::text, a."timestamp"))::date AS "timestamp",
            'q'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_org_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '11 years'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('quarter'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('quarter'::text, a."timestamp"))::date AS "timestamp",
            'q'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_segment_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '11 years'::interval))
          GROUP BY fc.segment_id, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('quarter'::text, a."timestamp"))::date)
        UNION ALL
         SELECT '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('quarter'::text, a."timestamp"))::date AS "timestamp",
            'q'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_all_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '11 years'::interval))
          GROUP BY fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('quarter'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            fc.repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('year'::text, a."timestamp"))::date AS "timestamp",
            'y'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.channel)::text = (fc.repository_url)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '21 years'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.repository_url, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('year'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            fc.repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('year'::text, a."timestamp"))::date AS "timestamp",
            'y'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_org_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (split_part((a.channel)::text, '/'::text, 4) = fc.repo_organization) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '21 years'::interval))
          GROUP BY fc.segment_id, fc.repo_organization, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('year'::text, a."timestamp"))::date)
        UNION ALL
         SELECT fc.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('year'::text, a."timestamp"))::date AS "timestamp",
            'y'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_segment_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND ((a.segmentid)::text = (fc.segment_id)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '21 years'::interval))
          GROUP BY fc.segment_id, fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('year'::text, a."timestamp"))::date)
        UNION ALL
         SELECT '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::character varying AS repository_url,
            fc.member_id,
            fc.platform,
            fc.username,
            fc.first_activity_at,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END AS contribution_type,
            (date_trunc('year'::text, a."timestamp"))::date AS "timestamp",
            'y'::text AS aggregation_period,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((a.id)::text)) AS hll_ids,
            crowd_public.hll_add_agg(crowd_public.hll_hash_text((
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END)::text)) AS hll_commit_shas
           FROM (crowd_public.activities a
             JOIN first_all_contribution fc ON (((a.deletedat IS NULL) AND ((a.memberid)::text = (fc.member_id)::text) AND ((a.platform)::text = (fc.platform)::text) AND ((a.username)::text = (fc.username)::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))))))
          WHERE (a."timestamp" >= (now() - '21 years'::interval))
          GROUP BY fc.member_id, fc.platform, fc.username,
                CASE
                    WHEN ((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN 'commit'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['issues-opened'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying])::text[])) THEN 'issue'::text
                    WHEN ((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-reviewed'::character varying, 'pull_request-review-thread-comment'::character varying])::text[])) THEN 'pull_request'::text
                    ELSE NULL::text
                END, fc.first_activity_at, ((date_trunc('year'::text, a."timestamp"))::date)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_new_activities OWNER TO crowd;

--
-- Name: type_map; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.type_map (
    type_name text,
    types text[]
);


ALTER TABLE crowd_public.type_map OWNER TO crowd;

--
-- Name: mv_org_bus_factor; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_org_bus_factor AS
 WITH company_repo AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.segment_id, i.repo_organization, i.repository_url, i.cnt DESC
        ), company_org AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.segment_id,
            i.repo_organization,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)) ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.segment_id, i.repo_organization, i.cnt DESC
        ), company_segment AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.segment_id,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name, a.segmentid ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.segmentid AS segment_id,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, tm.type_name, a.segmentid, a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.segment_id, i.cnt DESC
        ), company_all AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, tm.type_name, a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.cnt DESC
        ), all_repo AS (
         SELECT company_repo.time_range_name,
            company_repo.type_name,
            company_repo.segment_id,
            company_repo.repo_organization,
            company_repo.repository_url,
            sum(company_repo.cnt) AS cnt
           FROM company_repo
          GROUP BY company_repo.time_range_name, company_repo.type_name, company_repo.segment_id, company_repo.repo_organization, company_repo.repository_url
        ), all_org AS (
         SELECT company_org.time_range_name,
            company_org.type_name,
            company_org.segment_id,
            company_org.repo_organization,
            sum(company_org.cnt) AS cnt
           FROM company_org
          GROUP BY company_org.time_range_name, company_org.type_name, company_org.segment_id, company_org.repo_organization
        ), all_segment AS (
         SELECT company_segment.time_range_name,
            company_segment.type_name,
            company_segment.segment_id,
            sum(company_segment.cnt) AS cnt
           FROM company_segment
          GROUP BY company_segment.time_range_name, company_segment.type_name, company_segment.segment_id
        ), all_all AS (
         SELECT company_all.time_range_name,
            company_all.type_name,
            sum(company_all.cnt) AS cnt
           FROM company_all
          GROUP BY company_all.time_range_name, company_all.type_name
        ), cum_repo AS (
         SELECT mr.time_range_name,
            mr.type_name,
            mr.segment_id,
            mr.repo_organization,
            mr.repository_url,
            mr.row_number,
            mr.cnt,
            mr.org_id,
            ((100.0 * (mr.cnt)::numeric) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS percent,
            ((100.0 * sum(mr.cnt) OVER (PARTITION BY mr.time_range_name, mr.type_name, mr.segment_id, mr.repo_organization, mr.repository_url ORDER BY mr.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS cumulative_percent
           FROM (company_repo mr
             JOIN all_repo ar ON ((((mr.segment_id)::text = (ar.segment_id)::text) AND (mr.repo_organization = ar.repo_organization) AND ((mr.repository_url)::text = (ar.repository_url)::text) AND (mr.time_range_name = ar.time_range_name) AND (mr.type_name = ar.type_name))))
          WHERE (mr.row_number <= 200)
          ORDER BY mr.time_range_name, mr.type_name, mr.segment_id, mr.repo_organization, mr.repository_url, mr.row_number
        ), cum_org AS (
         SELECT mo.time_range_name,
            mo.type_name,
            mo.segment_id,
            mo.repo_organization,
            mo.row_number,
            mo.cnt,
            mo.org_id,
            ((100.0 * (mo.cnt)::numeric) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS percent,
            ((100.0 * sum(mo.cnt) OVER (PARTITION BY mo.time_range_name, mo.type_name, mo.segment_id, mo.repo_organization ORDER BY mo.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS cumulative_percent
           FROM (company_org mo
             JOIN all_org ao ON ((((mo.segment_id)::text = (ao.segment_id)::text) AND (mo.repo_organization = ao.repo_organization) AND (mo.time_range_name = ao.time_range_name) AND (mo.type_name = ao.type_name))))
          WHERE (mo.row_number <= 500)
          ORDER BY mo.time_range_name, mo.type_name, mo.segment_id, mo.repo_organization, mo.row_number
        ), cum_segment AS (
         SELECT ms.time_range_name,
            ms.type_name,
            ms.segment_id,
            ms.row_number,
            ms.cnt,
            ms.org_id,
            ((100.0 * (ms.cnt)::numeric) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS percent,
            ((100.0 * sum(ms.cnt) OVER (PARTITION BY ms.time_range_name, ms.type_name, ms.segment_id ORDER BY ms.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS cumulative_percent
           FROM (company_segment ms
             JOIN all_segment asg ON ((((ms.segment_id)::text = (asg.segment_id)::text) AND (ms.time_range_name = asg.time_range_name) AND (ms.type_name = asg.type_name))))
          WHERE (ms.row_number <= 1000)
          ORDER BY ms.time_range_name, ms.type_name, ms.segment_id, ms.row_number
        ), cum_all AS (
         SELECT ma.time_range_name,
            ma.type_name,
            ma.row_number,
            ma.cnt,
            ma.org_id,
            ((100.0 * (ma.cnt)::numeric) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS percent,
            ((100.0 * sum(ma.cnt) OVER (PARTITION BY ma.time_range_name, ma.type_name ORDER BY ma.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS cumulative_percent
           FROM (company_all ma
             JOIN all_all aa ON (((ma.time_range_name = aa.time_range_name) AND (ma.type_name = aa.type_name))))
          WHERE (ma.row_number <= 2000)
          ORDER BY ma.time_range_name, ma.type_name, ma.row_number
        ), bf_data AS (
         SELECT (((((i.time_range_name || i.type) || (i.segment_id)::text) || i.repo_organization) || (i.repository_url)::text) || (i.org_id)::text) AS pk_id,
            i.tenant_id,
            i.time_range_name,
            i.type,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.org_id,
            i.row_number,
            i.cnt,
            i.percent,
            i.cumulative_percent,
            tr.time_range_from,
            tr.time_range_to
           FROM (( SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_repo.time_range_name,
                    cum_repo.type_name AS type,
                    cum_repo.segment_id,
                    cum_repo.repo_organization,
                    cum_repo.repository_url,
                    cum_repo.org_id,
                    cum_repo.row_number,
                    cum_repo.cnt,
                    cum_repo.percent,
                    cum_repo.cumulative_percent
                   FROM cum_repo
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_org.time_range_name,
                    cum_org.type_name,
                    cum_org.segment_id,
                    cum_org.repo_organization,
                    ((cum_org.repo_organization || '/'::text) || 'all-repos-combined'::text),
                    cum_org.org_id,
                    cum_org.row_number,
                    cum_org.cnt,
                    cum_org.percent,
                    cum_org.cumulative_percent
                   FROM cum_org
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_segment.time_range_name,
                    cum_segment.type_name,
                    cum_segment.segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_segment.org_id,
                    cum_segment.row_number,
                    cum_segment.cnt,
                    cum_segment.percent,
                    cum_segment.cumulative_percent
                   FROM cum_segment
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_all.time_range_name,
                    cum_all.type_name,
                    '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_all.org_id,
                    cum_all.row_number,
                    cum_all.cnt,
                    cum_all.percent,
                    cum_all.cumulative_percent
                   FROM cum_all) i
             JOIN crowd_public.mv_time_ranges tr ON ((i.time_range_name = tr.time_range_name)))
        ), bf AS (
         SELECT bf_data.time_range_name,
            bf_data.type,
            bf_data.segment_id,
            bf_data.repo_organization,
            bf_data.repository_url,
            min(bf_data.row_number) AS bus_factor,
            min(bf_data.cumulative_percent) AS min_percent,
            (max(bf_data.row_number) - min(bf_data.row_number)) AS others_count,
            (100.0 - min(bf_data.cumulative_percent)) AS others_percent
           FROM bf_data
          WHERE (bf_data.cumulative_percent > 50.0)
          GROUP BY bf_data.time_range_name, bf_data.type, bf_data.segment_id, bf_data.repo_organization, bf_data.repository_url
        )
 SELECT d.pk_id,
    d.tenant_id,
    d.time_range_name,
    d.type,
    d.segment_id,
    d.repo_organization,
    d.repository_url,
    d.org_id,
    d.row_number,
    d.cnt,
    d.percent,
    d.cumulative_percent,
    d.time_range_from,
    d.time_range_to,
    b.bus_factor,
    b.min_percent,
    b.others_count,
    b.others_percent
   FROM (bf_data d
     JOIN bf b ON (((b.time_range_name = d.time_range_name) AND (b.type = d.type) AND ((b.segment_id)::text = (d.segment_id)::text) AND (b.repo_organization = d.repo_organization) AND ((b.repository_url)::text = (d.repository_url)::text))))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_org_bus_factor OWNER TO crowd;

--
-- Name: mv_org_commits_bus_factor; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_org_commits_bus_factor AS
 WITH company_repo AS (
         SELECT i.row_number,
            i.time_range_name,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.segment_id, i.repo_organization, i.repository_url, i.cnt DESC
        ), company_org AS (
         SELECT i.row_number,
            i.time_range_name,
            i.segment_id,
            i.repo_organization,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)) ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.segment_id, i.repo_organization, i.cnt DESC
        ), company_segment AS (
         SELECT i.row_number,
            i.time_range_name,
            i.segment_id,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, a.segmentid ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.segmentid AS segment_id,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, a.segmentid, a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.segment_id, i.cnt DESC
        ), company_all AS (
         SELECT i.row_number,
            i.time_range_name,
            i.org_id,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name ORDER BY (count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    a.organizationid AS org_id,
                    count(DISTINCT
                        CASE
                            WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                            WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                            ELSE NULL::character varying
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying, 'reviewed-commit'::character varying, 'signed-off-commit'::character varying, 'tested-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND (a.organizationid IS NOT NULL))
                  GROUP BY tr.time_range_name, a.organizationid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.cnt DESC
        ), all_repo AS (
         SELECT company_repo.time_range_name,
            company_repo.segment_id,
            company_repo.repo_organization,
            company_repo.repository_url,
            sum(company_repo.cnt) AS cnt
           FROM company_repo
          GROUP BY company_repo.time_range_name, company_repo.segment_id, company_repo.repo_organization, company_repo.repository_url
        ), all_org AS (
         SELECT company_org.time_range_name,
            company_org.segment_id,
            company_org.repo_organization,
            sum(company_org.cnt) AS cnt
           FROM company_org
          GROUP BY company_org.time_range_name, company_org.segment_id, company_org.repo_organization
        ), all_segment AS (
         SELECT company_segment.time_range_name,
            company_segment.segment_id,
            sum(company_segment.cnt) AS cnt
           FROM company_segment
          GROUP BY company_segment.time_range_name, company_segment.segment_id
        ), all_all AS (
         SELECT company_all.time_range_name,
            sum(company_all.cnt) AS cnt
           FROM company_all
          GROUP BY company_all.time_range_name
        ), cum_repo AS (
         SELECT mr.time_range_name,
            mr.segment_id,
            mr.repo_organization,
            mr.repository_url,
            mr.row_number,
            mr.cnt,
            mr.org_id,
            ((100.0 * (mr.cnt)::numeric) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS percent,
            ((100.0 * sum(mr.cnt) OVER (PARTITION BY mr.time_range_name, mr.segment_id, mr.repo_organization, mr.repository_url ORDER BY mr.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS cumulative_percent
           FROM (company_repo mr
             JOIN all_repo ar ON ((((mr.segment_id)::text = (ar.segment_id)::text) AND (mr.repo_organization = ar.repo_organization) AND ((mr.repository_url)::text = (ar.repository_url)::text) AND (mr.time_range_name = ar.time_range_name))))
          WHERE (mr.row_number <= 200)
          ORDER BY mr.time_range_name, mr.segment_id, mr.repo_organization, mr.repository_url, mr.row_number
        ), cum_org AS (
         SELECT mo.time_range_name,
            mo.segment_id,
            mo.repo_organization,
            mo.row_number,
            mo.cnt,
            mo.org_id,
            ((100.0 * (mo.cnt)::numeric) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS percent,
            ((100.0 * sum(mo.cnt) OVER (PARTITION BY mo.time_range_name, mo.segment_id, mo.repo_organization ORDER BY mo.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS cumulative_percent
           FROM (company_org mo
             JOIN all_org ao ON ((((mo.segment_id)::text = (ao.segment_id)::text) AND (mo.repo_organization = ao.repo_organization) AND (mo.time_range_name = ao.time_range_name))))
          WHERE (mo.row_number <= 500)
          ORDER BY mo.time_range_name, mo.segment_id, mo.repo_organization, mo.row_number
        ), cum_segment AS (
         SELECT ms.time_range_name,
            ms.segment_id,
            ms.row_number,
            ms.cnt,
            ms.org_id,
            ((100.0 * (ms.cnt)::numeric) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS percent,
            ((100.0 * sum(ms.cnt) OVER (PARTITION BY ms.time_range_name, ms.segment_id ORDER BY ms.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS cumulative_percent
           FROM (company_segment ms
             JOIN all_segment asg ON ((((ms.segment_id)::text = (asg.segment_id)::text) AND (ms.time_range_name = asg.time_range_name))))
          WHERE (ms.row_number <= 1000)
          ORDER BY ms.time_range_name, ms.segment_id, ms.row_number
        ), cum_all AS (
         SELECT ma.time_range_name,
            ma.row_number,
            ma.cnt,
            ma.org_id,
            ((100.0 * (ma.cnt)::numeric) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS percent,
            ((100.0 * sum(ma.cnt) OVER (PARTITION BY ma.time_range_name ORDER BY ma.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS cumulative_percent
           FROM (company_all ma
             JOIN all_all aa ON ((ma.time_range_name = aa.time_range_name)))
          WHERE (ma.row_number <= 2000)
          ORDER BY ma.row_number
        ), bf_data AS (
         SELECT ((((i.time_range_name || (i.segment_id)::text) || i.repo_organization) || (i.repository_url)::text) || (i.org_id)::text) AS pk_id,
            i.tenant_id,
            i.time_range_name,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.org_id,
            i.row_number,
            i.cnt,
            i.percent,
            i.cumulative_percent,
            tr.time_range_from,
            tr.time_range_to
           FROM (( SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_repo.time_range_name,
                    cum_repo.segment_id,
                    cum_repo.repo_organization,
                    cum_repo.repository_url,
                    cum_repo.org_id,
                    cum_repo.row_number,
                    cum_repo.cnt,
                    cum_repo.percent,
                    cum_repo.cumulative_percent
                   FROM cum_repo
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_org.time_range_name,
                    cum_org.segment_id,
                    cum_org.repo_organization,
                    ((cum_org.repo_organization || '/'::text) || 'all-repos-combined'::text),
                    cum_org.org_id,
                    cum_org.row_number,
                    cum_org.cnt,
                    cum_org.percent,
                    cum_org.cumulative_percent
                   FROM cum_org
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_segment.time_range_name,
                    cum_segment.segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_segment.org_id,
                    cum_segment.row_number,
                    cum_segment.cnt,
                    cum_segment.percent,
                    cum_segment.cumulative_percent
                   FROM cum_segment
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_all.time_range_name,
                    '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_all.org_id,
                    cum_all.row_number,
                    cum_all.cnt,
                    cum_all.percent,
                    cum_all.cumulative_percent
                   FROM cum_all) i
             JOIN crowd_public.mv_time_ranges tr ON ((i.time_range_name = tr.time_range_name)))
        ), bf AS (
         SELECT bf_data.time_range_name,
            bf_data.segment_id,
            bf_data.repo_organization,
            bf_data.repository_url,
            min(bf_data.row_number) AS bus_factor,
            min(bf_data.cumulative_percent) AS min_percent,
            (max(bf_data.row_number) - min(bf_data.row_number)) AS others_count,
            (100.0 - min(bf_data.cumulative_percent)) AS others_percent
           FROM bf_data
          WHERE (bf_data.cumulative_percent > 50.0)
          GROUP BY bf_data.time_range_name, bf_data.segment_id, bf_data.repo_organization, bf_data.repository_url
        )
 SELECT d.pk_id,
    d.tenant_id,
    d.time_range_name,
    d.segment_id,
    d.repo_organization,
    d.repository_url,
    d.org_id,
    d.row_number,
    d.cnt,
    d.percent,
    d.cumulative_percent,
    d.time_range_from,
    d.time_range_to,
    b.bus_factor,
    b.min_percent,
    b.others_count,
    b.others_percent
   FROM (bf_data d
     JOIN bf b ON (((b.time_range_name = d.time_range_name) AND ((b.segment_id)::text = (d.segment_id)::text) AND (b.repo_organization = d.repo_organization) AND ((b.repository_url)::text = (d.repository_url)::text))))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_org_commits_bus_factor OWNER TO crowd;

--
-- Name: mv_pr_engagement_gap; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_pr_engagement_gap AS
 WITH matching_activities AS (
         SELECT a.segmentid AS segment_id,
            split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
            a.channel AS repository_url,
            a.memberid AS member_id,
            (a.id)::text AS id,
            a."timestamp"
           FROM (crowd_public.activities a
             JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
          WHERE ((btrim((COALESCE(a.body, ''::character varying))::text) <> ''::text) AND (((a.type)::text = ANY ((ARRAY['pull_request-review-thread-comment'::character varying, 'pull_request-comment'::character varying])::text[])) OR (((a.type)::text = 'pull_request-reviewed'::text) AND ((a.attributes ->> 'reviewState'::text) = 'COMMENTED'::text))) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))
        ), daily_contributions AS (
         SELECT 'day'::text AS period,
            date(matching_activities."timestamp") AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            matching_activities.repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '366 days'::interval))
          GROUP BY (date(matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.repository_url, matching_activities.member_id
        ), weekly_contributions AS (
         SELECT 'week'::text AS period,
            (date_trunc('week'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            matching_activities.repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY (date_trunc('week'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.repository_url, matching_activities.member_id
        ), monthly_contributions AS (
         SELECT 'month'::text AS period,
            (date_trunc('month'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            matching_activities.repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY (date_trunc('month'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.repository_url, matching_activities.member_id
        ), quarterly_contributions AS (
         SELECT 'quarter'::text AS period,
            (date_trunc('quarter'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            matching_activities.repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '11 years'::interval))
          GROUP BY (date_trunc('quarter'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.repository_url, matching_activities.member_id
        ), yearly_contributions AS (
         SELECT 'year'::text AS period,
            (date_trunc('year'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            matching_activities.repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '21 years'::interval))
          GROUP BY (date_trunc('year'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.repository_url, matching_activities.member_id
        ), org_daily_contributions AS (
         SELECT 'day'::text AS period,
            date(matching_activities."timestamp") AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '366 days'::interval))
          GROUP BY (date(matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.member_id
        ), org_weekly_contributions AS (
         SELECT 'week'::text AS period,
            (date_trunc('week'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY (date_trunc('week'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.member_id
        ), org_monthly_contributions AS (
         SELECT 'month'::text AS period,
            (date_trunc('month'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY (date_trunc('month'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.member_id
        ), org_quarterly_contributions AS (
         SELECT 'quarter'::text AS period,
            (date_trunc('quarter'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '11 years'::interval))
          GROUP BY (date_trunc('quarter'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.member_id
        ), org_yearly_contributions AS (
         SELECT 'year'::text AS period,
            (date_trunc('year'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            matching_activities.repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '21 years'::interval))
          GROUP BY (date_trunc('year'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.repo_organization, matching_activities.member_id
        ), segment_daily_contributions AS (
         SELECT 'day'::text AS period,
            date(matching_activities."timestamp") AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '366 days'::interval))
          GROUP BY (date(matching_activities."timestamp")), matching_activities.segment_id, matching_activities.member_id
        ), segment_weekly_contributions AS (
         SELECT 'week'::text AS period,
            (date_trunc('week'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY (date_trunc('week'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.member_id
        ), segment_monthly_contributions AS (
         SELECT 'month'::text AS period,
            (date_trunc('month'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY (date_trunc('month'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.member_id
        ), segment_quarterly_contributions AS (
         SELECT 'quarter'::text AS period,
            (date_trunc('quarter'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '11 years'::interval))
          GROUP BY (date_trunc('quarter'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.member_id
        ), segment_yearly_contributions AS (
         SELECT 'year'::text AS period,
            (date_trunc('year'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            matching_activities.segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '21 years'::interval))
          GROUP BY (date_trunc('year'::text, matching_activities."timestamp")), matching_activities.segment_id, matching_activities.member_id
        ), all_daily_contributions AS (
         SELECT 'day'::text AS period,
            date(matching_activities."timestamp") AS period_date,
            matching_activities.member_id,
            '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '366 days'::interval))
          GROUP BY (date(matching_activities."timestamp")), matching_activities.member_id
        ), all_weekly_contributions AS (
         SELECT 'week'::text AS period,
            (date_trunc('week'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '2 years 1 mon'::interval))
          GROUP BY (date_trunc('week'::text, matching_activities."timestamp")), matching_activities.member_id
        ), all_monthly_contributions AS (
         SELECT 'month'::text AS period,
            (date_trunc('month'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '5 years 1 mon'::interval))
          GROUP BY (date_trunc('month'::text, matching_activities."timestamp")), matching_activities.member_id
        ), all_quarterly_contributions AS (
         SELECT 'quarter'::text AS period,
            (date_trunc('quarter'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '11 years'::interval))
          GROUP BY (date_trunc('quarter'::text, matching_activities."timestamp")), matching_activities.member_id
        ), all_yearly_contributions AS (
         SELECT 'year'::text AS period,
            (date_trunc('year'::text, matching_activities."timestamp"))::date AS period_date,
            matching_activities.member_id,
            '00000000-0000-0000-0000-000000000000'::text AS segment_id,
            'all-orgs-combined'::text AS repo_organization,
            'all-repos-combined'::text AS repository_url,
            count(DISTINCT matching_activities.id) AS contributions
           FROM matching_activities
          WHERE (matching_activities."timestamp" >= (now() - '21 years'::interval))
          GROUP BY (date_trunc('year'::text, matching_activities."timestamp")), matching_activities.member_id
        ), all_contributions AS (
         SELECT daily_contributions.period,
            daily_contributions.period_date,
            daily_contributions.segment_id,
            daily_contributions.repo_organization,
            daily_contributions.repository_url,
            daily_contributions.contributions
           FROM daily_contributions
        UNION
         SELECT weekly_contributions.period,
            weekly_contributions.period_date,
            weekly_contributions.segment_id,
            weekly_contributions.repo_organization,
            weekly_contributions.repository_url,
            weekly_contributions.contributions
           FROM weekly_contributions
        UNION
         SELECT monthly_contributions.period,
            monthly_contributions.period_date,
            monthly_contributions.segment_id,
            monthly_contributions.repo_organization,
            monthly_contributions.repository_url,
            monthly_contributions.contributions
           FROM monthly_contributions
        UNION
         SELECT quarterly_contributions.period,
            quarterly_contributions.period_date,
            quarterly_contributions.segment_id,
            quarterly_contributions.repo_organization,
            quarterly_contributions.repository_url,
            quarterly_contributions.contributions
           FROM quarterly_contributions
        UNION
         SELECT yearly_contributions.period,
            yearly_contributions.period_date,
            yearly_contributions.segment_id,
            yearly_contributions.repo_organization,
            yearly_contributions.repository_url,
            yearly_contributions.contributions
           FROM yearly_contributions
        UNION
         SELECT org_daily_contributions.period,
            org_daily_contributions.period_date,
            org_daily_contributions.segment_id,
            org_daily_contributions.repo_organization,
            org_daily_contributions.repository_url,
            org_daily_contributions.contributions
           FROM org_daily_contributions
        UNION
         SELECT org_weekly_contributions.period,
            org_weekly_contributions.period_date,
            org_weekly_contributions.segment_id,
            org_weekly_contributions.repo_organization,
            org_weekly_contributions.repository_url,
            org_weekly_contributions.contributions
           FROM org_weekly_contributions
        UNION
         SELECT org_monthly_contributions.period,
            org_monthly_contributions.period_date,
            org_monthly_contributions.segment_id,
            org_monthly_contributions.repo_organization,
            org_monthly_contributions.repository_url,
            org_monthly_contributions.contributions
           FROM org_monthly_contributions
        UNION
         SELECT org_quarterly_contributions.period,
            org_quarterly_contributions.period_date,
            org_quarterly_contributions.segment_id,
            org_quarterly_contributions.repo_organization,
            org_quarterly_contributions.repository_url,
            org_quarterly_contributions.contributions
           FROM org_quarterly_contributions
        UNION
         SELECT org_yearly_contributions.period,
            org_yearly_contributions.period_date,
            org_yearly_contributions.segment_id,
            org_yearly_contributions.repo_organization,
            org_yearly_contributions.repository_url,
            org_yearly_contributions.contributions
           FROM org_yearly_contributions
        UNION
         SELECT segment_daily_contributions.period,
            segment_daily_contributions.period_date,
            segment_daily_contributions.segment_id,
            segment_daily_contributions.repo_organization,
            segment_daily_contributions.repository_url,
            segment_daily_contributions.contributions
           FROM segment_daily_contributions
        UNION
         SELECT segment_weekly_contributions.period,
            segment_weekly_contributions.period_date,
            segment_weekly_contributions.segment_id,
            segment_weekly_contributions.repo_organization,
            segment_weekly_contributions.repository_url,
            segment_weekly_contributions.contributions
           FROM segment_weekly_contributions
        UNION
         SELECT segment_monthly_contributions.period,
            segment_monthly_contributions.period_date,
            segment_monthly_contributions.segment_id,
            segment_monthly_contributions.repo_organization,
            segment_monthly_contributions.repository_url,
            segment_monthly_contributions.contributions
           FROM segment_monthly_contributions
        UNION
         SELECT segment_quarterly_contributions.period,
            segment_quarterly_contributions.period_date,
            segment_quarterly_contributions.segment_id,
            segment_quarterly_contributions.repo_organization,
            segment_quarterly_contributions.repository_url,
            segment_quarterly_contributions.contributions
           FROM segment_quarterly_contributions
        UNION
         SELECT segment_yearly_contributions.period,
            segment_yearly_contributions.period_date,
            segment_yearly_contributions.segment_id,
            segment_yearly_contributions.repo_organization,
            segment_yearly_contributions.repository_url,
            segment_yearly_contributions.contributions
           FROM segment_yearly_contributions
        UNION
         SELECT all_daily_contributions.period,
            all_daily_contributions.period_date,
            all_daily_contributions.segment_id,
            all_daily_contributions.repo_organization,
            all_daily_contributions.repository_url,
            all_daily_contributions.contributions
           FROM all_daily_contributions
        UNION
         SELECT all_weekly_contributions.period,
            all_weekly_contributions.period_date,
            all_weekly_contributions.segment_id,
            all_weekly_contributions.repo_organization,
            all_weekly_contributions.repository_url,
            all_weekly_contributions.contributions
           FROM all_weekly_contributions
        UNION
         SELECT all_monthly_contributions.period,
            all_monthly_contributions.period_date,
            all_monthly_contributions.segment_id,
            all_monthly_contributions.repo_organization,
            all_monthly_contributions.repository_url,
            all_monthly_contributions.contributions
           FROM all_monthly_contributions
        UNION
         SELECT all_quarterly_contributions.period,
            all_quarterly_contributions.period_date,
            all_quarterly_contributions.segment_id,
            all_quarterly_contributions.repo_organization,
            all_quarterly_contributions.repository_url,
            all_quarterly_contributions.contributions
           FROM all_quarterly_contributions
        UNION
         SELECT all_yearly_contributions.period,
            all_yearly_contributions.period_date,
            all_yearly_contributions.segment_id,
            all_yearly_contributions.repo_organization,
            all_yearly_contributions.repository_url,
            all_yearly_contributions.contributions
           FROM all_yearly_contributions
        ), min_max_contributions AS (
         SELECT all_contributions.segment_id,
            all_contributions.repo_organization,
            all_contributions.repository_url,
            all_contributions.period,
            all_contributions.period_date,
            min(all_contributions.contributions) AS min_contributions,
            max(all_contributions.contributions) AS max_contributions
           FROM all_contributions
          GROUP BY all_contributions.segment_id, all_contributions.repo_organization, all_contributions.repository_url, all_contributions.period, all_contributions.period_date
        )
 SELECT (((((min_max_contributions.segment_id)::text || min_max_contributions.repo_organization) || (min_max_contributions.repository_url)::text) || min_max_contributions.period) || (min_max_contributions.period_date)::text) AS id,
    min_max_contributions.period AS granularity,
    min_max_contributions.period_date AS "timestamp",
    min_max_contributions.segment_id,
    min_max_contributions.repo_organization,
    min_max_contributions.repository_url,
    ((min_max_contributions.max_contributions)::double precision / (min_max_contributions.min_contributions)::double precision) AS engagement_gap
   FROM min_max_contributions
  WITH NO DATA;


ALTER TABLE crowd_public.mv_pr_engagement_gap OWNER TO crowd;

--
-- Name: mv_segment_card; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_segment_card AS
 WITH min_years AS (
         SELECT a.segmentid AS segment_id,
            (date_trunc('year'::text, min(a."timestamp")))::date AS min_year
           FROM crowd_public.activities a
          WHERE ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text)
          GROUP BY a.segmentid
        ), contributors AS (
         SELECT count(DISTINCT (a.memberid)::text) AS contributors_count,
            count(DISTINCT (((a.memberid)::text || (a.platform)::text) || (a.username)::text)) AS identities_count,
            (max(a."timestamp"))::timestamp without time zone AS last_activity,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT (a.memberid)::text) AS contributors_count,
            count(DISTINCT (((a.memberid)::text || (a.platform)::text) || (a.username)::text)) AS identities_count,
            (max(a."timestamp"))::timestamp without time zone AS last_activity,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT (a.memberid)::text) AS contributors_count,
            count(DISTINCT (((a.memberid)::text || (a.platform)::text) || (a.username)::text)) AS identities_count,
            (max(a."timestamp"))::timestamp without time zone AS last_activity,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), organizations AS (
         SELECT count(DISTINCT (a.organizationid)::text) AS organizations_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT (a.organizationid)::text) AS organizations_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT (a.organizationid)::text) AS organizations_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), descendants AS (
         SELECT count(DISTINCT (d_1.id)::text) AS descendants_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM ((((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s_1.slug)::text) OR ((d_1.grandparentslug)::text = (s_1.slug)::text)) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((d_1.id)::text <> (a.segmentid)::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT (d_1.id)::text) AS descendants_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM ((((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s_1.slug)::text) OR ((d_1.grandparentslug)::text = (s_1.slug)::text)) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((d_1.id)::text <> (a.segmentid)::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT (d_1.id)::text) AS descendants_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM ((((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s_1.slug)::text) OR ((d_1.grandparentslug)::text = (s_1.slug)::text)) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((d_1.id)::text <> (a.segmentid)::text))))
          WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), segment_github_org AS (
         SELECT i_1.slug,
            i_1.subproject_slug,
            i_1.project_slug,
            i_1.project_group_slug,
            ('https://github.com/'::text || i_1.org) AS github_org
           FROM ( SELECT DISTINCT ON (s_1.slug) split_part((a.channel)::text, '/'::text, 4) AS org,
                    count(DISTINCT a.channel) AS repos,
                    s_1.slug,
                    s_1.slug AS subproject_slug,
                    ''::text AS project_slug,
                    ''::text AS project_group_slug
                   FROM ((((crowd_public.activities a
                     JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
                     JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
                     JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
                     JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s_1.slug)::text) OR ((d_1.grandparentslug)::text = (s_1.slug)::text)) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
                  WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year) AND (split_part((a.channel)::text, '/'::text, 3) = 'github.com'::text))
                  GROUP BY s_1.slug, (split_part((a.channel)::text, '/'::text, 4))
                  ORDER BY s_1.slug, (count(DISTINCT a.channel)) DESC) i_1
        UNION
         SELECT i_1.slug,
            i_1.subproject_slug,
            i_1.project_slug,
            i_1.project_group_slug,
            ('https://github.com/'::text || i_1.org) AS github_org
           FROM ( SELECT DISTINCT ON (s_1.parentslug) split_part((a.channel)::text, '/'::text, 4) AS org,
                    count(DISTINCT a.channel) AS repos,
                    s_1.parentslug AS slug,
                    ''::text AS subproject_slug,
                    s_1.parentslug AS project_slug,
                    ''::text AS project_group_slug
                   FROM ((((crowd_public.activities a
                     JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
                     JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
                     JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
                     JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s_1.slug)::text) OR ((d_1.grandparentslug)::text = (s_1.slug)::text)) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
                  WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year) AND (split_part((a.channel)::text, '/'::text, 3) = 'github.com'::text))
                  GROUP BY s_1.parentslug, (split_part((a.channel)::text, '/'::text, 4))
                  ORDER BY s_1.parentslug, (count(DISTINCT a.channel)) DESC) i_1
        UNION
         SELECT i_1.slug,
            i_1.subproject_slug,
            i_1.project_slug,
            i_1.project_group_slug,
            ('https://github.com/'::text || i_1.org) AS github_org
           FROM ( SELECT DISTINCT ON (s_1.grandparentslug) split_part((a.channel)::text, '/'::text, 4) AS org,
                    count(DISTINCT a.channel) AS repos,
                    s_1.grandparentslug AS slug,
                    ''::text AS subproject_slug,
                    ''::text AS project_slug,
                    s_1.grandparentslug AS project_group_slug
                   FROM ((((crowd_public.activities a
                     JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
                     JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
                     JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
                     JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s_1.slug)::text) OR ((d_1.grandparentslug)::text = (s_1.slug)::text)) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
                  WHERE ((((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year) AND (split_part((a.channel)::text, '/'::text, 3) = 'github.com'::text))
                  GROUP BY s_1.grandparentslug, (split_part((a.channel)::text, '/'::text, 4))
                  ORDER BY s_1.grandparentslug, (count(DISTINCT a.channel)) DESC) i_1
        ), pull_requests AS (
         SELECT count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS prs_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS prs_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS prs_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying])::text[])) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), lines AS (
         SELECT sum((COALESCE(((a.attributes ->> 'additions'::text))::numeric, (0)::numeric) + COALESCE(((a.attributes ->> 'deletions'::text))::numeric, (0)::numeric))) AS lines_code,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = 'pull_request-opened'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT sum((COALESCE(((a.attributes ->> 'additions'::text))::numeric, (0)::numeric) + COALESCE(((a.attributes ->> 'deletions'::text))::numeric, (0)::numeric))) AS lines_code,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = 'pull_request-opened'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT sum((COALESCE(((a.attributes ->> 'additions'::text))::numeric, (0)::numeric) + COALESCE(((a.attributes ->> 'deletions'::text))::numeric, (0)::numeric))) AS lines_code,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = 'pull_request-opened'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), commits AS (
         SELECT count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END) AS commits_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) AND (((a.attributes -> 'isMainBranch'::text))::boolean = true) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END) AS commits_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) AND (((a.attributes -> 'isMainBranch'::text))::boolean = true) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                    WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                    ELSE NULL::character varying
                END) AS commits_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) AND (((a.attributes -> 'isMainBranch'::text))::boolean = true) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), issues AS (
         SELECT count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['issues-closed'::character varying, 'issues-opened'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['issues-closed'::character varying, 'issues-opened'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT split_part((a.url)::text, '#'::text, 1)) AS issues_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['issues-closed'::character varying, 'issues-opened'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), stars AS (
         SELECT (count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'star'::text) THEN (a.id)::text
                    ELSE NULL::text
                END) - count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'unstar'::text) THEN (a.id)::text
                    ELSE NULL::text
                END)) AS stars_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['star'::character varying, 'unstar'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT (count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'star'::text) THEN (a.id)::text
                    ELSE NULL::text
                END) - count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'unstar'::text) THEN (a.id)::text
                    ELSE NULL::text
                END)) AS stars_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['star'::character varying, 'unstar'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT (count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'star'::text) THEN (a.id)::text
                    ELSE NULL::text
                END) - count(DISTINCT
                CASE
                    WHEN ((a.type)::text = 'unstar'::text) THEN (a.id)::text
                    ELSE NULL::text
                END)) AS stars_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = ANY ((ARRAY['star'::character varying, 'unstar'::character varying])::text[])) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        ), forks AS (
         SELECT count(DISTINCT (a.id)::text) AS forks_count,
            s_1.slug,
            s_1.slug AS subproject_slug,
            ''::character varying AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = 'fork'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.slug
        UNION
         SELECT count(DISTINCT (a.id)::text) AS forks_count,
            s_1.parentslug AS slug,
            ''::character varying AS subproject_slug,
            s_1.parentslug AS project_slug,
            ''::text AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = 'fork'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.parentslug
        UNION
         SELECT count(DISTINCT (a.id)::text) AS forks_count,
            s_1.grandparentslug AS slug,
            ''::character varying AS subproject_slug,
            ''::character varying AS project_slug,
            s_1.grandparentslug AS project_group_slug
           FROM (((crowd_public.activities a
             JOIN crowd_public.segments s_1 ON ((((a.segmentid)::text = (s_1.id)::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (s_1.parentslug IS NOT NULL) AND ((s_1.parentslug)::text <> ''::text) AND (s_1.grandparentslug IS NOT NULL) AND ((s_1.grandparentslug)::text <> ''::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE (((a.type)::text = 'fork'::text) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (a."timestamp" >= my.min_year))
          GROUP BY s_1.grandparentslug
        )
 SELECT DISTINCT ON (co.slug, co.project_group_slug, co.project_slug, co.subproject_slug) ((((COALESCE(co.project_group_slug, ''::text) || '.'::text) || (COALESCE(co.project_slug, ''::character varying))::text) || '.'::text) || (COALESCE(co.subproject_slug, ''::character varying))::text) AS pk_id,
    co.slug,
    co.subproject_slug,
    co.project_slug,
    co.project_group_slug,
    COALESCE(sgo.github_org, 'https://github.com'::text) AS github_org,
    co.contributors_count,
    co.identities_count,
    co.last_activity,
    pr.prs_count,
    c.commits_count,
    i.issues_count,
    s.stars_count,
    f.forks_count,
    d.descendants_count,
    o.organizations_count,
    li.lines_code
   FROM (((((((((contributors co
     LEFT JOIN pull_requests pr ON (((co.slug)::text = (pr.slug)::text)))
     LEFT JOIN commits c ON (((co.slug)::text = (c.slug)::text)))
     LEFT JOIN issues i ON (((co.slug)::text = (i.slug)::text)))
     LEFT JOIN stars s ON (((co.slug)::text = (s.slug)::text)))
     LEFT JOIN forks f ON (((co.slug)::text = (f.slug)::text)))
     LEFT JOIN descendants d ON (((co.slug)::text = (d.slug)::text)))
     LEFT JOIN segment_github_org sgo ON (((co.slug)::text = (sgo.slug)::text)))
     LEFT JOIN organizations o ON (((co.slug)::text = (o.slug)::text)))
     LEFT JOIN lines li ON (((co.slug)::text = (li.slug)::text)))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_segment_card OWNER TO crowd;

--
-- Name: mv_segment_yearly_stats; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_segment_yearly_stats AS
 WITH min_years AS (
         SELECT a.segmentid AS segment_id,
            (date_trunc('year'::text, min(a."timestamp")))::date AS min_year
           FROM crowd_public.activities a
          WHERE ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text)
          GROUP BY a.segmentid
        ), act AS (
         SELECT (date_trunc('year'::text, a."timestamp"))::date AS year,
            a.segmentid,
            s.slug,
            a.memberid,
            a.platform,
            a.username,
            a.organizationid,
            a.attributes,
            a.type
           FROM (((crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN crowd_public.segments s ON ((((a.segmentid)::text = (s.id)::text) AND ((s.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
          WHERE ((a."timestamp" >= my.min_year) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))))
        UNION
         SELECT (date_trunc('year'::text, a."timestamp"))::date AS year,
            sp.id AS segmentid,
            s.parentslug AS slug,
            a.memberid,
            a.platform,
            a.username,
            a.organizationid,
            a.attributes,
            a.type
           FROM ((((crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.segments s ON ((((a.segmentid)::text = (s.id)::text) AND ((s.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN crowd_public.segments sp ON ((((s.parentslug)::text = (sp.slug)::text) AND ((sp.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((sp.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((a."timestamp" >= my.min_year) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))))
        UNION
         SELECT (date_trunc('year'::text, a."timestamp"))::date AS year,
            sgp.id AS segmentid,
            s.grandparentslug AS slug,
            a.memberid,
            a.platform,
            a.username,
            a.organizationid,
            a.attributes,
            a.type
           FROM ((((crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.segments s ON ((((a.segmentid)::text = (s.id)::text) AND ((s.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))))
             JOIN crowd_public.segments sgp ON ((((s.grandparentslug)::text = (sgp.slug)::text) AND ((sgp.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((sgp.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((a."timestamp" >= my.min_year) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND (((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))))
        ), years AS (
         SELECT DISTINCT act.segmentid,
            act.slug,
            act.year
           FROM act
        ), yearly AS (
         SELECT y_1.year,
            a.segmentid AS segment_id,
            a.slug,
            count(DISTINCT
                CASE
                    WHEN (a.year <= y_1.year) THEN (a.memberid)::text
                    ELSE NULL::text
                END) AS contributors_count,
            count(DISTINCT
                CASE
                    WHEN (a.year <= y_1.year) THEN (((a.memberid)::text || (a.platform)::text) || (a.username)::text)
                    ELSE NULL::text
                END) AS identities_count,
            count(DISTINCT
                CASE
                    WHEN (a.year <= y_1.year) THEN (a.organizationid)::text
                    ELSE NULL::text
                END) AS organizations_count,
            COALESCE(sum((COALESCE(((a.attributes ->> 'additions'::text))::numeric, (0)::numeric) + COALESCE(((a.attributes ->> 'deletions'::text))::numeric, (0)::numeric))) FILTER (WHERE (((a.type)::text = 'pull_request-opened'::text) AND (a.year <= y_1.year))), (0)::numeric) AS lines_of_code
           FROM (act a
             JOIN years y_1 ON (((a.segmentid)::text = (y_1.segmentid)::text)))
          GROUP BY y_1.year, a.segmentid, a.slug
        ), descendants AS (
         SELECT count(DISTINCT (d_1.id)::text) AS descendants_count,
            a.segmentid AS segment_id,
            s.slug
           FROM ((((crowd_public.activities a
             JOIN crowd_public.members m ON ((((m.id)::text = (a.memberid)::text) AND (COALESCE(((m.attributes -> 'isBot'::text) ->> 'default'::text), ''::text) <> 'true'::text) AND ((m.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
             JOIN min_years my ON (((my.segment_id)::text = (a.segmentid)::text)))
             JOIN crowd_public.segments s ON (((a.segmentid)::text = (s.id)::text)))
             JOIN crowd_public.segments d_1 ON (((((d_1.parentslug)::text = (s.slug)::text) OR ((d_1.grandparentslug)::text = (s.slug)::text)) AND ((d_1.id)::text <> (a.segmentid)::text))))
          WHERE ((a."timestamp" >= my.min_year) AND ((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (a.deletedat IS NULL) AND ((s.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((d_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND (((a.type)::text = ANY ((ARRAY['issue-comment'::character varying, 'issues-closed'::character varying, 'issues-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-comment'::character varying, 'pull_request-merged'::character varying, 'pull_request-opened'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying, 'authored-commit'::character varying])::text[])) AND ((a.attributes -> 'isMainBranch'::text) = 'true'::jsonb))))
          GROUP BY a.segmentid, s.slug
        )
 SELECT ((y.segment_id)::text || (y.year)::text) AS id,
    y.segment_id,
    y.slug,
    y.year,
    y.contributors_count,
    y.identities_count,
    y.organizations_count,
    y.lines_of_code,
    COALESCE(d.descendants_count, (0)::bigint) AS descendants_count
   FROM (yearly y
     LEFT JOIN descendants d ON (((y.segment_id)::text = (d.segment_id)::text)))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_segment_yearly_stats OWNER TO crowd;

--
-- Name: mv_segments; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_segments AS
 WITH segments_with_repositories AS (
         SELECT jsonb_array_elements_text((integrations.settings -> 'remotes'::text)) AS repository_url,
            integrations.segmentid
           FROM crowd_public.integrations
          WHERE (((integrations.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (integrations.deletedat IS NULL))
        ), unique_segment_ids AS (
         SELECT DISTINCT segments_with_repositories.segmentid
           FROM segments_with_repositories
        ), active_subprojects_segments AS (
         SELECT s_1.id,
            s_1.name,
            s_1.slug,
            s_1.parentslug,
            s_1.grandparentslug
           FROM (crowd_public.segments s_1
             JOIN unique_segment_ids vs ON (((s_1.id)::text = (vs.segmentid)::text)))
          WHERE ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[]))
        ), crowddev_active_segments AS (
         SELECT s_1.id,
            s_1.name,
            s_1.slug,
            s_1.parentslug,
            s_1.grandparentslug
           FROM crowd_public.segments s_1
          WHERE (((s_1.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((s_1.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))
        ), active_foundations AS (
         SELECT s_1.id
           FROM crowddev_active_segments s_1
          WHERE ((s_1.parentslug IS NULL) AND ((s_1.slug)::text IN ( SELECT active_subprojects_segments.grandparentslug
                   FROM active_subprojects_segments)))
        ), active_projects AS (
         SELECT s_1.id
           FROM crowddev_active_segments s_1
          WHERE ((s_1.parentslug IS NOT NULL) AND (s_1.grandparentslug IS NULL) AND ((s_1.slug)::text IN ( SELECT active_subprojects_segments.parentslug
                   FROM active_subprojects_segments)))
        ), all_active_segments AS (
         SELECT active_projects.id AS active_id
           FROM active_projects
        UNION
         SELECT active_foundations.id AS active_id
           FROM active_foundations
        UNION
         SELECT active_subprojects_segments.id AS active_id
           FROM active_subprojects_segments
        )
 SELECT segments.id,
    segments.id AS segment_id,
    segments.url,
    segments.name,
    segments.slug,
        CASE
            WHEN ((segments.parentslug IS NOT NULL) AND (segments.grandparentslug IS NOT NULL)) THEN 'subproject'::text
            WHEN ((segments.parentslug IS NOT NULL) AND (segments.grandparentslug IS NULL)) THEN 'project'::text
            ELSE 'project_group'::text
        END AS project_type,
        CASE
            WHEN ((segments.parentslug IS NOT NULL) AND (segments.grandparentslug IS NOT NULL)) THEN 3
            WHEN ((segments.parentslug IS NOT NULL) AND (segments.grandparentslug IS NULL)) THEN 2
            ELSE 1
        END AS level,
    segments.parentslug AS project_slug,
    segments.grandparentslug AS project_group_slug,
    segments.parentname AS project_group_name,
    segments.grandparentname AS foundation_name,
    segments.status,
    segments.description
   FROM (crowd_public.segments
     JOIN all_active_segments s ON (((segments.id)::text = (s.active_id)::text)))
  WHERE (((segments.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((segments.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_segments OWNER TO crowd;

--
-- Name: mv_subprojects; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_subprojects AS
 WITH segments_with_repositories AS (
         SELECT jsonb_array_elements_text((integrations.settings -> 'remotes'::text)) AS repository_url,
            integrations.segmentid
           FROM crowd_public.integrations
          WHERE (((integrations.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (integrations.deletedat IS NULL))
        ), unique_segment_ids AS (
         SELECT DISTINCT segments_with_repositories.segmentid
           FROM segments_with_repositories
        ), active_subprojects_segments AS (
         SELECT s.id,
            s.name,
            s.slug,
            s.parentslug,
            s.grandparentslug
           FROM (crowd_public.segments s
             JOIN unique_segment_ids vs ON (((s.id)::text = (vs.segmentid)::text)))
          WHERE (((s.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((s.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))
        ), crowddev_active_segments AS (
         SELECT s.id,
            s.name,
            s.slug,
            s.parentslug,
            s.grandparentslug
           FROM crowd_public.segments s
          WHERE (((s.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((s.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))
        ), active_foundations AS (
         SELECT s.id
           FROM crowddev_active_segments s
          WHERE ((s.parentslug IS NULL) AND ((s.slug)::text IN ( SELECT active_subprojects_segments.grandparentslug
                   FROM active_subprojects_segments)))
        ), active_projects AS (
         SELECT s.id
           FROM crowddev_active_segments s
          WHERE ((s.parentslug IS NOT NULL) AND (s.grandparentslug IS NULL) AND ((s.slug)::text IN ( SELECT active_subprojects_segments.parentslug
                   FROM active_subprojects_segments)))
        ), all_active_segments AS (
         SELECT active_projects.id AS active_id
           FROM active_projects
        UNION
         SELECT active_foundations.id AS active_id
           FROM active_foundations
        UNION
         SELECT active_subprojects_segments.id AS active_id
           FROM active_subprojects_segments
        )
 SELECT ((((((((((COALESCE(i.project_group_slug, '-'::character varying))::text || '/'::text) || (COALESCE(i.project_slug, '-'::character varying))::text) || '/'::text) || (COALESCE(i.subproject_slug, '-'::character varying))::text) || ' ('::text) || (i.id)::text) || '/'::text) || (i.sid)::text) || ')'::text) AS pk_id,
    i.id,
    i.segment_id,
    i.sid,
    i.subproject_slug,
    i.project_slug,
    i.project_group_slug,
    i.subproject_name,
    i.project_name,
    i.project_group_name,
    i.status,
    i.description,
    i.level
   FROM ( SELECT segments.id,
            segments.id AS segment_id,
            segments.id AS sid,
            segments.slug AS subproject_slug,
            segments.parentslug AS project_slug,
            segments.grandparentslug AS project_group_slug,
            segments.name AS subproject_name,
            segments.parentname AS project_name,
            segments.grandparentname AS project_group_name,
            segments.status,
            segments.description,
            1 AS level
           FROM (crowd_public.segments
             JOIN all_active_segments active_segments ON (((segments.id)::text = (active_segments.active_id)::text)))
          WHERE (((segments.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (segments.parentslug IS NOT NULL) AND (segments.grandparentslug IS NOT NULL) AND ((segments.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))
        UNION
         SELECT sp.id,
            sp.id AS segment_id,
            s.id AS sid,
            NULL::character varying AS subproject_slug,
            s.parentslug AS project_slug,
            s.grandparentslug AS project_group_slug,
            NULL::character varying AS subproject_name,
            s.parentname AS project_name,
            s.grandparentname AS project_group_name,
            s.status,
            s.description,
            2 AS level
           FROM ((crowd_public.segments s
             JOIN all_active_segments active_segments ON (((s.id)::text = (active_segments.active_id)::text)))
             JOIN crowd_public.segments sp ON ((((s.parentslug)::text = (sp.slug)::text) AND ((sp.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((sp.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((s.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text)
        UNION
         SELECT sgp.id,
            sgp.id AS segment_id,
            s.id AS sid,
            NULL::character varying AS subproject_slug,
            NULL::character varying AS project_slug,
            s.grandparentslug AS project_group_slug,
            NULL::character varying AS subproject_name,
            NULL::character varying AS project_name,
            s.grandparentname AS project_group_name,
            s.status,
            s.description,
            3 AS level
           FROM ((crowd_public.segments s
             JOIN all_active_segments active_segments ON (((s.id)::text = (active_segments.active_id)::text)))
             JOIN crowd_public.segments sgp ON ((((s.grandparentslug)::text = (sgp.slug)::text) AND ((sgp.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((sgp.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
          WHERE ((s.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text)) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_subprojects OWNER TO crowd;

--
-- Name: mv_subprojects_repositories; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_subprojects_repositories AS
 WITH lfx_integrations AS (
         SELECT integrations.settings,
            integrations.segmentid
           FROM crowd_public.integrations
          WHERE (((integrations.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (integrations.deletedat IS NULL))
        ), github_repositories AS (
         SELECT regexp_replace(jsonb_array_elements_text((lfx_integrations.settings -> 'remotes'::text)), '\.git$'::text, ''::text) AS repository_url,
            lfx_integrations.segmentid AS segment_id
           FROM lfx_integrations
        ), git_repositories AS (
         SELECT jsonb_array_elements_text((lfx_integrations.settings -> 'remotes'::text)) AS repository_url,
            lfx_integrations.segmentid AS segment_id
           FROM lfx_integrations
        ), segment_repositories AS (
         SELECT github_repositories.repository_url,
            github_repositories.segment_id
           FROM github_repositories
        UNION
         SELECT git_repositories.repository_url,
            git_repositories.segment_id
           FROM git_repositories
        ), segment_slugs AS (
         SELECT segments.id,
            segments.slug AS subproject_slug,
            segments.parentslug AS project_slug,
            segments.grandparentslug AS project_group_slug,
            segments.name AS subproject_name,
            segments.parentname AS project_name,
            segments.grandparentname AS project_group_name,
            segments.status,
            segments.description
           FROM crowd_public.segments
          WHERE (((segments.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND (segments.parentslug IS NOT NULL) AND (segments.grandparentslug IS NOT NULL) AND ((segments.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])))
        )
 SELECT ((((((((((((((COALESCE(i.project_group_slug, '-'::character varying))::text || '/'::text) || (COALESCE(i.project_slug, '-'::character varying))::text) || '/'::text) || (COALESCE(i.subproject_slug, '-'::character varying))::text) || '/'::text) || i.repo_organization) || '/'::text) || i.repository_url) || ' ('::text) || (i.id)::text) || '/'::text) || (i.sid)::text) || ')'::text) AS pk_id,
    i.repo_organization,
    i.repository_url,
    i.id,
    i.segment_id,
    i.sid,
    i.subproject_slug,
    i.project_slug,
    i.project_group_slug,
    i.subproject_name,
    i.project_name,
    i.project_group_name,
    i.status,
    i.description
   FROM ( SELECT split_part(sr.repository_url, '/'::text, 4) AS repo_organization,
            sr.repository_url,
            ss.id,
            ss.id AS segment_id,
            sr.segment_id AS sid,
            ss.subproject_slug,
            ss.project_slug,
            ss.project_group_slug,
            ss.subproject_name,
            ss.project_name,
            ss.project_group_name,
            ss.status,
            ss.description
           FROM (segment_repositories sr
             JOIN segment_slugs ss ON (((ss.id)::text = (sr.segment_id)::text)))
        UNION
         SELECT split_part(sr.repository_url, '/'::text, 4) AS split_part,
            sr.repository_url,
            sp.id,
            sp.id AS segment_id,
            sr.segment_id AS sid,
            ss.subproject_slug,
            ss.project_slug,
            ss.project_group_slug,
            ss.subproject_name,
            ss.project_name,
            ss.project_group_name,
            ss.status,
            ss.description
           FROM ((segment_repositories sr
             JOIN segment_slugs ss ON (((ss.id)::text = (sr.segment_id)::text)))
             JOIN crowd_public.segments sp ON ((((ss.project_slug)::text = (sp.slug)::text) AND ((sp.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((sp.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))
        UNION
         SELECT split_part(sr.repository_url, '/'::text, 4) AS split_part,
            sr.repository_url,
            sgp.id,
            sgp.id AS segment_id,
            sr.segment_id AS sid,
            ss.subproject_slug,
            ss.project_slug,
            ss.project_group_slug,
            ss.subproject_name,
            ss.project_name,
            ss.project_group_name,
            ss.status,
            ss.description
           FROM ((segment_repositories sr
             JOIN segment_slugs ss ON (((ss.id)::text = (sr.segment_id)::text)))
             JOIN crowd_public.segments sgp ON ((((ss.project_group_slug)::text = (sgp.slug)::text) AND ((sgp.status)::text = ANY ((ARRAY['active'::character varying, 'prospect'::character varying])::text[])) AND ((sgp.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text))))) i
  WITH NO DATA;


ALTER TABLE crowd_public.mv_subprojects_repositories OWNER TO crowd;

--
-- Name: mv_type_bus_factor; Type: MATERIALIZED VIEW; Schema: crowd_public; Owner: crowd
--

CREATE MATERIALIZED VIEW crowd_public.mv_type_bus_factor AS
 WITH member_repo AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.channel AS repository_url,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))))
                  GROUP BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.channel, a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.segment_id, i.repo_organization, i.repository_url, i.cnt DESC
        ), member_org AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.segment_id,
            i.repo_organization,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)) ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.segmentid AS segment_id,
                    split_part((a.channel)::text, '/'::text, 4) AS repo_organization,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))))
                  GROUP BY tr.time_range_name, tm.type_name, a.segmentid, (split_part((a.channel)::text, '/'::text, 4)), a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.segment_id, i.repo_organization, i.cnt DESC
        ), member_segment AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.segment_id,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name, a.segmentid ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.segmentid AS segment_id,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))))
                  GROUP BY tr.time_range_name, tm.type_name, a.segmentid, a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.segment_id, i.cnt DESC
        ), member_all AS (
         SELECT i.row_number,
            i.time_range_name,
            i.type_name,
            i.member_id,
            i.platform,
            i.username,
            i.cnt
           FROM ( SELECT row_number() OVER (PARTITION BY tr.time_range_name, tm.type_name ORDER BY (count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END)) DESC) AS row_number,
                    tr.time_range_name,
                    tm.type_name,
                    a.memberid AS member_id,
                    a.platform,
                    a.username,
                    count(DISTINCT
                        CASE
                            WHEN (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text)) THEN (
                            CASE
                                WHEN ((a.type)::text = 'authored-commit'::text) THEN a.sourceid
                                WHEN ((a.type)::text = ANY ((ARRAY['committed-commit'::character varying, 'co-authored-commit'::character varying])::text[])) THEN a.sourceparentid
                                ELSE NULL::character varying
                            END)::text
                            ELSE (a.id)::text
                        END) AS cnt
                   FROM crowd_public.mv_time_ranges tr,
                    crowd_public.type_map tm,
                    (crowd_public.activities a
                     JOIN crowd_public.members m ON (((a.memberid)::text = (m.id)::text)))
                  WHERE (((a.tenantid)::text = '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text) AND ((((m.attributes -> 'isBot'::text) ->> 'default'::text) IS NULL) OR (((m.attributes -> 'isBot'::text) ->> 'default'::text) <> 'true'::text)) AND (a."timestamp" >= tr.time_range_from) AND (a."timestamp" < tr.time_range_to) AND ((a.type)::text = ANY (tm.types)) AND (((a.type)::text = ANY ((ARRAY['pull_request-opened'::character varying, 'pull_request-closed'::character varying, 'pull_request-merged'::character varying, 'pull_request-comment'::character varying, 'pull_request-review-thread-comment'::character varying, 'pull_request-reviewed'::character varying, 'issues-closed'::character varying, 'issue-comment'::character varying, 'issues-opened'::character varying])::text[])) OR (((a.type)::text = ANY ((ARRAY['authored-commit'::character varying, 'co-authored-commit'::character varying, 'committed-commit'::character varying])::text[])) AND ((a.attributes ->> 'isMainBranch'::text) = 'true'::text))) AND (NOT (((a.type)::text = 'pull_request-closed'::text) AND ((a.attributes ->> 'state'::text) = 'merged'::text))))
                  GROUP BY tr.time_range_name, tm.type_name, a.platform, a.username, a.memberid) i
          WHERE (i.row_number <= 20000)
          ORDER BY i.time_range_name, i.type_name, i.cnt DESC
        ), all_repo AS (
         SELECT member_repo.time_range_name,
            member_repo.type_name,
            member_repo.segment_id,
            member_repo.repo_organization,
            member_repo.repository_url,
            sum(member_repo.cnt) AS cnt
           FROM member_repo
          GROUP BY member_repo.time_range_name, member_repo.type_name, member_repo.segment_id, member_repo.repo_organization, member_repo.repository_url
        ), all_org AS (
         SELECT member_org.time_range_name,
            member_org.type_name,
            member_org.segment_id,
            member_org.repo_organization,
            sum(member_org.cnt) AS cnt
           FROM member_org
          GROUP BY member_org.time_range_name, member_org.type_name, member_org.segment_id, member_org.repo_organization
        ), all_segment AS (
         SELECT member_segment.time_range_name,
            member_segment.type_name,
            member_segment.segment_id,
            sum(member_segment.cnt) AS cnt
           FROM member_segment
          GROUP BY member_segment.time_range_name, member_segment.type_name, member_segment.segment_id
        ), all_all AS (
         SELECT member_all.time_range_name,
            member_all.type_name,
            sum(member_all.cnt) AS cnt
           FROM member_all
          GROUP BY member_all.time_range_name, member_all.type_name
        ), cum_repo AS (
         SELECT mr.time_range_name,
            mr.type_name,
            mr.segment_id,
            mr.repo_organization,
            mr.repository_url,
            mr.row_number,
            mr.cnt,
            mr.member_id,
            mr.platform,
            mr.username,
            ((100.0 * (mr.cnt)::numeric) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS percent,
            ((100.0 * sum(mr.cnt) OVER (PARTITION BY mr.time_range_name, mr.type_name, mr.segment_id, mr.repo_organization, mr.repository_url ORDER BY mr.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ar.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ar.cnt
                END) AS cumulative_percent
           FROM (member_repo mr
             JOIN all_repo ar ON ((((mr.segment_id)::text = (ar.segment_id)::text) AND (mr.repo_organization = ar.repo_organization) AND ((mr.repository_url)::text = (ar.repository_url)::text) AND (mr.time_range_name = ar.time_range_name) AND (mr.type_name = ar.type_name))))
          WHERE (mr.row_number <= 200)
          ORDER BY mr.time_range_name, mr.type_name, mr.segment_id, mr.repo_organization, mr.repository_url, mr.row_number
        ), cum_org AS (
         SELECT mo.time_range_name,
            mo.type_name,
            mo.segment_id,
            mo.repo_organization,
            mo.row_number,
            mo.cnt,
            mo.member_id,
            mo.platform,
            mo.username,
            ((100.0 * (mo.cnt)::numeric) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS percent,
            ((100.0 * sum(mo.cnt) OVER (PARTITION BY mo.time_range_name, mo.type_name, mo.segment_id, mo.repo_organization ORDER BY mo.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE ao.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE ao.cnt
                END) AS cumulative_percent
           FROM (member_org mo
             JOIN all_org ao ON ((((mo.segment_id)::text = (ao.segment_id)::text) AND (mo.repo_organization = ao.repo_organization) AND (mo.time_range_name = ao.time_range_name) AND (mo.type_name = ao.type_name))))
          WHERE (mo.row_number <= 500)
          ORDER BY mo.time_range_name, mo.type_name, mo.segment_id, mo.repo_organization, mo.row_number
        ), cum_segment AS (
         SELECT ms.time_range_name,
            ms.type_name,
            ms.segment_id,
            ms.row_number,
            ms.cnt,
            ms.member_id,
            ms.platform,
            ms.username,
            ((100.0 * (ms.cnt)::numeric) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS percent,
            ((100.0 * sum(ms.cnt) OVER (PARTITION BY ms.time_range_name, ms.type_name, ms.segment_id ORDER BY ms.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE asg.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE asg.cnt
                END) AS cumulative_percent
           FROM (member_segment ms
             JOIN all_segment asg ON ((((ms.segment_id)::text = (asg.segment_id)::text) AND (ms.time_range_name = asg.time_range_name) AND (ms.type_name = asg.type_name))))
          WHERE (ms.row_number <= 1000)
          ORDER BY ms.time_range_name, ms.type_name, ms.segment_id, ms.row_number
        ), cum_all AS (
         SELECT ma.time_range_name,
            ma.type_name,
            ma.row_number,
            ma.cnt,
            ma.member_id,
            ma.platform,
            ma.username,
            ((100.0 * (ma.cnt)::numeric) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS percent,
            ((100.0 * sum(ma.cnt) OVER (PARTITION BY ma.time_range_name, ma.type_name ORDER BY ma.row_number ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
                CASE aa.cnt
                    WHEN 0 THEN (1)::numeric
                    ELSE aa.cnt
                END) AS cumulative_percent
           FROM (member_all ma
             JOIN all_all aa ON (((ma.time_range_name = aa.time_range_name) AND (ma.type_name = aa.type_name))))
          WHERE (ma.row_number <= 2000)
          ORDER BY ma.time_range_name, ma.type_name, ma.row_number
        ), bf_data AS (
         SELECT (((((((i.time_range_name || i.type) || (i.segment_id)::text) || i.repo_organization) || (i.repository_url)::text) || (i.member_id)::text) || (i.platform)::text) || (i.username)::text) AS pk_id,
            i.tenant_id,
            i.time_range_name,
            i.type,
            i.segment_id,
            i.repo_organization,
            i.repository_url,
            i.member_id,
            i.platform,
            i.username,
            i.row_number,
            i.cnt,
            i.percent,
            i.cumulative_percent,
            tr.time_range_from,
            tr.time_range_to
           FROM (( SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_repo.time_range_name,
                    cum_repo.type_name AS type,
                    cum_repo.segment_id,
                    cum_repo.repo_organization,
                    cum_repo.repository_url,
                    cum_repo.member_id,
                    cum_repo.platform,
                    cum_repo.username,
                    cum_repo.row_number,
                    cum_repo.cnt,
                    cum_repo.percent,
                    cum_repo.cumulative_percent
                   FROM cum_repo
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_org.time_range_name,
                    cum_org.type_name,
                    cum_org.segment_id,
                    cum_org.repo_organization,
                    ((cum_org.repo_organization || '/'::text) || 'all-repos-combined'::text),
                    cum_org.member_id,
                    cum_org.platform,
                    cum_org.username,
                    cum_org.row_number,
                    cum_org.cnt,
                    cum_org.percent,
                    cum_org.cumulative_percent
                   FROM cum_org
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_segment.time_range_name,
                    cum_segment.type_name,
                    cum_segment.segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_segment.member_id,
                    cum_segment.platform,
                    cum_segment.username,
                    cum_segment.row_number,
                    cum_segment.cnt,
                    cum_segment.percent,
                    cum_segment.cumulative_percent
                   FROM cum_segment
                UNION
                 SELECT '875c38bd-2b1b-4e91-ad07-0cfbabb4c49f'::text AS tenant_id,
                    cum_all.time_range_name,
                    cum_all.type_name,
                    '00000000-0000-0000-0000-000000000000'::character varying AS segment_id,
                    'all-orgs-combined'::text,
                    (('all-orgs-combined'::text || '/'::text) || 'all-repos-combined'::text),
                    cum_all.member_id,
                    cum_all.platform,
                    cum_all.username,
                    cum_all.row_number,
                    cum_all.cnt,
                    cum_all.percent,
                    cum_all.cumulative_percent
                   FROM cum_all) i
             JOIN crowd_public.mv_time_ranges tr ON ((i.time_range_name = tr.time_range_name)))
        ), bf AS (
         SELECT bf_data.time_range_name,
            bf_data.type,
            bf_data.segment_id,
            bf_data.repo_organization,
            bf_data.repository_url,
            min(bf_data.row_number) AS bus_factor,
            min(bf_data.cumulative_percent) AS min_percent,
            (max(bf_data.row_number) - min(bf_data.row_number)) AS others_count,
            (100.0 - min(bf_data.cumulative_percent)) AS others_percent
           FROM bf_data
          WHERE (bf_data.cumulative_percent > 50.0)
          GROUP BY bf_data.time_range_name, bf_data.type, bf_data.segment_id, bf_data.repo_organization, bf_data.repository_url
        )
 SELECT d.pk_id,
    d.tenant_id,
    d.time_range_name,
    d.type,
    d.segment_id,
    d.repo_organization,
    d.repository_url,
    d.member_id,
    d.platform,
    d.username,
    d.row_number,
    d.cnt,
    d.percent,
    d.cumulative_percent,
    d.time_range_from,
    d.time_range_to,
    b.bus_factor,
    b.min_percent,
    b.others_count,
    b.others_percent
   FROM (bf_data d
     JOIN bf b ON (((b.time_range_name = d.time_range_name) AND (b.type = d.type) AND ((b.segment_id)::text = (d.segment_id)::text) AND (b.repo_organization = d.repo_organization) AND ((b.repository_url)::text = (d.repository_url)::text))))
  WITH NO DATA;


ALTER TABLE crowd_public.mv_type_bus_factor OWNER TO crowd;

--
-- Name: notes; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.notes (
    id character varying(256) NOT NULL,
    body character varying(512),
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.notes OWNER TO crowd;

--
-- Name: organizationcaches; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizationcaches (
    id character varying(256) NOT NULL,
    name character varying(512),
    url character varying(256),
    description character varying(16384),
    emails jsonb,
    phonenumbers jsonb,
    logo character varying(256),
    tags jsonb,
    twitter jsonb,
    linkedin jsonb,
    crunchbase jsonb,
    employees integer,
    revenuerange jsonb,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    enriched boolean,
    location character varying(256),
    github jsonb,
    website character varying(256),
    lastenrichedat timestamp with time zone,
    employeecountbycountry jsonb,
    type character varying(256),
    geolocation character varying(256),
    size character varying(256),
    ticker character varying(256),
    headline character varying(256),
    profiles jsonb,
    naics jsonb,
    address jsonb,
    industry character varying(256),
    founded integer,
    manuallycreated boolean,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizationcaches OWNER TO crowd;

--
-- Name: organizationidentities; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizationidentities (
    name character varying(512) NOT NULL,
    organizationid character varying(256) NOT NULL,
    platform character varying(256) NOT NULL,
    sourceid character varying(256),
    url character varying(256),
    tenantid character varying(256),
    integrationid character varying(256),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizationidentities OWNER TO crowd;

--
-- Name: organizationnomerge; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizationnomerge (
    nomergeid character varying(256) NOT NULL,
    organizationid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizationnomerge OWNER TO crowd;

--
-- Name: organizationsegments; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizationsegments (
    _fivetran_id character varying(256) NOT NULL,
    organizationid character varying(256),
    segmentid character varying(256),
    tenantid character varying(256),
    createdat timestamp with time zone,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizationsegments OWNER TO crowd;

--
-- Name: organizationssyncremote; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizationssyncremote (
    id character varying(256) NOT NULL,
    organizationid character varying(256),
    sourceid character varying(256),
    integrationid character varying(256),
    syncfrom character varying(256),
    metadata character varying(256),
    lastsyncedat timestamp with time zone,
    status character varying(256),
    lastsyncedpayload jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizationssyncremote OWNER TO crowd;

--
-- Name: organizationtomerge; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.organizationtomerge (
    organizationid character varying(256) NOT NULL,
    tomergeid character varying(256) NOT NULL,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    similarity double precision,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.organizationtomerge OWNER TO crowd;

--
-- Name: recurringemailshistory; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.recurringemailshistory (
    id character varying(256) NOT NULL,
    emailsentat timestamp with time zone,
    tenantid character varying(256),
    weekofyear character varying(256),
    emailsentto jsonb,
    type character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.recurringemailshistory OWNER TO crowd;

--
-- Name: reports; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.reports (
    id character varying(256) NOT NULL,
    public boolean,
    name character varying(256),
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    istemplate boolean,
    viewedby jsonb,
    segmentid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.reports OWNER TO crowd;

--
-- Name: segmentactivitychannels; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.segmentactivitychannels (
    id character varying(256) NOT NULL,
    tenantid character varying(256),
    segmentid character varying(256),
    platform character varying(256),
    channel character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.segmentactivitychannels OWNER TO crowd;

--
-- Name: settings; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.settings (
    id character varying(1020) NOT NULL,
    website character varying(1020),
    backgroundimageurl character varying(4096),
    logourl character varying(4096),
    attributesettings jsonb,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    slackwebhook character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.settings OWNER TO crowd;

--
-- Name: tags; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.tags (
    id character varying(256) NOT NULL,
    name character varying(256),
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.tags OWNER TO crowd;

--
-- Name: taskassignees; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.taskassignees (
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    taskid character varying(256) NOT NULL,
    userid character varying(256) NOT NULL,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.taskassignees OWNER TO crowd;

--
-- Name: tasks; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.tasks (
    id character varying(256) NOT NULL,
    name character varying(256),
    body character varying(256),
    status character varying(1020),
    duedate timestamp with time zone,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    type character varying(256),
    segmentid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.tasks OWNER TO crowd;

--
-- Name: tenants; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.tenants (
    id character varying(256) NOT NULL,
    name character varying(1020),
    url character varying(200),
    integrationsrequired jsonb,
    communitysize character varying(200),
    plan character varying(256),
    onboardedat timestamp with time zone,
    hassampledata boolean,
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    createdbyid character varying(256),
    updatedbyid character varying(256),
    istrialplan boolean,
    trialendsat timestamp with time zone,
    plansubscriptionendsat timestamp with time zone,
    stripesubscriptionid character varying(256),
    reasonforusingcrowd character varying(1020),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.tenants OWNER TO crowd;

--
-- Name: tenantusers; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.tenantusers (
    id character varying(256) NOT NULL,
    roles jsonb,
    invitationtoken character varying(1020),
    status character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    tenantid character varying(256),
    userid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    settings jsonb,
    invitedbyid character varying(256),
    adminsegments jsonb,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.tenantusers OWNER TO crowd;

--
-- Name: users; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.users (
    id character varying(256) NOT NULL,
    fullname character varying(1020),
    firstname character varying(320),
    password character varying(1020),
    emailverified boolean,
    emailverificationtoken character varying(1020),
    emailverificationtokenexpiresat timestamp with time zone,
    provider character varying(1020),
    providerid character varying(8096),
    passwordresettoken character varying(1020),
    passwordresettokenexpiresat timestamp with time zone,
    lastname character varying(700),
    phonenumber character varying(96),
    email character varying(1020),
    jwttokeninvalidbefore timestamp with time zone,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    createdbyid character varying(256),
    updatedbyid character varying(256),
    acceptedtermsandprivacy boolean,
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.users OWNER TO crowd;

--
-- Name: widgets; Type: TABLE; Schema: crowd_public; Owner: crowd
--

CREATE TABLE crowd_public.widgets (
    id character varying(256) NOT NULL,
    type character varying(256),
    title character varying(256),
    settings jsonb,
    cache jsonb,
    importhash character varying(1020),
    createdat timestamp with time zone,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone,
    reportid character varying(256),
    tenantid character varying(256),
    createdbyid character varying(256),
    updatedbyid character varying(256),
    segmentid character varying(256),
    _fivetran_deleted boolean,
    _fivetran_synced timestamp with time zone
);


ALTER TABLE crowd_public.widgets OWNER TO crowd;

--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: activitytasks activitytasks_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.activitytasks
    ADD CONSTRAINT activitytasks_pkey PRIMARY KEY (activityid, taskid);


--
-- Name: auditlogs auditlogs_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.auditlogs
    ADD CONSTRAINT auditlogs_pkey PRIMARY KEY (id);


--
-- Name: automationexecutions automationexecutions_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.automationexecutions
    ADD CONSTRAINT automationexecutions_pkey PRIMARY KEY (id);


--
-- Name: automations automations_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.automations
    ADD CONSTRAINT automations_pkey PRIMARY KEY (id);


--
-- Name: awsdms_ddl_audit awsdms_ddl_audit_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.awsdms_ddl_audit
    ADD CONSTRAINT awsdms_ddl_audit_pkey PRIMARY KEY (c_key);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: conversationsettings conversationsettings_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.conversationsettings
    ADD CONSTRAINT conversationsettings_pkey PRIMARY KEY (id);


--
-- Name: eagleeyeactions eagleeyeactions_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.eagleeyeactions
    ADD CONSTRAINT eagleeyeactions_pkey PRIMARY KEY (id);


--
-- Name: eagleeyecontents eagleeyecontents_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.eagleeyecontents
    ADD CONSTRAINT eagleeyecontents_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: fivetran_audit fivetran_audit_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.fivetran_audit
    ADD CONSTRAINT fivetran_audit_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pkey PRIMARY KEY (installed_rank);


--
-- Name: githubrepos githubrepos_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.githubrepos
    ADD CONSTRAINT githubrepos_pkey PRIMARY KEY (id);


--
-- Name: incomingwebhooks incomingwebhooks_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.incomingwebhooks
    ADD CONSTRAINT incomingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: integrationruns integrationruns_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.integrationruns
    ADD CONSTRAINT integrationruns_pkey PRIMARY KEY (id);


--
-- Name: integrations integrations_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.integrations
    ADD CONSTRAINT integrations_pkey PRIMARY KEY (id);


--
-- Name: integrationstreams integrationstreams_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.integrationstreams
    ADD CONSTRAINT integrationstreams_pkey PRIMARY KEY (id);


--
-- Name: memberattributesettings memberattributesettings_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.memberattributesettings
    ADD CONSTRAINT memberattributesettings_pkey PRIMARY KEY (id);


--
-- Name: memberenrichmentcache memberenrichmentcache_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.memberenrichmentcache
    ADD CONSTRAINT memberenrichmentcache_pkey PRIMARY KEY (memberid);


--
-- Name: memberidentities memberidentities_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.memberidentities
    ADD CONSTRAINT memberidentities_pkey PRIMARY KEY (memberid, platform, username);


--
-- Name: membernomerge membernomerge_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membernomerge
    ADD CONSTRAINT membernomerge_pkey PRIMARY KEY (memberid, nomergeid);


--
-- Name: membernotes membernotes_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membernotes
    ADD CONSTRAINT membernotes_pkey PRIMARY KEY (memberid, noteid);


--
-- Name: memberorganizations memberorganizations_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.memberorganizations
    ADD CONSTRAINT memberorganizations_pkey PRIMARY KEY (id);


--
-- Name: members members_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- Name: membersegmentaffiliations membersegmentaffiliations_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membersegmentaffiliations
    ADD CONSTRAINT membersegmentaffiliations_pkey PRIMARY KEY (id);


--
-- Name: membersegments membersegments_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membersegments
    ADD CONSTRAINT membersegments_pkey PRIMARY KEY (_fivetran_id);


--
-- Name: memberssyncremote memberssyncremote_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.memberssyncremote
    ADD CONSTRAINT memberssyncremote_pkey PRIMARY KEY (id);


--
-- Name: membertags membertags_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membertags
    ADD CONSTRAINT membertags_pkey PRIMARY KEY (memberid, tagid);


--
-- Name: membertasks membertasks_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membertasks
    ADD CONSTRAINT membertasks_pkey PRIMARY KEY (memberid, taskid);


--
-- Name: membertomerge membertomerge_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.membertomerge
    ADD CONSTRAINT membertomerge_pkey PRIMARY KEY (memberid, tomergeid);


--
-- Name: microservices microservices_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.microservices
    ADD CONSTRAINT microservices_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: organizationcaches organizationcaches_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizationcaches
    ADD CONSTRAINT organizationcaches_pkey PRIMARY KEY (id);


--
-- Name: organizationidentities organizationidentities_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizationidentities
    ADD CONSTRAINT organizationidentities_pkey PRIMARY KEY (name, organizationid, platform);


--
-- Name: organizationnomerge organizationnomerge_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizationnomerge
    ADD CONSTRAINT organizationnomerge_pkey PRIMARY KEY (nomergeid, organizationid);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: organizationsegments organizationsegments_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizationsegments
    ADD CONSTRAINT organizationsegments_pkey PRIMARY KEY (_fivetran_id);


--
-- Name: organizationssyncremote organizationssyncremote_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizationssyncremote
    ADD CONSTRAINT organizationssyncremote_pkey PRIMARY KEY (id);


--
-- Name: organizationtomerge organizationtomerge_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.organizationtomerge
    ADD CONSTRAINT organizationtomerge_pkey PRIMARY KEY (organizationid, tomergeid);


--
-- Name: recurringemailshistory recurringemailshistory_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.recurringemailshistory
    ADD CONSTRAINT recurringemailshistory_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: segmentactivitychannels segmentactivitychannels_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.segmentactivitychannels
    ADD CONSTRAINT segmentactivitychannels_pkey PRIMARY KEY (id);


--
-- Name: segments segments_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.segments
    ADD CONSTRAINT segments_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: taskassignees taskassignees_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.taskassignees
    ADD CONSTRAINT taskassignees_pkey PRIMARY KEY (taskid, userid);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: tenantusers tenantusers_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.tenantusers
    ADD CONSTRAINT tenantusers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: widgets widgets_pkey; Type: CONSTRAINT; Schema: crowd_public; Owner: crowd
--

ALTER TABLE ONLY crowd_public.widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (id);


--
-- Name: activities_attributes_additions_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_attributes_additions_idx ON crowd_public.activities USING btree (((attributes ->> 'additions'::text)));


--
-- Name: activities_attributes_deletions_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_attributes_deletions_idx ON crowd_public.activities USING btree (((attributes ->> 'deletions'::text)));


--
-- Name: activities_attributes_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_attributes_idx ON crowd_public.activities USING gin (attributes);


--
-- Name: activities_attributes_is_main_branch_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_attributes_is_main_branch_idx ON crowd_public.activities USING btree (((attributes ->> 'isMainBranch'::text)));


--
-- Name: activities_attributes_pr_state_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_attributes_pr_state_idx ON crowd_public.activities USING btree (((attributes ->> 'state'::text)));


--
-- Name: activities_attributes_review_state_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_attributes_review_state_idx ON crowd_public.activities USING btree (((attributes ->> 'reviewState'::text)));


--
-- Name: activities_channel_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_channel_idx ON crowd_public.activities USING btree (channel);


--
-- Name: activities_contribution_url_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_contribution_url_idx ON crowd_public.activities USING btree (split_part((url)::text, '#'::text, 1));


--
-- Name: activities_deleted_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_deleted_at_idx ON crowd_public.activities USING btree (deletedat);


--
-- Name: activities_member_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_member_id_idx ON crowd_public.activities USING btree (memberid);


--
-- Name: activities_organization_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_organization_id_idx ON crowd_public.activities USING btree (organizationid);


--
-- Name: activities_platform_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_platform_idx ON crowd_public.activities USING btree (platform);


--
-- Name: activities_repo_organization_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_repo_organization_idx ON crowd_public.activities USING btree (split_part((channel)::text, '/'::text, 4));


--
-- Name: activities_segment_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_segment_id_idx ON crowd_public.activities USING btree (segmentid);


--
-- Name: activities_tenant_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_tenant_id_idx ON crowd_public.activities USING btree (tenantid);


--
-- Name: activities_timestamp_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_timestamp_idx ON crowd_public.activities USING btree ("timestamp");


--
-- Name: activities_type_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_type_idx ON crowd_public.activities USING btree (type);


--
-- Name: activities_url_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_url_idx ON crowd_public.activities USING btree (url);


--
-- Name: activities_username_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX activities_username_idx ON crowd_public.activities USING btree (username);


--
-- Name: idx_mv_active_days_aggregation_type; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_aggregation_type ON crowd_public.mv_active_days USING btree (aggregation_type);


--
-- Name: idx_mv_active_days_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_member_id ON crowd_public.mv_active_days USING btree (member_id);


--
-- Name: idx_mv_active_days_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_active_days_pk_id ON crowd_public.mv_active_days USING btree (pk_id);


--
-- Name: idx_mv_active_days_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_platform ON crowd_public.mv_active_days USING btree (platform);


--
-- Name: idx_mv_active_days_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_repo_organization ON crowd_public.mv_active_days USING btree (repo_organization);


--
-- Name: idx_mv_active_days_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_repository_url ON crowd_public.mv_active_days USING btree (repository_url);


--
-- Name: idx_mv_active_days_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_segment_id ON crowd_public.mv_active_days USING btree (segment_id);


--
-- Name: idx_mv_active_days_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_username ON crowd_public.mv_active_days USING btree (username);


--
-- Name: idx_mv_active_days_ymd; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_active_days_ymd ON crowd_public.mv_active_days USING btree (ymd);


--
-- Name: idx_mv_commits_bus_factor_cumulative_percent; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_cumulative_percent ON crowd_public.mv_commits_bus_factor USING btree (cumulative_percent);


--
-- Name: idx_mv_commits_bus_factor_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_member_id ON crowd_public.mv_commits_bus_factor USING btree (member_id);


--
-- Name: idx_mv_commits_bus_factor_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_commits_bus_factor_pk_id ON crowd_public.mv_commits_bus_factor USING btree (pk_id);


--
-- Name: idx_mv_commits_bus_factor_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_platform ON crowd_public.mv_commits_bus_factor USING btree (platform);


--
-- Name: idx_mv_commits_bus_factor_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_repo_organization ON crowd_public.mv_commits_bus_factor USING btree (repo_organization);


--
-- Name: idx_mv_commits_bus_factor_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_repository_url ON crowd_public.mv_commits_bus_factor USING btree (repository_url);


--
-- Name: idx_mv_commits_bus_factor_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_segment_id ON crowd_public.mv_commits_bus_factor USING btree (segment_id);


--
-- Name: idx_mv_commits_bus_factor_tenant_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_tenant_id ON crowd_public.mv_commits_bus_factor USING btree (tenant_id);


--
-- Name: idx_mv_commits_bus_factor_time_range_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_time_range_name ON crowd_public.mv_commits_bus_factor USING btree (time_range_name);


--
-- Name: idx_mv_commits_bus_factor_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_commits_bus_factor_username ON crowd_public.mv_commits_bus_factor USING btree (username);


--
-- Name: idx_mv_contributors_first_contributions_channel; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_contributors_first_contributions_channel ON crowd_public.mv_contributors_first_contributions USING btree (channel);


--
-- Name: idx_mv_contributors_first_contributions_foundation; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_contributors_first_contributions_foundation ON crowd_public.mv_contributors_first_contributions USING btree (foundation);


--
-- Name: idx_mv_contributors_first_contributions_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_contributors_first_contributions_id ON crowd_public.mv_contributors_first_contributions USING btree (pkid);


--
-- Name: idx_mv_contributors_first_contributions_project; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_contributors_first_contributions_project ON crowd_public.mv_contributors_first_contributions USING btree (project);


--
-- Name: idx_mv_da_committers_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_committers_member_id ON crowd_public.mv_da_committers USING btree (member_id);


--
-- Name: idx_mv_da_committers_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_da_committers_pk_id ON crowd_public.mv_da_committers USING btree (pk_id);


--
-- Name: idx_mv_da_committers_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_committers_platform ON crowd_public.mv_da_committers USING btree (platform);


--
-- Name: idx_mv_da_committers_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_committers_repo_organization ON crowd_public.mv_da_committers USING btree (repo_organization);


--
-- Name: idx_mv_da_committers_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_committers_repository_url ON crowd_public.mv_da_committers USING btree (repository_url);


--
-- Name: idx_mv_da_committers_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_committers_segment_id ON crowd_public.mv_da_committers USING btree (segment_id);


--
-- Name: idx_mv_da_committers_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_committers_username ON crowd_public.mv_da_committers USING btree (username);


--
-- Name: idx_mv_da_contributors_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_contributors_member_id ON crowd_public.mv_da_contributors USING btree (member_id);


--
-- Name: idx_mv_da_contributors_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_da_contributors_pk_id ON crowd_public.mv_da_contributors USING btree (pk_id);


--
-- Name: idx_mv_da_contributors_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_contributors_platform ON crowd_public.mv_da_contributors USING btree (platform);


--
-- Name: idx_mv_da_contributors_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_contributors_repo_organization ON crowd_public.mv_da_contributors USING btree (repo_organization);


--
-- Name: idx_mv_da_contributors_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_contributors_repository_url ON crowd_public.mv_da_contributors USING btree (repository_url);


--
-- Name: idx_mv_da_contributors_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_contributors_segment_id ON crowd_public.mv_da_contributors USING btree (segment_id);


--
-- Name: idx_mv_da_contributors_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_contributors_username ON crowd_public.mv_da_contributors USING btree (username);


--
-- Name: idx_mv_da_issue_contributors_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_issue_contributors_member_id ON crowd_public.mv_da_issue_contributors USING btree (member_id);


--
-- Name: idx_mv_da_issue_contributors_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_da_issue_contributors_pk_id ON crowd_public.mv_da_issue_contributors USING btree (pk_id);


--
-- Name: idx_mv_da_issue_contributors_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_issue_contributors_platform ON crowd_public.mv_da_issue_contributors USING btree (platform);


--
-- Name: idx_mv_da_issue_contributors_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_issue_contributors_repo_organization ON crowd_public.mv_da_issue_contributors USING btree (repo_organization);


--
-- Name: idx_mv_da_issue_contributors_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_issue_contributors_repository_url ON crowd_public.mv_da_issue_contributors USING btree (repository_url);


--
-- Name: idx_mv_da_issue_contributors_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_issue_contributors_segment_id ON crowd_public.mv_da_issue_contributors USING btree (segment_id);


--
-- Name: idx_mv_da_issue_contributors_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_issue_contributors_username ON crowd_public.mv_da_issue_contributors USING btree (username);


--
-- Name: idx_mv_da_pr_contributors_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_pr_contributors_member_id ON crowd_public.mv_da_pr_contributors USING btree (member_id);


--
-- Name: idx_mv_da_pr_contributors_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_da_pr_contributors_pk_id ON crowd_public.mv_da_pr_contributors USING btree (pk_id);


--
-- Name: idx_mv_da_pr_contributors_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_pr_contributors_platform ON crowd_public.mv_da_pr_contributors USING btree (platform);


--
-- Name: idx_mv_da_pr_contributors_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_pr_contributors_repo_organization ON crowd_public.mv_da_pr_contributors USING btree (repo_organization);


--
-- Name: idx_mv_da_pr_contributors_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_pr_contributors_repository_url ON crowd_public.mv_da_pr_contributors USING btree (repository_url);


--
-- Name: idx_mv_da_pr_contributors_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_pr_contributors_segment_id ON crowd_public.mv_da_pr_contributors USING btree (segment_id);


--
-- Name: idx_mv_da_pr_contributors_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_da_pr_contributors_username ON crowd_public.mv_da_pr_contributors USING btree (username);


--
-- Name: idx_mv_member_contributions_country; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_member_contributions_country ON crowd_public.mv_member_contributions USING btree (country);


--
-- Name: idx_mv_member_contributions_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_member_contributions_id ON crowd_public.mv_member_contributions USING btree (pkid);


--
-- Name: idx_mv_member_contributions_identifier; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_member_contributions_identifier ON crowd_public.mv_member_contributions USING btree (identifier);


--
-- Name: idx_mv_member_contributions_org_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_member_contributions_org_url ON crowd_public.mv_member_contributions USING btree (organization_url);


--
-- Name: idx_mv_members_country; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_members_country ON crowd_public.mv_members USING btree (country);


--
-- Name: idx_mv_members_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_members_id ON crowd_public.mv_members USING btree (id);


--
-- Name: idx_mv_members_is_bot; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_members_is_bot ON crowd_public.mv_members USING btree (is_bot);


--
-- Name: idx_mv_members_joined_at; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_members_joined_at ON crowd_public.mv_members USING btree (joinedat);


--
-- Name: idx_mv_new_activities_aggregation_period; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_aggregation_period ON crowd_public.mv_new_activities USING btree (aggregation_period);


--
-- Name: idx_mv_new_activities_contribution_type; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_contribution_type ON crowd_public.mv_new_activities USING btree (contribution_type);


--
-- Name: idx_mv_new_activities_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_member_id ON crowd_public.mv_new_activities USING btree (member_id);


--
-- Name: idx_mv_new_activities_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_new_activities_pk_id ON crowd_public.mv_new_activities USING btree (pk_id);


--
-- Name: idx_mv_new_activities_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_platform ON crowd_public.mv_new_activities USING btree (platform);


--
-- Name: idx_mv_new_activities_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_repo_organization ON crowd_public.mv_new_activities USING btree (repo_organization);


--
-- Name: idx_mv_new_activities_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_repository_url ON crowd_public.mv_new_activities USING btree (repository_url);


--
-- Name: idx_mv_new_activities_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_segment_id ON crowd_public.mv_new_activities USING btree (segment_id);


--
-- Name: idx_mv_new_activities_timestamp; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_timestamp ON crowd_public.mv_new_activities USING btree ("timestamp");


--
-- Name: idx_mv_new_activities_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_new_activities_username ON crowd_public.mv_new_activities USING btree (username);


--
-- Name: idx_mv_org_bus_factor_cumulative_percent; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_cumulative_percent ON crowd_public.mv_org_bus_factor USING btree (cumulative_percent);


--
-- Name: idx_mv_org_bus_factor_org_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_org_id ON crowd_public.mv_org_bus_factor USING btree (org_id);


--
-- Name: idx_mv_org_bus_factor_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_org_bus_factor_pk_id ON crowd_public.mv_org_bus_factor USING btree (pk_id);


--
-- Name: idx_mv_org_bus_factor_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_repo_organization ON crowd_public.mv_org_bus_factor USING btree (repo_organization);


--
-- Name: idx_mv_org_bus_factor_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_repository_url ON crowd_public.mv_org_bus_factor USING btree (repository_url);


--
-- Name: idx_mv_org_bus_factor_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_segment_id ON crowd_public.mv_org_bus_factor USING btree (segment_id);


--
-- Name: idx_mv_org_bus_factor_tenant_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_tenant_id ON crowd_public.mv_org_bus_factor USING btree (tenant_id);


--
-- Name: idx_mv_org_bus_factor_time_range_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_time_range_name ON crowd_public.mv_org_bus_factor USING btree (time_range_name);


--
-- Name: idx_mv_org_bus_factor_type; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_bus_factor_type ON crowd_public.mv_org_bus_factor USING btree (type);


--
-- Name: idx_mv_org_commits_bus_factor_cumulative_percent; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_cumulative_percent ON crowd_public.mv_org_commits_bus_factor USING btree (cumulative_percent);


--
-- Name: idx_mv_org_commits_bus_factor_org_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_org_id ON crowd_public.mv_org_commits_bus_factor USING btree (org_id);


--
-- Name: idx_mv_org_commits_bus_factor_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_org_commits_bus_factor_pk_id ON crowd_public.mv_org_commits_bus_factor USING btree (pk_id);


--
-- Name: idx_mv_org_commits_bus_factor_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_repo_organization ON crowd_public.mv_org_commits_bus_factor USING btree (repo_organization);


--
-- Name: idx_mv_org_commits_bus_factor_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_repository_url ON crowd_public.mv_org_commits_bus_factor USING btree (repository_url);


--
-- Name: idx_mv_org_commits_bus_factor_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_segment_id ON crowd_public.mv_org_commits_bus_factor USING btree (segment_id);


--
-- Name: idx_mv_org_commits_bus_factor_tenant_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_tenant_id ON crowd_public.mv_org_commits_bus_factor USING btree (tenant_id);


--
-- Name: idx_mv_org_commits_bus_factor_time_range_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_org_commits_bus_factor_time_range_name ON crowd_public.mv_org_commits_bus_factor USING btree (time_range_name);


--
-- Name: idx_mv_pr_engagement_gap_granularity; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_pr_engagement_gap_granularity ON crowd_public.mv_pr_engagement_gap USING btree (granularity);


--
-- Name: idx_mv_pr_engagement_gap_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_pr_engagement_gap_id ON crowd_public.mv_pr_engagement_gap USING btree (id);


--
-- Name: idx_mv_pr_engagement_gap_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_pr_engagement_gap_repo_organization ON crowd_public.mv_pr_engagement_gap USING btree (repo_organization);


--
-- Name: idx_mv_pr_engagement_gap_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_pr_engagement_gap_repository_url ON crowd_public.mv_pr_engagement_gap USING btree (repository_url);


--
-- Name: idx_mv_pr_engagement_gap_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_pr_engagement_gap_segment_id ON crowd_public.mv_pr_engagement_gap USING btree (segment_id);


--
-- Name: idx_mv_pr_engagement_gap_timestamp; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_pr_engagement_gap_timestamp ON crowd_public.mv_pr_engagement_gap USING btree ("timestamp");


--
-- Name: idx_mv_segment_card_github_org; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_card_github_org ON crowd_public.mv_segment_card USING btree (github_org);


--
-- Name: idx_mv_segment_card_last_activity; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_card_last_activity ON crowd_public.mv_segment_card USING btree (last_activity);


--
-- Name: idx_mv_segment_card_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_segment_card_pk_id ON crowd_public.mv_segment_card USING btree (pk_id);


--
-- Name: idx_mv_segment_card_project_group_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_card_project_group_slug ON crowd_public.mv_segment_card USING btree (project_group_slug);


--
-- Name: idx_mv_segment_card_project_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_card_project_slug ON crowd_public.mv_segment_card USING btree (project_slug);


--
-- Name: idx_mv_segment_card_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_card_slug ON crowd_public.mv_segment_card USING btree (slug);


--
-- Name: idx_mv_segment_card_subproject_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_card_subproject_slug ON crowd_public.mv_segment_card USING btree (subproject_slug);


--
-- Name: idx_mv_segment_yearly_stats_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_segment_yearly_stats_id ON crowd_public.mv_segment_yearly_stats USING btree (id);


--
-- Name: idx_mv_segment_yearly_stats_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_yearly_stats_segment_id ON crowd_public.mv_segment_yearly_stats USING btree (segment_id);


--
-- Name: idx_mv_segment_yearly_stats_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_yearly_stats_slug ON crowd_public.mv_segment_yearly_stats USING btree (slug);


--
-- Name: idx_mv_segment_yearly_stats_year; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segment_yearly_stats_year ON crowd_public.mv_segment_yearly_stats USING btree (year);


--
-- Name: idx_mv_segments_foundation_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_foundation_name ON crowd_public.mv_segments USING btree (foundation_name);


--
-- Name: idx_mv_segments_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_segments_id ON crowd_public.mv_segments USING btree (id);


--
-- Name: idx_mv_segments_level; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_level ON crowd_public.mv_segments USING btree (level);


--
-- Name: idx_mv_segments_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_name ON crowd_public.mv_segments USING btree (name);


--
-- Name: idx_mv_segments_project_group_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_project_group_name ON crowd_public.mv_segments USING btree (project_group_name);


--
-- Name: idx_mv_segments_project_group_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_project_group_slug ON crowd_public.mv_segments USING btree (project_group_slug);


--
-- Name: idx_mv_segments_project_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_project_slug ON crowd_public.mv_segments USING btree (project_slug);


--
-- Name: idx_mv_segments_project_type; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_project_type ON crowd_public.mv_segments USING btree (project_type);


--
-- Name: idx_mv_segments_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_segment_id ON crowd_public.mv_segments USING btree (segment_id);


--
-- Name: idx_mv_segments_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_slug ON crowd_public.mv_segments USING btree (slug);


--
-- Name: idx_mv_segments_status; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_status ON crowd_public.mv_segments USING btree (status);


--
-- Name: idx_mv_segments_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_segments_url ON crowd_public.mv_segments USING btree (url);


--
-- Name: idx_mv_subprojects_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_id ON crowd_public.mv_subprojects USING btree (id);


--
-- Name: idx_mv_subprojects_level; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_level ON crowd_public.mv_subprojects USING btree (level);


--
-- Name: idx_mv_subprojects_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_subprojects_pk_id ON crowd_public.mv_subprojects USING btree (pk_id);


--
-- Name: idx_mv_subprojects_project_group_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_project_group_name ON crowd_public.mv_subprojects USING btree (project_group_name);


--
-- Name: idx_mv_subprojects_project_group_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_project_group_slug ON crowd_public.mv_subprojects USING btree (project_group_slug);


--
-- Name: idx_mv_subprojects_project_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_project_name ON crowd_public.mv_subprojects USING btree (project_name);


--
-- Name: idx_mv_subprojects_project_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_project_slug ON crowd_public.mv_subprojects USING btree (project_slug);


--
-- Name: idx_mv_subprojects_repositories_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_id ON crowd_public.mv_subprojects_repositories USING btree (id);


--
-- Name: idx_mv_subprojects_repositories_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_subprojects_repositories_pk_id ON crowd_public.mv_subprojects_repositories USING btree (pk_id);


--
-- Name: idx_mv_subprojects_repositories_project_group_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_project_group_name ON crowd_public.mv_subprojects_repositories USING btree (project_group_name);


--
-- Name: idx_mv_subprojects_repositories_project_group_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_project_group_slug ON crowd_public.mv_subprojects_repositories USING btree (project_group_slug);


--
-- Name: idx_mv_subprojects_repositories_project_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_project_name ON crowd_public.mv_subprojects_repositories USING btree (project_name);


--
-- Name: idx_mv_subprojects_repositories_project_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_project_slug ON crowd_public.mv_subprojects_repositories USING btree (project_slug);


--
-- Name: idx_mv_subprojects_repositories_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_repo_organization ON crowd_public.mv_subprojects_repositories USING btree (repo_organization);


--
-- Name: idx_mv_subprojects_repositories_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_repository_url ON crowd_public.mv_subprojects_repositories USING btree (repository_url);


--
-- Name: idx_mv_subprojects_repositories_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_segment_id ON crowd_public.mv_subprojects_repositories USING btree (segment_id);


--
-- Name: idx_mv_subprojects_repositories_status; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_status ON crowd_public.mv_subprojects_repositories USING btree (status);


--
-- Name: idx_mv_subprojects_repositories_subproject_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_subproject_name ON crowd_public.mv_subprojects_repositories USING btree (subproject_name);


--
-- Name: idx_mv_subprojects_repositories_subproject_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_repositories_subproject_slug ON crowd_public.mv_subprojects_repositories USING btree (subproject_slug);


--
-- Name: idx_mv_subprojects_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_segment_id ON crowd_public.mv_subprojects USING btree (segment_id);


--
-- Name: idx_mv_subprojects_status; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_status ON crowd_public.mv_subprojects USING btree (status);


--
-- Name: idx_mv_subprojects_subproject_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_subproject_name ON crowd_public.mv_subprojects USING btree (subproject_name);


--
-- Name: idx_mv_subprojects_subproject_slug; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_subprojects_subproject_slug ON crowd_public.mv_subprojects USING btree (subproject_slug);


--
-- Name: idx_mv_time_ranges_curr; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_time_ranges_curr ON crowd_public.mv_time_ranges USING btree (curr);


--
-- Name: idx_mv_time_ranges_time_range_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_time_ranges_time_range_name ON crowd_public.mv_time_ranges USING btree (time_range_name);


--
-- Name: idx_mv_type_bus_factor_cumulative_percent; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_cumulative_percent ON crowd_public.mv_type_bus_factor USING btree (cumulative_percent);


--
-- Name: idx_mv_type_bus_factor_member_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_member_id ON crowd_public.mv_type_bus_factor USING btree (member_id);


--
-- Name: idx_mv_type_bus_factor_pk_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE UNIQUE INDEX idx_mv_type_bus_factor_pk_id ON crowd_public.mv_type_bus_factor USING btree (pk_id);


--
-- Name: idx_mv_type_bus_factor_platform; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_platform ON crowd_public.mv_type_bus_factor USING btree (platform);


--
-- Name: idx_mv_type_bus_factor_repo_organization; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_repo_organization ON crowd_public.mv_type_bus_factor USING btree (repo_organization);


--
-- Name: idx_mv_type_bus_factor_repository_url; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_repository_url ON crowd_public.mv_type_bus_factor USING btree (repository_url);


--
-- Name: idx_mv_type_bus_factor_segment_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_segment_id ON crowd_public.mv_type_bus_factor USING btree (segment_id);


--
-- Name: idx_mv_type_bus_factor_tenant_id; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_tenant_id ON crowd_public.mv_type_bus_factor USING btree (tenant_id);


--
-- Name: idx_mv_type_bus_factor_time_range_name; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_time_range_name ON crowd_public.mv_type_bus_factor USING btree (time_range_name);


--
-- Name: idx_mv_type_bus_factor_type; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_type ON crowd_public.mv_type_bus_factor USING btree (type);


--
-- Name: idx_mv_type_bus_factor_username; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX idx_mv_type_bus_factor_username ON crowd_public.mv_type_bus_factor USING btree (username);


--
-- Name: integrations_deleted_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX integrations_deleted_at_idx ON crowd_public.integrations USING btree (deletedat);


--
-- Name: integrations_platform_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX integrations_platform_idx ON crowd_public.integrations USING btree (platform);


--
-- Name: integrations_segment_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX integrations_segment_id_idx ON crowd_public.integrations USING btree (segmentid);


--
-- Name: integrations_settings_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX integrations_settings_idx ON crowd_public.integrations USING gin (settings);


--
-- Name: integrations_status_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX integrations_status_idx ON crowd_public.integrations USING btree (status);


--
-- Name: integrations_tenant_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX integrations_tenant_id_idx ON crowd_public.integrations USING btree (tenantid);


--
-- Name: member_identities_integration_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_identities_integration_id_idx ON crowd_public.memberidentities USING btree (integrationid);


--
-- Name: member_identities_member_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_identities_member_id_idx ON crowd_public.memberidentities USING btree (memberid);


--
-- Name: member_identities_platform_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_identities_platform_idx ON crowd_public.memberidentities USING btree (platform);


--
-- Name: member_identities_source_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_identities_source_id_idx ON crowd_public.memberidentities USING btree (sourceid);


--
-- Name: member_identities_tenant_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_identities_tenant_id_idx ON crowd_public.memberidentities USING btree (tenantid);


--
-- Name: member_identities_username_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_identities_username_idx ON crowd_public.memberidentities USING btree (username);


--
-- Name: member_organizations_date_end_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_organizations_date_end_idx ON crowd_public.memberorganizations USING btree (dateend);


--
-- Name: member_organizations_date_start_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_organizations_date_start_idx ON crowd_public.memberorganizations USING btree (datestart);


--
-- Name: member_organizations_deleted_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_organizations_deleted_at_idx ON crowd_public.memberorganizations USING btree (deletedat);


--
-- Name: member_organizations_member_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_organizations_member_id_idx ON crowd_public.memberorganizations USING btree (memberid);


--
-- Name: member_organizations_organization_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_organizations_organization_id_idx ON crowd_public.memberorganizations USING btree (organizationid);


--
-- Name: member_organizations_source_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX member_organizations_source_idx ON crowd_public.memberorganizations USING btree (source);


--
-- Name: members_attributes_avatar_url_custom_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_custom_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'custom'::text)));


--
-- Name: members_attributes_avatar_url_default_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_default_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'default'::text)));


--
-- Name: members_attributes_avatar_url_enrichment_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_enrichment_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'enrichment'::text)));


--
-- Name: members_attributes_avatar_url_github_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_github_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'github'::text)));


--
-- Name: members_attributes_avatar_url_linkedin_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_linkedin_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'linkedin'::text)));


--
-- Name: members_attributes_avatar_url_slack_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_slack_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'slack'::text)));


--
-- Name: members_attributes_avatar_url_twitter_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_avatar_url_twitter_idx ON crowd_public.members USING btree ((((attributes -> 'avatarUrl'::text) ->> 'twitter'::text)));


--
-- Name: members_attributes_country_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_country_idx ON crowd_public.members USING btree ((((attributes -> 'country'::text) ->> 'enrichment'::text)));


--
-- Name: members_attributes_github_url_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_github_url_idx ON crowd_public.members USING btree ((((attributes -> 'url'::text) ->> 'github'::text)));


--
-- Name: members_attributes_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_idx ON crowd_public.members USING gin (attributes);


--
-- Name: members_attributes_is_bot_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_is_bot_idx ON crowd_public.members USING btree ((((attributes -> 'isBot'::text) ->> 'default'::text)));


--
-- Name: members_attributes_linkedin_url_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_linkedin_url_idx ON crowd_public.members USING btree ((((attributes -> 'url'::text) ->> 'linkedin'::text)));


--
-- Name: members_attributes_twitter_url_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_attributes_twitter_url_idx ON crowd_public.members USING btree ((((attributes -> 'url'::text) ->> 'twitter'::text)));


--
-- Name: members_deleted_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_deleted_at_idx ON crowd_public.members USING btree (deletedat);


--
-- Name: members_display_name_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_display_name_idx ON crowd_public.members USING btree (displayname);


--
-- Name: members_joined_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_joined_at_idx ON crowd_public.members USING btree (joinedat);


--
-- Name: members_tenant_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_tenant_id_idx ON crowd_public.members USING btree (tenantid);


--
-- Name: members_username_old_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX members_username_old_idx ON crowd_public.members USING btree (usernameold);


--
-- Name: organizations_attributes_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_attributes_idx ON crowd_public.organizations USING gin (attributes);


--
-- Name: organizations_created_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_created_at_idx ON crowd_public.organizations USING btree (createdat);


--
-- Name: organizations_deleted_at_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_deleted_at_idx ON crowd_public.organizations USING btree (deletedat);


--
-- Name: organizations_display_name_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_display_name_idx ON crowd_public.organizations USING btree (displayname);


--
-- Name: organizations_size_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_size_idx ON crowd_public.organizations USING btree (size);


--
-- Name: organizations_tenant_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_tenant_id_idx ON crowd_public.organizations USING btree (tenantid);


--
-- Name: organizations_type_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX organizations_type_idx ON crowd_public.organizations USING btree (type);


--
-- Name: segments_grand_parent_name_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_grand_parent_name_idx ON crowd_public.segments USING btree (grandparentname);


--
-- Name: segments_grand_parent_slug_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_grand_parent_slug_idx ON crowd_public.segments USING btree (grandparentslug);


--
-- Name: segments_name_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_name_idx ON crowd_public.segments USING btree (name);


--
-- Name: segments_parent_name_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_parent_name_idx ON crowd_public.segments USING btree (parentname);


--
-- Name: segments_parent_slug_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_parent_slug_idx ON crowd_public.segments USING btree (parentslug);


--
-- Name: segments_slug_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_slug_idx ON crowd_public.segments USING btree (slug);


--
-- Name: segments_status_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_status_idx ON crowd_public.segments USING btree (status);


--
-- Name: segments_tenant_id_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_tenant_id_idx ON crowd_public.segments USING btree (tenantid);


--
-- Name: segments_url_idx; Type: INDEX; Schema: crowd_public; Owner: crowd
--

CREATE INDEX segments_url_idx ON crowd_public.segments USING btree (url);


--
-- Name: SCHEMA crowd_public; Type: ACL; Schema: -; Owner: crowd
--

GRANT USAGE ON SCHEMA crowd_public TO crowd_ro;
GRANT USAGE ON SCHEMA crowd_public TO cube;


--
-- Name: SCHEMA datadog; Type: ACL; Schema: -; Owner: crowd
--

GRANT USAGE ON SCHEMA datadog TO datadog;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: crowd
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO crowd;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT USAGE ON SCHEMA public TO datadog;


--
-- Name: TABLE activities; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.activities TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.activities TO cube;


--
-- Name: TABLE activitytasks; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.activitytasks TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.activitytasks TO cube;


--
-- Name: TABLE auditlogs; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.auditlogs TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.auditlogs TO cube;


--
-- Name: TABLE automationexecutions; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.automationexecutions TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.automationexecutions TO cube;


--
-- Name: TABLE automations; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.automations TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.automations TO cube;


--
-- Name: TABLE awsdms_ddl_audit; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.awsdms_ddl_audit TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.awsdms_ddl_audit TO cube;


--
-- Name: TABLE conversations; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.conversations TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.conversations TO cube;


--
-- Name: TABLE conversationsettings; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.conversationsettings TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.conversationsettings TO cube;


--
-- Name: TABLE dt_now; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.dt_now TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.dt_now TO cube;


--
-- Name: TABLE curr_time_ranges; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.curr_time_ranges TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.curr_time_ranges TO cube;


--
-- Name: TABLE eagleeyeactions; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.eagleeyeactions TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.eagleeyeactions TO cube;


--
-- Name: TABLE eagleeyecontents; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.eagleeyecontents TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.eagleeyecontents TO cube;


--
-- Name: TABLE files; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.files TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.files TO cube;


--
-- Name: TABLE fivetran_audit; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.fivetran_audit TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.fivetran_audit TO cube;


--
-- Name: TABLE flyway_schema_history; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.flyway_schema_history TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.flyway_schema_history TO cube;


--
-- Name: TABLE githubrepos; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.githubrepos TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.githubrepos TO cube;


--
-- Name: TABLE incomingwebhooks; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.incomingwebhooks TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.incomingwebhooks TO cube;


--
-- Name: TABLE integrationruns; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.integrationruns TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.integrationruns TO cube;


--
-- Name: TABLE integrations; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.integrations TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.integrations TO cube;


--
-- Name: TABLE integrationstreams; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.integrationstreams TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.integrationstreams TO cube;


--
-- Name: TABLE memberattributesettings; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.memberattributesettings TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.memberattributesettings TO cube;


--
-- Name: TABLE memberenrichmentcache; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.memberenrichmentcache TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.memberenrichmentcache TO cube;


--
-- Name: TABLE memberidentities; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.memberidentities TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.memberidentities TO cube;


--
-- Name: TABLE membernomerge; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membernomerge TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membernomerge TO cube;


--
-- Name: TABLE membernotes; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membernotes TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membernotes TO cube;


--
-- Name: TABLE memberorganizations; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.memberorganizations TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.memberorganizations TO cube;


--
-- Name: TABLE members; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.members TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.members TO cube;


--
-- Name: TABLE membersegmentaffiliations; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membersegmentaffiliations TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membersegmentaffiliations TO cube;


--
-- Name: TABLE membersegments; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membersegments TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membersegments TO cube;


--
-- Name: TABLE memberssyncremote; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.memberssyncremote TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.memberssyncremote TO cube;


--
-- Name: TABLE membertags; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membertags TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membertags TO cube;


--
-- Name: TABLE membertasks; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membertasks TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membertasks TO cube;


--
-- Name: TABLE membertomerge; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.membertomerge TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.membertomerge TO cube;


--
-- Name: TABLE microservices; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.microservices TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.microservices TO cube;


--
-- Name: TABLE mv_active_days; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_active_days TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_active_days TO cube;


--
-- Name: TABLE mv_time_ranges; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_time_ranges TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_time_ranges TO cube;


--
-- Name: TABLE mv_commits_bus_factor; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_commits_bus_factor TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_commits_bus_factor TO cube;


--
-- Name: TABLE organizations; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizations TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizations TO cube;


--
-- Name: TABLE segments; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.segments TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.segments TO cube;


--
-- Name: TABLE mv_contributors_first_contributions; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_contributors_first_contributions TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_contributors_first_contributions TO cube;


--
-- Name: TABLE mv_da_committers; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_da_committers TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_da_committers TO cube;


--
-- Name: TABLE mv_da_contributors; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_da_contributors TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_da_contributors TO cube;


--
-- Name: TABLE mv_da_issue_contributors; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_da_issue_contributors TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_da_issue_contributors TO cube;


--
-- Name: TABLE mv_da_pr_contributors; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_da_pr_contributors TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_da_pr_contributors TO cube;


--
-- Name: TABLE mv_member_contributions; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_member_contributions TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_member_contributions TO cube;


--
-- Name: TABLE mv_members; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_members TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_members TO cube;


--
-- Name: TABLE mv_new_activities; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_new_activities TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_new_activities TO cube;


--
-- Name: TABLE type_map; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.type_map TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.type_map TO cube;


--
-- Name: TABLE mv_org_bus_factor; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_org_bus_factor TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_org_bus_factor TO cube;


--
-- Name: TABLE mv_org_commits_bus_factor; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_org_commits_bus_factor TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_org_commits_bus_factor TO cube;


--
-- Name: TABLE mv_pr_engagement_gap; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_pr_engagement_gap TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_pr_engagement_gap TO cube;


--
-- Name: TABLE mv_segment_card; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_segment_card TO cube;


--
-- Name: TABLE mv_segment_yearly_stats; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_segment_yearly_stats TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_segment_yearly_stats TO cube;


--
-- Name: TABLE mv_segments; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_segments TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_segments TO cube;


--
-- Name: TABLE mv_subprojects; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_subprojects TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_subprojects TO cube;


--
-- Name: TABLE mv_subprojects_repositories; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_subprojects_repositories TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_subprojects_repositories TO cube;


--
-- Name: TABLE mv_type_bus_factor; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.mv_type_bus_factor TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.mv_type_bus_factor TO cube;


--
-- Name: TABLE notes; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.notes TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.notes TO cube;


--
-- Name: TABLE organizationcaches; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizationcaches TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizationcaches TO cube;


--
-- Name: TABLE organizationidentities; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizationidentities TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizationidentities TO cube;


--
-- Name: TABLE organizationnomerge; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizationnomerge TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizationnomerge TO cube;


--
-- Name: TABLE organizationsegments; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizationsegments TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizationsegments TO cube;


--
-- Name: TABLE organizationssyncremote; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizationssyncremote TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizationssyncremote TO cube;


--
-- Name: TABLE organizationtomerge; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.organizationtomerge TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.organizationtomerge TO cube;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: crowd_public; Owner: rdsadmin
--

GRANT SELECT ON TABLE crowd_public.pg_stat_statements TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.pg_stat_statements TO cube;


--
-- Name: TABLE recurringemailshistory; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.recurringemailshistory TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.recurringemailshistory TO cube;


--
-- Name: TABLE reports; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.reports TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.reports TO cube;


--
-- Name: TABLE segmentactivitychannels; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.segmentactivitychannels TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.segmentactivitychannels TO cube;


--
-- Name: TABLE settings; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.settings TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.settings TO cube;


--
-- Name: TABLE tags; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.tags TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.tags TO cube;


--
-- Name: TABLE taskassignees; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.taskassignees TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.taskassignees TO cube;


--
-- Name: TABLE tasks; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.tasks TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.tasks TO cube;


--
-- Name: TABLE tenants; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.tenants TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.tenants TO cube;


--
-- Name: TABLE tenantusers; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.tenantusers TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.tenantusers TO cube;


--
-- Name: TABLE users; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.users TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.users TO cube;


--
-- Name: TABLE widgets; Type: ACL; Schema: crowd_public; Owner: crowd
--

GRANT SELECT ON TABLE crowd_public.widgets TO crowd_ro;
GRANT SELECT ON TABLE crowd_public.widgets TO cube;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: crowd_public; Owner: crowd
--

ALTER DEFAULT PRIVILEGES FOR ROLE crowd IN SCHEMA crowd_public REVOKE ALL ON TABLES  FROM crowd;
ALTER DEFAULT PRIVILEGES FOR ROLE crowd IN SCHEMA crowd_public GRANT SELECT ON TABLES  TO crowd_ro;
ALTER DEFAULT PRIVILEGES FOR ROLE crowd IN SCHEMA crowd_public GRANT SELECT ON TABLES  TO cube;

set search_path to 'crowd_public';

--
-- PostgreSQL database dump complete
--

