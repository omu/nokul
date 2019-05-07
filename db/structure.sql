SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: academic_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.academic_terms (
    id bigint NOT NULL,
    year character varying,
    term integer,
    start_of_term timestamp without time zone,
    end_of_term timestamp without time zone,
    active boolean DEFAULT false,
    CONSTRAINT academic_terms_active_null CHECK ((active IS NOT NULL)),
    CONSTRAINT academic_terms_term_null CHECK ((term IS NOT NULL)),
    CONSTRAINT academic_terms_term_numericality CHECK ((term >= 0)),
    CONSTRAINT academic_terms_year_length CHECK ((length((year)::text) <= 255)),
    CONSTRAINT academic_terms_year_presence CHECK (((year IS NOT NULL) AND ((year)::text !~ '^\s*$'::text)))
);


--
-- Name: academic_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.academic_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: academic_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.academic_terms_id_seq OWNED BY public.academic_terms.id;


--
-- Name: action_text_rich_texts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_text_rich_texts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    body text,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_text_rich_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_text_rich_texts_id_seq OWNED BY public.action_text_rich_texts.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying,
    record_type character varying,
    record_id bigint,
    blob_id bigint,
    created_at timestamp without time zone,
    CONSTRAINT active_storage_attachments_created_at_null CHECK ((created_at IS NOT NULL)),
    CONSTRAINT active_storage_attachments_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying,
    filename character varying,
    content_type character varying,
    metadata character varying,
    byte_size bigint,
    checksum character varying,
    created_at timestamp without time zone,
    CONSTRAINT active_storage_blobs_byte_size_null CHECK ((byte_size IS NOT NULL)),
    CONSTRAINT active_storage_blobs_checksum_presence CHECK (((checksum IS NOT NULL) AND ((checksum)::text !~ '^\s*$'::text))),
    CONSTRAINT active_storage_blobs_created_at_null CHECK ((created_at IS NOT NULL)),
    CONSTRAINT active_storage_blobs_filename_presence CHECK (((filename IS NOT NULL) AND ((filename)::text !~ '^\s*$'::text))),
    CONSTRAINT active_storage_blobs_key_length CHECK ((length((key)::text) <= 255)),
    CONSTRAINT active_storage_blobs_key_presence CHECK (((key IS NOT NULL) AND ((key)::text !~ '^\s*$'::text)))
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    type integer,
    phone_number character varying,
    full_address character varying,
    district_id bigint NOT NULL,
    user_id bigint NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT addresses_created_at_null CHECK ((created_at IS NOT NULL)),
    CONSTRAINT addresses_full_address_length CHECK ((length((full_address)::text) <= 255)),
    CONSTRAINT addresses_full_address_presence CHECK (((full_address IS NOT NULL) AND ((full_address)::text !~ '^\s*$'::text))),
    CONSTRAINT addresses_phone_number_length CHECK ((length((phone_number)::text) <= 255)),
    CONSTRAINT addresses_type_null CHECK ((type IS NOT NULL)),
    CONSTRAINT addresses_type_numericality CHECK ((type >= 0)),
    CONSTRAINT addresses_updated_at_null CHECK ((updated_at IS NOT NULL))
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: administrative_functions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.administrative_functions (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT administrative_functions_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT administrative_functions_code_numericality CHECK ((code >= 0)),
    CONSTRAINT administrative_functions_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT administrative_functions_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: administrative_functions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.administrative_functions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: administrative_functions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.administrative_functions_id_seq OWNED BY public.administrative_functions.id;


--
-- Name: agenda_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agenda_types (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT agenda_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT agenda_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: agenda_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agenda_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agenda_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agenda_types_id_seq OWNED BY public.agenda_types.id;


--
-- Name: agendas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agendas (
    id bigint NOT NULL,
    description character varying,
    status integer DEFAULT 0,
    unit_id bigint NOT NULL,
    agenda_type_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT agendas_description_length CHECK ((length((description)::text) <= 65535)),
    CONSTRAINT agendas_description_presence CHECK (((description IS NOT NULL) AND ((description)::text !~ '^\s*$'::text))),
    CONSTRAINT agendas_status_null CHECK ((status IS NOT NULL)),
    CONSTRAINT agendas_status_numericality CHECK ((status >= 0))
);


--
-- Name: agendas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agendas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agendas_id_seq OWNED BY public.agendas.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: articles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.articles (
    id bigint NOT NULL,
    yoksis_id integer,
    scope integer,
    review integer,
    index integer,
    title character varying,
    authors character varying,
    number_of_authors integer,
    country integer,
    city character varying,
    journal character varying,
    language_of_publication character varying,
    month integer,
    year integer,
    volume character varying,
    issue character varying,
    first_page integer,
    last_page integer,
    doi character varying,
    issn character varying,
    access_type integer,
    access_link character varying,
    discipline character varying,
    keyword character varying,
    special_issue integer,
    special_issue_name character varying,
    sponsored_by character varying,
    author_id integer,
    last_update timestamp without time zone,
    status integer,
    type integer,
    incentive_point double precision DEFAULT 0.0,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT articles_access_link_length CHECK ((length((access_link)::text) <= 65535)),
    CONSTRAINT articles_access_type_numericality CHECK ((access_type >= 0)),
    CONSTRAINT articles_author_id_numericality CHECK ((author_id >= 0)),
    CONSTRAINT articles_authors_length CHECK ((length((authors)::text) <= 65535)),
    CONSTRAINT articles_authors_presence CHECK (((authors IS NOT NULL) AND ((authors)::text !~ '^\s*$'::text))),
    CONSTRAINT articles_city_length CHECK ((length((city)::text) <= 255)),
    CONSTRAINT articles_country_numericality CHECK ((country >= 0)),
    CONSTRAINT articles_discipline_length CHECK ((length((discipline)::text) <= 65535)),
    CONSTRAINT articles_doi_length CHECK ((length((doi)::text) <= 255)),
    CONSTRAINT articles_first_page_numericality CHECK (((first_page >= 0) AND (first_page < 15000))),
    CONSTRAINT articles_incentive_point_numericality CHECK ((incentive_point >= (0)::double precision)),
    CONSTRAINT articles_index_numericality CHECK ((index >= 0)),
    CONSTRAINT articles_issn_length CHECK ((length((issn)::text) <= 255)),
    CONSTRAINT articles_issue_length CHECK ((length((issue)::text) <= 255)),
    CONSTRAINT articles_journal_length CHECK ((length((journal)::text) <= 255)),
    CONSTRAINT articles_keyword_length CHECK ((length((keyword)::text) <= 255)),
    CONSTRAINT articles_language_of_publication_length CHECK ((length((language_of_publication)::text) <= 255)),
    CONSTRAINT articles_last_page_numericality CHECK (((last_page >= 0) AND (last_page < 15000))),
    CONSTRAINT articles_month_numericality CHECK (((month >= 1) AND (month <= 12))),
    CONSTRAINT articles_number_of_authors_numericality CHECK ((number_of_authors >= 0)),
    CONSTRAINT articles_review_numericality CHECK ((review >= 0)),
    CONSTRAINT articles_scope_numericality CHECK ((scope >= 0)),
    CONSTRAINT articles_special_issue_name_length CHECK ((length((special_issue_name)::text) <= 255)),
    CONSTRAINT articles_special_issue_numericality CHECK ((special_issue >= 0)),
    CONSTRAINT articles_sponsored_by_length CHECK ((length((sponsored_by)::text) <= 255)),
    CONSTRAINT articles_status_numericality CHECK ((status >= 0)),
    CONSTRAINT articles_title_length CHECK ((length((title)::text) <= 65535)),
    CONSTRAINT articles_title_presence CHECK (((title IS NOT NULL) AND ((title)::text !~ '^\s*$'::text))),
    CONSTRAINT articles_type_numericality CHECK ((type >= 0)),
    CONSTRAINT articles_volume_length CHECK ((length((volume)::text) <= 255)),
    CONSTRAINT articles_year_numericality CHECK (((year >= 1950) AND (year <= 2050))),
    CONSTRAINT articles_yoksis_id_null CHECK ((yoksis_id IS NOT NULL)),
    CONSTRAINT articles_yoksis_id_numericality CHECK ((yoksis_id >= 0))
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: assessment_methods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assessment_methods (
    id bigint NOT NULL,
    name character varying,
    CONSTRAINT assessment_methods_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT assessment_methods_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: assessment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assessment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assessment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assessment_methods_id_seq OWNED BY public.assessment_methods.id;


--
-- Name: available_course_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.available_course_groups (
    id bigint NOT NULL,
    name character varying,
    quota integer,
    available_course_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT available_course_groups_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT available_course_groups_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT available_course_groups_quota_numericality CHECK ((quota >= 0))
);


--
-- Name: available_course_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.available_course_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: available_course_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.available_course_groups_id_seq OWNED BY public.available_course_groups.id;


--
-- Name: available_course_lecturers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.available_course_lecturers (
    id bigint NOT NULL,
    coordinator boolean DEFAULT false,
    group_id bigint NOT NULL,
    lecturer_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT available_course_lecturers_coordinator_null CHECK ((coordinator IS NOT NULL))
);


--
-- Name: available_course_lecturers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.available_course_lecturers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: available_course_lecturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.available_course_lecturers_id_seq OWNED BY public.available_course_lecturers.id;


--
-- Name: available_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.available_courses (
    id bigint NOT NULL,
    academic_term_id bigint NOT NULL,
    curriculum_id bigint NOT NULL,
    course_id bigint NOT NULL,
    unit_id bigint NOT NULL,
    coordinator_id bigint,
    groups_count integer DEFAULT 0,
    assessments_approved boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT available_courses_assessments_approved_null CHECK ((assessments_approved IS NOT NULL)),
    CONSTRAINT available_courses_groups_count_numericality CHECK ((groups_count >= 0))
);


--
-- Name: available_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.available_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: available_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.available_courses_id_seq OWNED BY public.available_courses.id;


--
-- Name: calendar_committee_decisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.calendar_committee_decisions (
    id bigint NOT NULL,
    calendar_id bigint NOT NULL,
    committee_decision_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: calendar_committee_decisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.calendar_committee_decisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendar_committee_decisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.calendar_committee_decisions_id_seq OWNED BY public.calendar_committee_decisions.id;


--
-- Name: calendar_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.calendar_event_types (
    id bigint NOT NULL,
    name character varying,
    identifier character varying,
    category integer,
    CONSTRAINT calendar_event_types_category_null CHECK ((category IS NOT NULL)),
    CONSTRAINT calendar_event_types_category_numericality CHECK ((category >= 0)),
    CONSTRAINT calendar_event_types_identifier_length CHECK ((length((identifier)::text) <= 255)),
    CONSTRAINT calendar_event_types_identifier_presence CHECK (((identifier IS NOT NULL) AND ((identifier)::text !~ '^\s*$'::text))),
    CONSTRAINT calendar_event_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT calendar_event_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: calendar_event_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.calendar_event_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendar_event_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.calendar_event_types_id_seq OWNED BY public.calendar_event_types.id;


--
-- Name: calendar_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.calendar_events (
    id bigint NOT NULL,
    calendar_id bigint NOT NULL,
    calendar_event_type_id bigint NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    location character varying,
    timezone character varying DEFAULT 'Istanbul'::character varying,
    visible boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT calendar_events_location_length CHECK ((length((location)::text) <= 255)),
    CONSTRAINT calendar_events_start_time_null CHECK ((start_time IS NOT NULL)),
    CONSTRAINT calendar_events_timezone_length CHECK ((length((timezone)::text) <= 255)),
    CONSTRAINT calendar_events_timezone_presence CHECK (((timezone IS NOT NULL) AND ((timezone)::text !~ '^\s*$'::text))),
    CONSTRAINT calendar_events_visible_null CHECK ((visible IS NOT NULL))
);


--
-- Name: calendar_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.calendar_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendar_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.calendar_events_id_seq OWNED BY public.calendar_events.id;


--
-- Name: calendars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.calendars (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    timezone character varying DEFAULT 'Istanbul'::character varying,
    academic_term_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT calendars_description_length CHECK ((length((description)::text) <= 65535)),
    CONSTRAINT calendars_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT calendars_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT calendars_timezone_length CHECK ((length((timezone)::text) <= 255)),
    CONSTRAINT calendars_timezone_presence CHECK (((timezone IS NOT NULL) AND ((timezone)::text !~ '^\s*$'::text)))
);


--
-- Name: calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.calendars_id_seq OWNED BY public.calendars.id;


--
-- Name: certifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.certifications (
    id bigint NOT NULL,
    yoksis_id integer,
    type integer,
    name character varying,
    content character varying,
    location character varying,
    scope integer,
    duration character varying,
    start_date date,
    end_date date,
    title character varying,
    number_of_authors integer,
    city_and_country character varying,
    last_update timestamp without time zone,
    incentive_point double precision DEFAULT 0.0,
    status integer,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT certifications_city_and_country_length CHECK ((length((city_and_country)::text) <= 255)),
    CONSTRAINT certifications_content_length CHECK ((length((content)::text) <= 65535)),
    CONSTRAINT certifications_duration_length CHECK ((length((duration)::text) <= 255)),
    CONSTRAINT certifications_incentive_point_numericality CHECK ((incentive_point >= (0)::double precision)),
    CONSTRAINT certifications_location_length CHECK ((length((location)::text) <= 255)),
    CONSTRAINT certifications_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT certifications_number_of_authors_numericality CHECK ((number_of_authors >= 0)),
    CONSTRAINT certifications_scope_numericality CHECK ((scope >= 0)),
    CONSTRAINT certifications_status_numericality CHECK ((status >= 0)),
    CONSTRAINT certifications_title_length CHECK ((length((title)::text) <= 255)),
    CONSTRAINT certifications_title_null CHECK ((title IS NOT NULL)),
    CONSTRAINT certifications_type_null CHECK ((type IS NOT NULL)),
    CONSTRAINT certifications_type_numericality CHECK ((type >= 0)),
    CONSTRAINT certifications_yoksis_id_null CHECK ((yoksis_id IS NOT NULL)),
    CONSTRAINT certifications_yoksis_id_numericality CHECK ((yoksis_id >= 0))
);


--
-- Name: certifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.certifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: certifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.certifications_id_seq OWNED BY public.certifications.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying,
    alpha_2_code character varying,
    country_id bigint NOT NULL,
    latitude double precision DEFAULT 0.0,
    longitude double precision DEFAULT 0.0,
    CONSTRAINT cities_alpha_2_code_length CHECK ((length((alpha_2_code)::text) <= 255)),
    CONSTRAINT cities_alpha_2_code_presence CHECK (((alpha_2_code IS NOT NULL) AND ((alpha_2_code)::text !~ '^\s*$'::text))),
    CONSTRAINT cities_latitude_null CHECK ((latitude IS NOT NULL)),
    CONSTRAINT cities_longitude_null CHECK ((longitude IS NOT NULL)),
    CONSTRAINT cities_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT cities_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: committee_decisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.committee_decisions (
    id bigint NOT NULL,
    description character varying,
    decision_no character varying,
    year integer,
    meeting_agenda_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT committee_decisions_decision_no_length CHECK ((length((decision_no)::text) <= 255)),
    CONSTRAINT committee_decisions_decision_no_presence CHECK (((decision_no IS NOT NULL) AND ((decision_no)::text !~ '^\s*$'::text))),
    CONSTRAINT committee_decisions_description_length CHECK ((length((description)::text) <= 65535)),
    CONSTRAINT committee_decisions_description_presence CHECK (((description IS NOT NULL) AND ((description)::text !~ '^\s*$'::text))),
    CONSTRAINT committee_decisions_year_null CHECK ((year IS NOT NULL)),
    CONSTRAINT committee_decisions_year_numericality CHECK (((year >= 1960) AND (year <= 2050)))
);


--
-- Name: committee_decisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.committee_decisions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: committee_decisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.committee_decisions_id_seq OWNED BY public.committee_decisions.id;


--
-- Name: committee_meetings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.committee_meetings (
    id bigint NOT NULL,
    meeting_no integer,
    meeting_date date,
    year integer,
    unit_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT committee_meetings_meeting_date_null CHECK ((meeting_date IS NOT NULL)),
    CONSTRAINT committee_meetings_meeting_no_null CHECK ((meeting_no IS NOT NULL)),
    CONSTRAINT committee_meetings_meeting_no_numericality CHECK ((meeting_no >= 0)),
    CONSTRAINT committee_meetings_year_null CHECK ((year IS NOT NULL)),
    CONSTRAINT committee_meetings_year_numericality CHECK (((year >= 1950) AND (year <= 2050)))
);


--
-- Name: committee_meetings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.committee_meetings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: committee_meetings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.committee_meetings_id_seq OWNED BY public.committee_meetings.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    name character varying,
    alpha_2_code character varying,
    alpha_3_code character varying,
    numeric_code character varying,
    mernis_code character varying,
    yoksis_code integer,
    sms_delivery_report boolean DEFAULT false,
    sms_alpha_sender_id boolean DEFAULT false,
    sms_unicode boolean DEFAULT false,
    sms_concatenation boolean DEFAULT false,
    continent character varying,
    region character varying,
    subregion character varying,
    world_region character varying,
    phone_code character varying,
    latitude double precision DEFAULT 0.0,
    longitude double precision DEFAULT 0.0,
    currency_code character varying,
    start_of_week character varying,
    un_locode character varying,
    CONSTRAINT countries_alpha_2_code_length CHECK ((length((alpha_2_code)::text) = 2)),
    CONSTRAINT countries_alpha_2_code_presence CHECK (((alpha_2_code IS NOT NULL) AND ((alpha_2_code)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_alpha_3_code_length CHECK ((length((alpha_3_code)::text) = 3)),
    CONSTRAINT countries_alpha_3_code_presence CHECK (((alpha_3_code IS NOT NULL) AND ((alpha_3_code)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_continent_length CHECK ((length((continent)::text) <= 255)),
    CONSTRAINT countries_continent_presence CHECK (((continent IS NOT NULL) AND ((continent)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_currency_code_length CHECK ((length((currency_code)::text) = 3)),
    CONSTRAINT countries_currency_code_presence CHECK (((currency_code IS NOT NULL) AND ((currency_code)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_latitude_null CHECK ((latitude IS NOT NULL)),
    CONSTRAINT countries_longitude_null CHECK ((longitude IS NOT NULL)),
    CONSTRAINT countries_mernis_code_length CHECK ((length((mernis_code)::text) = 4)),
    CONSTRAINT countries_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT countries_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_numeric_code_length CHECK ((length((numeric_code)::text) = 3)),
    CONSTRAINT countries_numeric_code_presence CHECK (((numeric_code IS NOT NULL) AND ((numeric_code)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_phone_code_length CHECK ((length((phone_code)::text) <= 3)),
    CONSTRAINT countries_region_length CHECK ((length((region)::text) <= 255)),
    CONSTRAINT countries_sms_alpha_sender_id_null CHECK ((sms_alpha_sender_id IS NOT NULL)),
    CONSTRAINT countries_sms_concatenation_null CHECK ((sms_concatenation IS NOT NULL)),
    CONSTRAINT countries_sms_delivery_report_null CHECK ((sms_delivery_report IS NOT NULL)),
    CONSTRAINT countries_sms_unicode_null CHECK ((sms_unicode IS NOT NULL)),
    CONSTRAINT countries_start_of_week_length CHECK ((length((start_of_week)::text) <= 255)),
    CONSTRAINT countries_subregion_length CHECK ((length((subregion)::text) <= 255)),
    CONSTRAINT countries_un_locode_length CHECK ((length((un_locode)::text) = 2)),
    CONSTRAINT countries_world_region_length CHECK ((length((world_region)::text) <= 255)),
    CONSTRAINT countries_world_region_presence CHECK (((world_region IS NOT NULL) AND ((world_region)::text !~ '^\s*$'::text))),
    CONSTRAINT countries_yoksis_code_numericality CHECK ((yoksis_code >= 1))
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: course_assessment_methods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_assessment_methods (
    id bigint NOT NULL,
    course_evaluation_type_id bigint NOT NULL,
    assessment_method_id bigint NOT NULL,
    percentage integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT course_assessment_methods_percentage_null CHECK ((percentage IS NOT NULL)),
    CONSTRAINT course_assessment_methods_percentage_numericality CHECK (((percentage >= 0) AND (percentage <= 100)))
);


--
-- Name: course_assessment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_assessment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_assessment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_assessment_methods_id_seq OWNED BY public.course_assessment_methods.id;


--
-- Name: course_evaluation_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_evaluation_types (
    id bigint NOT NULL,
    available_course_id bigint NOT NULL,
    evaluation_type_id bigint NOT NULL,
    percentage integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT course_evaluation_types_percentage_null CHECK ((percentage IS NOT NULL)),
    CONSTRAINT course_evaluation_types_percentage_numericality CHECK (((percentage >= 0) AND (percentage <= 100)))
);


--
-- Name: course_evaluation_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_evaluation_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_evaluation_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_evaluation_types_id_seq OWNED BY public.course_evaluation_types.id;


--
-- Name: course_group_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_group_types (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT course_group_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT course_group_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: course_group_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_group_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_group_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_group_types_id_seq OWNED BY public.course_group_types.id;


--
-- Name: course_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_groups (
    id bigint NOT NULL,
    name character varying,
    total_ects_condition integer DEFAULT 0,
    unit_id bigint NOT NULL,
    course_group_type_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT course_groups_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT course_groups_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT course_groups_total_ects_condition_null CHECK ((total_ects_condition IS NOT NULL)),
    CONSTRAINT course_groups_total_ects_condition_numericality CHECK (((total_ects_condition >= 0) AND (total_ects_condition <= 300)))
);


--
-- Name: course_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_groups_id_seq OWNED BY public.course_groups.id;


--
-- Name: course_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_types (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    min_credit numeric(5,2) DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT course_types_code_length CHECK ((length((code)::text) <= 255)),
    CONSTRAINT course_types_code_presence CHECK (((code IS NOT NULL) AND ((code)::text !~ '^\s*$'::text))),
    CONSTRAINT course_types_min_credit_null CHECK ((min_credit IS NOT NULL)),
    CONSTRAINT course_types_min_credit_numericality CHECK ((min_credit >= (0)::numeric)),
    CONSTRAINT course_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT course_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: course_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_types_id_seq OWNED BY public.course_types.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    theoric integer DEFAULT 0,
    practice integer DEFAULT 0,
    laboratory integer DEFAULT 0,
    credit numeric(5,2) DEFAULT 0.0,
    program_type integer,
    status integer,
    unit_id bigint NOT NULL,
    language_id bigint NOT NULL,
    course_type_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT courses_code_length CHECK ((length((code)::text) <= 255)),
    CONSTRAINT courses_code_presence CHECK (((code IS NOT NULL) AND ((code)::text !~ '^\s*$'::text))),
    CONSTRAINT courses_credit_null CHECK ((credit IS NOT NULL)),
    CONSTRAINT courses_credit_numericality CHECK ((credit >= (0)::numeric)),
    CONSTRAINT courses_laboratory_null CHECK ((laboratory IS NOT NULL)),
    CONSTRAINT courses_laboratory_numericality CHECK ((laboratory >= 0)),
    CONSTRAINT courses_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT courses_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT courses_practice_null CHECK ((practice IS NOT NULL)),
    CONSTRAINT courses_practice_numericality CHECK ((practice >= 0)),
    CONSTRAINT courses_program_type_null CHECK ((program_type IS NOT NULL)),
    CONSTRAINT courses_program_type_numericality CHECK ((program_type >= 0)),
    CONSTRAINT courses_status_null CHECK ((status IS NOT NULL)),
    CONSTRAINT courses_status_numericality CHECK ((status >= 0)),
    CONSTRAINT courses_theoric_null CHECK ((theoric IS NOT NULL)),
    CONSTRAINT courses_theoric_numericality CHECK ((theoric >= 0))
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: curriculum_course_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_course_groups (
    id bigint NOT NULL,
    course_group_id bigint NOT NULL,
    curriculum_semester_id bigint NOT NULL,
    ects numeric(5,2) DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT curriculum_course_groups_ects_null CHECK ((ects IS NOT NULL)),
    CONSTRAINT curriculum_course_groups_ects_numericality CHECK ((ects >= (0)::numeric))
);


--
-- Name: curriculum_course_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.curriculum_course_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: curriculum_course_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curriculum_course_groups_id_seq OWNED BY public.curriculum_course_groups.id;


--
-- Name: curriculum_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_courses (
    id bigint NOT NULL,
    type integer,
    course_id bigint NOT NULL,
    curriculum_semester_id bigint NOT NULL,
    ects numeric(5,2) DEFAULT 0.0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    curriculum_course_group_id bigint,
    CONSTRAINT curriculum_courses_ects_null CHECK ((ects IS NOT NULL)),
    CONSTRAINT curriculum_courses_ects_numericality CHECK ((ects >= (0)::numeric)),
    CONSTRAINT curriculum_courses_type_null CHECK ((type IS NOT NULL)),
    CONSTRAINT curriculum_courses_type_numericality CHECK ((type >= 0))
);


--
-- Name: curriculum_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.curriculum_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: curriculum_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curriculum_courses_id_seq OWNED BY public.curriculum_courses.id;


--
-- Name: curriculum_programs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_programs (
    id bigint NOT NULL,
    unit_id bigint NOT NULL,
    curriculum_id bigint NOT NULL
);


--
-- Name: curriculum_programs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.curriculum_programs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: curriculum_programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curriculum_programs_id_seq OWNED BY public.curriculum_programs.id;


--
-- Name: curriculum_semesters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculum_semesters (
    id bigint NOT NULL,
    sequence integer,
    year integer,
    term integer,
    curriculum_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT curriculum_semesters_sequence_null CHECK ((sequence IS NOT NULL)),
    CONSTRAINT curriculum_semesters_sequence_numericality CHECK ((sequence > 0)),
    CONSTRAINT curriculum_semesters_term_null CHECK ((term IS NOT NULL)),
    CONSTRAINT curriculum_semesters_term_numericality CHECK ((term >= 0)),
    CONSTRAINT curriculum_semesters_year_null CHECK ((year IS NOT NULL)),
    CONSTRAINT curriculum_semesters_year_numericality CHECK ((year > 0))
);


--
-- Name: curriculum_semesters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.curriculum_semesters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: curriculum_semesters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curriculum_semesters_id_seq OWNED BY public.curriculum_semesters.id;


--
-- Name: curriculums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.curriculums (
    id bigint NOT NULL,
    name character varying,
    semesters_count integer DEFAULT 0,
    status integer,
    unit_id bigint NOT NULL,
    CONSTRAINT curriculums_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT curriculums_semesters_count_null CHECK ((semesters_count IS NOT NULL)),
    CONSTRAINT curriculums_semesters_count_numericality CHECK ((semesters_count >= 0)),
    CONSTRAINT curriculums_status_null CHECK ((status IS NOT NULL)),
    CONSTRAINT curriculums_status_numericality CHECK ((status >= 0))
);


--
-- Name: curriculums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.curriculums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: curriculums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.curriculums_id_seq OWNED BY public.curriculums.id;


--
-- Name: districts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.districts (
    id bigint NOT NULL,
    name character varying,
    mernis_code character varying,
    active boolean DEFAULT true,
    city_id bigint NOT NULL,
    CONSTRAINT districts_active_null CHECK ((active IS NOT NULL)),
    CONSTRAINT districts_mernis_code_length CHECK ((length((mernis_code)::text) = 4)),
    CONSTRAINT districts_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT districts_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: districts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.districts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: districts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.districts_id_seq OWNED BY public.districts.id;


--
-- Name: document_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_types (
    id bigint NOT NULL,
    name character varying,
    active boolean DEFAULT true,
    CONSTRAINT document_types_active_null CHECK ((active IS NOT NULL)),
    CONSTRAINT document_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT document_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: document_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_types_id_seq OWNED BY public.document_types.id;


--
-- Name: duties; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.duties (
    id bigint NOT NULL,
    temporary boolean DEFAULT true,
    start_date date,
    end_date date,
    employee_id bigint NOT NULL,
    unit_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT duties_start_date_null CHECK ((start_date IS NOT NULL)),
    CONSTRAINT duties_temporary_null CHECK ((temporary IS NOT NULL))
);


--
-- Name: duties_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.duties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: duties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.duties_id_seq OWNED BY public.duties.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    active boolean DEFAULT true,
    title_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    staff_number character varying,
    CONSTRAINT employees_active_null CHECK ((active IS NOT NULL)),
    CONSTRAINT employees_staff_number_length CHECK ((length((staff_number)::text) <= 255))
);


--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: evaluation_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluation_types (
    id bigint NOT NULL,
    name character varying,
    CONSTRAINT evaluation_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT evaluation_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: evaluation_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluation_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluation_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluation_types_id_seq OWNED BY public.evaluation_types.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.friendly_id_slugs (
    id bigint NOT NULL,
    slug character varying,
    sluggable_id integer,
    sluggable_type character varying,
    scope character varying,
    created_at timestamp without time zone,
    CONSTRAINT friendly_id_slugs_scope_length CHECK ((length((scope)::text) <= 255)),
    CONSTRAINT friendly_id_slugs_slug_length CHECK ((length((slug)::text) <= 255)),
    CONSTRAINT friendly_id_slugs_slug_presence CHECK (((slug IS NOT NULL) AND ((slug)::text !~ '^\s*$'::text))),
    CONSTRAINT friendly_id_slugs_sluggable_id_null CHECK ((sluggable_id IS NOT NULL)),
    CONSTRAINT friendly_id_slugs_sluggable_type_length CHECK ((length((sluggable_type)::text) <= 255))
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.friendly_id_slugs_id_seq OWNED BY public.friendly_id_slugs.id;


--
-- Name: group_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_courses (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    course_group_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.group_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.group_courses_id_seq OWNED BY public.group_courses.id;


--
-- Name: high_school_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.high_school_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT high_school_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT high_school_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT high_school_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT high_school_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: high_school_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.high_school_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: high_school_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.high_school_types_id_seq OWNED BY public.high_school_types.id;


--
-- Name: identities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identities (
    id bigint NOT NULL,
    type integer,
    first_name character varying,
    last_name character varying,
    mothers_name character varying,
    fathers_name character varying,
    gender integer,
    marital_status integer,
    place_of_birth character varying,
    date_of_birth date,
    registered_to character varying,
    user_id bigint NOT NULL,
    student_id bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT identities_created_at_null CHECK ((created_at IS NOT NULL)),
    CONSTRAINT identities_date_of_birth_null CHECK ((date_of_birth IS NOT NULL)),
    CONSTRAINT identities_fathers_name_length CHECK ((length((fathers_name)::text) <= 255)),
    CONSTRAINT identities_first_name_length CHECK ((length((first_name)::text) <= 255)),
    CONSTRAINT identities_first_name_presence CHECK (((first_name IS NOT NULL) AND ((first_name)::text !~ '^\s*$'::text))),
    CONSTRAINT identities_gender_null CHECK ((gender IS NOT NULL)),
    CONSTRAINT identities_gender_numericality CHECK ((gender >= 0)),
    CONSTRAINT identities_last_name_length CHECK ((length((last_name)::text) <= 255)),
    CONSTRAINT identities_last_name_presence CHECK (((last_name IS NOT NULL) AND ((last_name)::text !~ '^\s*$'::text))),
    CONSTRAINT identities_marital_status_numericality CHECK ((marital_status >= 0)),
    CONSTRAINT identities_mothers_name_length CHECK ((length((mothers_name)::text) <= 255)),
    CONSTRAINT identities_place_of_birth_length CHECK ((length((place_of_birth)::text) <= 255)),
    CONSTRAINT identities_place_of_birth_presence CHECK (((place_of_birth IS NOT NULL) AND ((place_of_birth)::text !~ '^\s*$'::text))),
    CONSTRAINT identities_registered_to_length CHECK ((length((registered_to)::text) <= 255)),
    CONSTRAINT identities_type_null CHECK ((type IS NOT NULL)),
    CONSTRAINT identities_type_numericality CHECK ((type >= 0)),
    CONSTRAINT identities_updated_at_null CHECK ((updated_at IS NOT NULL))
);


--
-- Name: identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.identities_id_seq OWNED BY public.identities.id;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    id bigint NOT NULL,
    name character varying,
    iso character varying,
    CONSTRAINT languages_iso_length CHECK ((length((iso)::text) <= 255)),
    CONSTRAINT languages_iso_presence CHECK (((iso IS NOT NULL) AND ((iso)::text !~ '^\s*$'::text))),
    CONSTRAINT languages_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT languages_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.languages_id_seq OWNED BY public.languages.id;


--
-- Name: meeting_agendas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meeting_agendas (
    id bigint NOT NULL,
    agenda_id bigint NOT NULL,
    committee_meeting_id bigint NOT NULL,
    sequence_no integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT meeting_agendas_sequence_no_null CHECK ((sequence_no IS NOT NULL)),
    CONSTRAINT meeting_agendas_sequence_no_numericality CHECK ((sequence_no >= 0))
);


--
-- Name: meeting_agendas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meeting_agendas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meeting_agendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meeting_agendas_id_seq OWNED BY public.meeting_agendas.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying,
    identifier character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT permissions_description_length CHECK ((length(description) <= 65535)),
    CONSTRAINT permissions_identifier_length CHECK ((length((identifier)::text) <= 255)),
    CONSTRAINT permissions_identifier_presence CHECK (((identifier IS NOT NULL) AND ((identifier)::text !~ '^\s*$'::text))),
    CONSTRAINT permissions_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT permissions_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: positions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.positions (
    id bigint NOT NULL,
    start_date date,
    end_date date,
    duty_id bigint NOT NULL,
    administrative_function_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT positions_start_date_null CHECK ((start_date IS NOT NULL))
);


--
-- Name: positions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: positions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.positions_id_seq OWNED BY public.positions.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    yoksis_id integer,
    name character varying,
    subject character varying,
    status integer,
    start_date date,
    end_date date,
    budget character varying,
    duty character varying,
    type character varying,
    currency character varying,
    last_update timestamp without time zone,
    activity integer,
    scope integer,
    title character varying,
    unit_id integer,
    incentive_point double precision DEFAULT 0.0,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT projects_activity_numericality CHECK ((activity >= 0)),
    CONSTRAINT projects_budget_length CHECK ((length((budget)::text) <= 255)),
    CONSTRAINT projects_currency_length CHECK ((length((currency)::text) <= 255)),
    CONSTRAINT projects_duty_length CHECK ((length((duty)::text) <= 255)),
    CONSTRAINT projects_incentive_point_numericality CHECK ((incentive_point >= (0)::double precision)),
    CONSTRAINT projects_name_length CHECK ((length((name)::text) <= 65535)),
    CONSTRAINT projects_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT projects_scope_numericality CHECK ((scope >= 0)),
    CONSTRAINT projects_status_numericality CHECK ((status >= 0)),
    CONSTRAINT projects_subject_length CHECK ((length((subject)::text) <= 65535)),
    CONSTRAINT projects_title_length CHECK ((length((title)::text) <= 255)),
    CONSTRAINT projects_type_length CHECK ((length((type)::text) <= 255)),
    CONSTRAINT projects_yoksis_id_null CHECK ((yoksis_id IS NOT NULL)),
    CONSTRAINT projects_yoksis_id_numericality CHECK ((yoksis_id >= 0))
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: prospective_employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prospective_employees (
    id bigint NOT NULL,
    id_number character varying,
    first_name character varying,
    last_name character varying,
    date_of_birth date,
    gender integer,
    email character varying,
    mobile_phone character varying,
    staff_number character varying,
    unit_id bigint,
    title_id bigint,
    archived boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT prospective_employees_archived_null CHECK ((archived IS NOT NULL)),
    CONSTRAINT prospective_employees_date_of_birth_null CHECK ((date_of_birth IS NOT NULL)),
    CONSTRAINT prospective_employees_email_length CHECK ((length((email)::text) <= 255)),
    CONSTRAINT prospective_employees_email_presence CHECK (((email IS NOT NULL) AND ((email)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_employees_first_name_length CHECK ((length((first_name)::text) <= 255)),
    CONSTRAINT prospective_employees_first_name_presence CHECK (((first_name IS NOT NULL) AND ((first_name)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_employees_gender_null CHECK ((gender IS NOT NULL)),
    CONSTRAINT prospective_employees_gender_numericality CHECK ((gender >= 0)),
    CONSTRAINT prospective_employees_id_number_length CHECK ((length((id_number)::text) = 11)),
    CONSTRAINT prospective_employees_id_number_presence CHECK (((id_number IS NOT NULL) AND ((id_number)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_employees_last_name_length CHECK ((length((last_name)::text) <= 255)),
    CONSTRAINT prospective_employees_last_name_presence CHECK (((last_name IS NOT NULL) AND ((last_name)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_employees_mobile_phone_length CHECK ((length((mobile_phone)::text) <= 255)),
    CONSTRAINT prospective_employees_staff_number_length CHECK ((length((staff_number)::text) <= 255)),
    CONSTRAINT prospective_employees_staff_number_presence CHECK (((staff_number IS NOT NULL) AND ((staff_number)::text !~ '^\s*$'::text)))
);


--
-- Name: prospective_employees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prospective_employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prospective_employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prospective_employees_id_seq OWNED BY public.prospective_employees.id;


--
-- Name: prospective_students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prospective_students (
    id bigint NOT NULL,
    id_number character varying,
    first_name character varying,
    last_name character varying,
    fathers_name character varying,
    mothers_name character varying,
    date_of_birth date,
    gender integer,
    nationality integer,
    place_of_birth character varying,
    registration_city character varying,
    registration_district character varying,
    high_school_code character varying,
    high_school_branch character varying,
    state_of_education integer,
    high_school_graduation_year integer,
    placement_type integer,
    exam_score double precision,
    address character varying,
    home_phone character varying,
    mobile_phone character varying,
    email character varying,
    top_student boolean DEFAULT false,
    placement_score double precision,
    placement_rank integer,
    preference_order integer,
    placement_score_type character varying,
    additional_score integer,
    meb_status boolean DEFAULT false,
    meb_status_date timestamp without time zone,
    military_status boolean DEFAULT false,
    military_status_date timestamp without time zone,
    obs_status boolean DEFAULT false,
    obs_status_date timestamp without time zone,
    obs_registered_program character varying,
    registered boolean DEFAULT false,
    high_school_type_id bigint,
    language_id bigint,
    student_disability_type_id bigint,
    unit_id bigint NOT NULL,
    student_entrance_type_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    academic_term_id bigint,
    expiry_date timestamp without time zone,
    system_register_type integer DEFAULT 0,
    archived boolean DEFAULT false,
    CONSTRAINT prospective_students_additional_score_numericality CHECK ((additional_score >= 0)),
    CONSTRAINT prospective_students_address_length CHECK ((length((address)::text) <= 255)),
    CONSTRAINT prospective_students_email_length CHECK ((length((email)::text) <= 255)),
    CONSTRAINT prospective_students_exam_score_numericality CHECK ((exam_score >= (0)::double precision)),
    CONSTRAINT prospective_students_fathers_name_length CHECK ((length((fathers_name)::text) <= 255)),
    CONSTRAINT prospective_students_first_name_length CHECK ((length((first_name)::text) <= 255)),
    CONSTRAINT prospective_students_first_name_presence CHECK (((first_name IS NOT NULL) AND ((first_name)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_students_gender_null CHECK ((gender IS NOT NULL)),
    CONSTRAINT prospective_students_gender_numericality CHECK ((gender >= 0)),
    CONSTRAINT prospective_students_high_school_branch_length CHECK ((length((high_school_branch)::text) <= 255)),
    CONSTRAINT prospective_students_high_school_code_length CHECK ((length((high_school_code)::text) <= 255)),
    CONSTRAINT prospective_students_high_school_graduation_year_numericality CHECK (((high_school_graduation_year >= 1910) AND (high_school_graduation_year <= 2050))),
    CONSTRAINT prospective_students_home_phone_length CHECK ((length((home_phone)::text) <= 255)),
    CONSTRAINT prospective_students_id_number_length CHECK ((length((id_number)::text) = 11)),
    CONSTRAINT prospective_students_id_number_presence CHECK (((id_number IS NOT NULL) AND ((id_number)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_students_last_name_length CHECK ((length((last_name)::text) <= 255)),
    CONSTRAINT prospective_students_last_name_presence CHECK (((last_name IS NOT NULL) AND ((last_name)::text !~ '^\s*$'::text))),
    CONSTRAINT prospective_students_meb_status_null CHECK ((meb_status IS NOT NULL)),
    CONSTRAINT prospective_students_military_status_null CHECK ((military_status IS NOT NULL)),
    CONSTRAINT prospective_students_mobile_phone_length CHECK ((length((mobile_phone)::text) <= 255)),
    CONSTRAINT prospective_students_mothers_name_length CHECK ((length((mothers_name)::text) <= 255)),
    CONSTRAINT prospective_students_nationality_numericality CHECK ((nationality >= 0)),
    CONSTRAINT prospective_students_obs_registered_program_length CHECK ((length((obs_registered_program)::text) <= 255)),
    CONSTRAINT prospective_students_obs_status_null CHECK ((obs_status IS NOT NULL)),
    CONSTRAINT prospective_students_place_of_birth_length CHECK ((length((place_of_birth)::text) <= 255)),
    CONSTRAINT prospective_students_placement_rank_numericality CHECK ((placement_rank >= 0)),
    CONSTRAINT prospective_students_placement_score_numericality CHECK ((placement_score >= (0)::double precision)),
    CONSTRAINT prospective_students_placement_score_type_length CHECK ((length((placement_score_type)::text) <= 255)),
    CONSTRAINT prospective_students_placement_type_numericality CHECK ((placement_type >= 0)),
    CONSTRAINT prospective_students_preference_order_numericality CHECK ((preference_order >= 0)),
    CONSTRAINT prospective_students_registered_null CHECK ((registered IS NOT NULL)),
    CONSTRAINT prospective_students_registration_city_length CHECK ((length((registration_city)::text) <= 255)),
    CONSTRAINT prospective_students_registration_district_length CHECK ((length((registration_district)::text) <= 255)),
    CONSTRAINT prospective_students_state_of_education_numericality CHECK ((state_of_education >= 0)),
    CONSTRAINT prospective_students_system_register_type_numericality CHECK ((system_register_type >= 0)),
    CONSTRAINT prospective_students_top_student_null CHECK ((top_student IS NOT NULL))
);


--
-- Name: prospective_students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prospective_students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prospective_students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prospective_students_id_seq OWNED BY public.prospective_students.id;


--
-- Name: query_stores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.query_stores (
    id bigint NOT NULL,
    name character varying,
    scope_name character varying,
    parameters jsonb,
    type integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT query_stores_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT query_stores_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT query_stores_scope_name_length CHECK ((length((scope_name)::text) <= 255)),
    CONSTRAINT query_stores_scope_name_presence CHECK (((scope_name IS NOT NULL) AND ((scope_name)::text !~ '^\s*$'::text))),
    CONSTRAINT query_stores_type_numericality CHECK ((type >= 0))
);


--
-- Name: query_stores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.query_stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: query_stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.query_stores_id_seq OWNED BY public.query_stores.id;


--
-- Name: registration_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registration_documents (
    id bigint NOT NULL,
    unit_id bigint NOT NULL,
    document_type_id bigint NOT NULL,
    academic_term_id bigint NOT NULL,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT registration_documents_description_length CHECK ((length((description)::text) <= 65535))
);


--
-- Name: registration_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registration_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registration_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registration_documents_id_seq OWNED BY public.registration_documents.id;


--
-- Name: role_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_assignments (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: role_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_assignments_id_seq OWNED BY public.role_assignments.id;


--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_permissions (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    identifier character varying,
    locked boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT roles_identifier_length CHECK ((length((identifier)::text) <= 255)),
    CONSTRAINT roles_identifier_presence CHECK (((identifier IS NOT NULL) AND ((identifier)::text !~ '^\s*$'::text))),
    CONSTRAINT roles_locked_null CHECK ((locked IS NOT NULL)),
    CONSTRAINT roles_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT roles_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: scope_assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_assignments (
    id bigint NOT NULL,
    query_store_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: scope_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scope_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scope_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scope_assignments_id_seq OWNED BY public.scope_assignments.id;


--
-- Name: student_disability_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_disability_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_disability_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_disability_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_disability_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_disability_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_disability_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_disability_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_disability_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_disability_types_id_seq OWNED BY public.student_disability_types.id;


--
-- Name: student_drop_out_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_drop_out_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_drop_out_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_drop_out_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_drop_out_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_drop_out_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_drop_out_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_drop_out_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_drop_out_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_drop_out_types_id_seq OWNED BY public.student_drop_out_types.id;


--
-- Name: student_education_levels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_education_levels (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_education_levels_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_education_levels_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_education_levels_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_education_levels_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_education_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_education_levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_education_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_education_levels_id_seq OWNED BY public.student_education_levels.id;


--
-- Name: student_entrance_point_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_entrance_point_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_entrance_point_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_entrance_point_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_entrance_point_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_entrance_point_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_entrance_point_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_entrance_point_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_entrance_point_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_entrance_point_types_id_seq OWNED BY public.student_entrance_point_types.id;


--
-- Name: student_entrance_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_entrance_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_entrance_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_entrance_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_entrance_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_entrance_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_entrance_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_entrance_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_entrance_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_entrance_types_id_seq OWNED BY public.student_entrance_types.id;


--
-- Name: student_grades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_grades (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_grades_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_grades_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_grades_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_grades_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_grades_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_grades_id_seq OWNED BY public.student_grades.id;


--
-- Name: student_grading_systems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_grading_systems (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_grading_systems_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_grading_systems_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_grading_systems_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_grading_systems_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_grading_systems_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_grading_systems_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_grading_systems_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_grading_systems_id_seq OWNED BY public.student_grading_systems.id;


--
-- Name: student_punishment_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_punishment_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_punishment_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_punishment_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_punishment_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_punishment_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_punishment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_punishment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_punishment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_punishment_types_id_seq OWNED BY public.student_punishment_types.id;


--
-- Name: student_studentship_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.student_studentship_statuses (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT student_studentship_statuses_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT student_studentship_statuses_code_numericality CHECK ((code >= 0)),
    CONSTRAINT student_studentship_statuses_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT student_studentship_statuses_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: student_studentship_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.student_studentship_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: student_studentship_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.student_studentship_statuses_id_seq OWNED BY public.student_studentship_statuses.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id bigint NOT NULL,
    student_number character varying,
    permanently_registered boolean DEFAULT false,
    user_id bigint NOT NULL,
    unit_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT students_permanently_registered_null CHECK ((permanently_registered IS NOT NULL)),
    CONSTRAINT students_student_number_length CHECK ((length((student_number)::text) <= 255)),
    CONSTRAINT students_student_number_presence CHECK (((student_number IS NOT NULL) AND ((student_number)::text !~ '^\s*$'::text)))
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: titles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.titles (
    id bigint NOT NULL,
    name character varying,
    code character varying,
    branch character varying,
    CONSTRAINT titles_branch_length CHECK ((length((branch)::text) <= 255)),
    CONSTRAINT titles_branch_presence CHECK (((branch IS NOT NULL) AND ((branch)::text !~ '^\s*$'::text))),
    CONSTRAINT titles_code_length CHECK ((length((code)::text) <= 255)),
    CONSTRAINT titles_code_presence CHECK (((code IS NOT NULL) AND ((code)::text !~ '^\s*$'::text))),
    CONSTRAINT titles_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT titles_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: titles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.titles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: titles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.titles_id_seq OWNED BY public.titles.id;


--
-- Name: unit_calendars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_calendars (
    id bigint NOT NULL,
    calendar_id bigint NOT NULL,
    unit_id bigint NOT NULL
);


--
-- Name: unit_calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_calendars_id_seq OWNED BY public.unit_calendars.id;


--
-- Name: unit_instruction_languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_instruction_languages (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT unit_instruction_languages_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT unit_instruction_languages_code_numericality CHECK ((code >= 0)),
    CONSTRAINT unit_instruction_languages_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT unit_instruction_languages_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: unit_instruction_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_instruction_languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_instruction_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_instruction_languages_id_seq OWNED BY public.unit_instruction_languages.id;


--
-- Name: unit_instruction_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_instruction_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT unit_instruction_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT unit_instruction_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT unit_instruction_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT unit_instruction_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: unit_instruction_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_instruction_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_instruction_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_instruction_types_id_seq OWNED BY public.unit_instruction_types.id;


--
-- Name: unit_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_statuses (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT unit_statuses_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT unit_statuses_code_numericality CHECK ((code >= 0)),
    CONSTRAINT unit_statuses_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT unit_statuses_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: unit_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_statuses_id_seq OWNED BY public.unit_statuses.id;


--
-- Name: unit_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    "group" integer,
    CONSTRAINT unit_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT unit_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT unit_types_group_numericality CHECK (("group" >= 0)),
    CONSTRAINT unit_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT unit_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: unit_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_types_id_seq OWNED BY public.unit_types.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.units (
    id bigint NOT NULL,
    name character varying,
    abbreviation character varying,
    code character varying,
    yoksis_id integer,
    detsis_id integer,
    osym_id integer,
    foet_code integer,
    founded_at date,
    duration integer,
    ancestry character varying,
    names_depth_cache character varying,
    district_id bigint NOT NULL,
    unit_status_id bigint NOT NULL,
    unit_instruction_language_id bigint,
    unit_instruction_type_id bigint,
    university_type_id bigint,
    unit_type_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT units_abbreviation_length CHECK ((length((abbreviation)::text) <= 255)),
    CONSTRAINT units_code_length CHECK ((length((code)::text) <= 255)),
    CONSTRAINT units_detsis_id_numericality CHECK ((detsis_id >= 1)),
    CONSTRAINT units_duration_numericality CHECK (((duration >= 1) AND (duration <= 8))),
    CONSTRAINT units_foet_code_numericality CHECK ((foet_code >= 1)),
    CONSTRAINT units_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT units_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text))),
    CONSTRAINT units_names_depth_cache_length CHECK ((length((names_depth_cache)::text) <= 255)),
    CONSTRAINT units_osym_id_numericality CHECK ((osym_id >= 1)),
    CONSTRAINT units_yoksis_id_numericality CHECK ((yoksis_id >= 1))
);


--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: university_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.university_types (
    id bigint NOT NULL,
    name character varying,
    code integer,
    CONSTRAINT university_types_code_null CHECK ((code IS NOT NULL)),
    CONSTRAINT university_types_code_numericality CHECK ((code >= 0)),
    CONSTRAINT university_types_name_length CHECK ((length((name)::text) <= 255)),
    CONSTRAINT university_types_name_presence CHECK (((name IS NOT NULL) AND ((name)::text !~ '^\s*$'::text)))
);


--
-- Name: university_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.university_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: university_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.university_types_id_seq OWNED BY public.university_types.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    id_number character varying,
    email character varying,
    encrypted_password character varying DEFAULT ''::character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    password_changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    failed_attempts integer DEFAULT 0,
    unlock_token character varying,
    locked_at timestamp without time zone,
    slug character varying,
    preferred_language character varying DEFAULT 'tr'::character varying,
    articles_count integer DEFAULT 0,
    projects_count integer DEFAULT 0,
    profile_preferences jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    activated boolean DEFAULT false,
    activated_at timestamp without time zone,
    CONSTRAINT users_activated_null CHECK ((activated IS NOT NULL)),
    CONSTRAINT users_articles_count_null CHECK ((articles_count IS NOT NULL)),
    CONSTRAINT users_articles_count_numericality CHECK ((articles_count >= 0)),
    CONSTRAINT users_created_at_null CHECK ((created_at IS NOT NULL)),
    CONSTRAINT users_email_length CHECK ((length((email)::text) <= 255)),
    CONSTRAINT users_email_presence CHECK (((email IS NOT NULL) AND ((email)::text !~ '^\s*$'::text))),
    CONSTRAINT users_encrypted_password_length CHECK ((length((encrypted_password)::text) <= 255)),
    CONSTRAINT users_encrypted_password_null CHECK ((encrypted_password IS NOT NULL)),
    CONSTRAINT users_failed_attempts_null CHECK ((failed_attempts IS NOT NULL)),
    CONSTRAINT users_failed_attempts_numericality CHECK ((failed_attempts >= 0)),
    CONSTRAINT users_id_number_length CHECK ((length((id_number)::text) = 11)),
    CONSTRAINT users_id_number_presence CHECK (((id_number IS NOT NULL) AND ((id_number)::text !~ '^\s*$'::text))),
    CONSTRAINT users_password_changed_at_null CHECK ((password_changed_at IS NOT NULL)),
    CONSTRAINT users_preferred_language_length CHECK ((length((preferred_language)::text) = 2)),
    CONSTRAINT users_projects_count_null CHECK ((projects_count IS NOT NULL)),
    CONSTRAINT users_projects_count_numericality CHECK ((projects_count >= 0)),
    CONSTRAINT users_reset_password_token_length CHECK ((length((reset_password_token)::text) <= 255)),
    CONSTRAINT users_sign_in_count_null CHECK ((sign_in_count IS NOT NULL)),
    CONSTRAINT users_sign_in_count_numericality CHECK ((sign_in_count >= 0)),
    CONSTRAINT users_slug_length CHECK ((length((slug)::text) <= 255)),
    CONSTRAINT users_updated_at_null CHECK ((updated_at IS NOT NULL))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: academic_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.academic_terms ALTER COLUMN id SET DEFAULT nextval('public.academic_terms_id_seq'::regclass);


--
-- Name: action_text_rich_texts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts ALTER COLUMN id SET DEFAULT nextval('public.action_text_rich_texts_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: administrative_functions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrative_functions ALTER COLUMN id SET DEFAULT nextval('public.administrative_functions_id_seq'::regclass);


--
-- Name: agenda_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_types ALTER COLUMN id SET DEFAULT nextval('public.agenda_types_id_seq'::regclass);


--
-- Name: agendas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas ALTER COLUMN id SET DEFAULT nextval('public.agendas_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: assessment_methods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_methods ALTER COLUMN id SET DEFAULT nextval('public.assessment_methods_id_seq'::regclass);


--
-- Name: available_course_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_groups ALTER COLUMN id SET DEFAULT nextval('public.available_course_groups_id_seq'::regclass);


--
-- Name: available_course_lecturers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_lecturers ALTER COLUMN id SET DEFAULT nextval('public.available_course_lecturers_id_seq'::regclass);


--
-- Name: available_courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses ALTER COLUMN id SET DEFAULT nextval('public.available_courses_id_seq'::regclass);


--
-- Name: calendar_committee_decisions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_committee_decisions ALTER COLUMN id SET DEFAULT nextval('public.calendar_committee_decisions_id_seq'::regclass);


--
-- Name: calendar_event_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_event_types ALTER COLUMN id SET DEFAULT nextval('public.calendar_event_types_id_seq'::regclass);


--
-- Name: calendar_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_events ALTER COLUMN id SET DEFAULT nextval('public.calendar_events_id_seq'::regclass);


--
-- Name: calendars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendars ALTER COLUMN id SET DEFAULT nextval('public.calendars_id_seq'::regclass);


--
-- Name: certifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certifications ALTER COLUMN id SET DEFAULT nextval('public.certifications_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: committee_decisions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.committee_decisions ALTER COLUMN id SET DEFAULT nextval('public.committee_decisions_id_seq'::regclass);


--
-- Name: committee_meetings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.committee_meetings ALTER COLUMN id SET DEFAULT nextval('public.committee_meetings_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: course_assessment_methods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_assessment_methods ALTER COLUMN id SET DEFAULT nextval('public.course_assessment_methods_id_seq'::regclass);


--
-- Name: course_evaluation_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_evaluation_types ALTER COLUMN id SET DEFAULT nextval('public.course_evaluation_types_id_seq'::regclass);


--
-- Name: course_group_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_group_types ALTER COLUMN id SET DEFAULT nextval('public.course_group_types_id_seq'::regclass);


--
-- Name: course_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_groups ALTER COLUMN id SET DEFAULT nextval('public.course_groups_id_seq'::regclass);


--
-- Name: course_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_types ALTER COLUMN id SET DEFAULT nextval('public.course_types_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: curriculum_course_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_course_groups ALTER COLUMN id SET DEFAULT nextval('public.curriculum_course_groups_id_seq'::regclass);


--
-- Name: curriculum_courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_courses ALTER COLUMN id SET DEFAULT nextval('public.curriculum_courses_id_seq'::regclass);


--
-- Name: curriculum_programs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_programs ALTER COLUMN id SET DEFAULT nextval('public.curriculum_programs_id_seq'::regclass);


--
-- Name: curriculum_semesters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_semesters ALTER COLUMN id SET DEFAULT nextval('public.curriculum_semesters_id_seq'::regclass);


--
-- Name: curriculums id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculums ALTER COLUMN id SET DEFAULT nextval('public.curriculums_id_seq'::regclass);


--
-- Name: districts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts ALTER COLUMN id SET DEFAULT nextval('public.districts_id_seq'::regclass);


--
-- Name: document_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_types ALTER COLUMN id SET DEFAULT nextval('public.document_types_id_seq'::regclass);


--
-- Name: duties id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.duties ALTER COLUMN id SET DEFAULT nextval('public.duties_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: evaluation_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_types ALTER COLUMN id SET DEFAULT nextval('public.evaluation_types_id_seq'::regclass);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);


--
-- Name: group_courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_courses ALTER COLUMN id SET DEFAULT nextval('public.group_courses_id_seq'::regclass);


--
-- Name: high_school_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.high_school_types ALTER COLUMN id SET DEFAULT nextval('public.high_school_types_id_seq'::regclass);


--
-- Name: identities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identities ALTER COLUMN id SET DEFAULT nextval('public.identities_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages ALTER COLUMN id SET DEFAULT nextval('public.languages_id_seq'::regclass);


--
-- Name: meeting_agendas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agendas ALTER COLUMN id SET DEFAULT nextval('public.meeting_agendas_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: positions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions ALTER COLUMN id SET DEFAULT nextval('public.positions_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: prospective_employees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_employees ALTER COLUMN id SET DEFAULT nextval('public.prospective_employees_id_seq'::regclass);


--
-- Name: prospective_students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students ALTER COLUMN id SET DEFAULT nextval('public.prospective_students_id_seq'::regclass);


--
-- Name: query_stores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.query_stores ALTER COLUMN id SET DEFAULT nextval('public.query_stores_id_seq'::regclass);


--
-- Name: registration_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_documents ALTER COLUMN id SET DEFAULT nextval('public.registration_documents_id_seq'::regclass);


--
-- Name: role_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_assignments ALTER COLUMN id SET DEFAULT nextval('public.role_assignments_id_seq'::regclass);


--
-- Name: role_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: scope_assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_assignments ALTER COLUMN id SET DEFAULT nextval('public.scope_assignments_id_seq'::regclass);


--
-- Name: student_disability_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_disability_types ALTER COLUMN id SET DEFAULT nextval('public.student_disability_types_id_seq'::regclass);


--
-- Name: student_drop_out_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_drop_out_types ALTER COLUMN id SET DEFAULT nextval('public.student_drop_out_types_id_seq'::regclass);


--
-- Name: student_education_levels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_education_levels ALTER COLUMN id SET DEFAULT nextval('public.student_education_levels_id_seq'::regclass);


--
-- Name: student_entrance_point_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_point_types ALTER COLUMN id SET DEFAULT nextval('public.student_entrance_point_types_id_seq'::regclass);


--
-- Name: student_entrance_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_types ALTER COLUMN id SET DEFAULT nextval('public.student_entrance_types_id_seq'::regclass);


--
-- Name: student_grades id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grades ALTER COLUMN id SET DEFAULT nextval('public.student_grades_id_seq'::regclass);


--
-- Name: student_grading_systems id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grading_systems ALTER COLUMN id SET DEFAULT nextval('public.student_grading_systems_id_seq'::regclass);


--
-- Name: student_punishment_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_punishment_types ALTER COLUMN id SET DEFAULT nextval('public.student_punishment_types_id_seq'::regclass);


--
-- Name: student_studentship_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_studentship_statuses ALTER COLUMN id SET DEFAULT nextval('public.student_studentship_statuses_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: titles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.titles ALTER COLUMN id SET DEFAULT nextval('public.titles_id_seq'::regclass);


--
-- Name: unit_calendars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_calendars ALTER COLUMN id SET DEFAULT nextval('public.unit_calendars_id_seq'::regclass);


--
-- Name: unit_instruction_languages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_languages ALTER COLUMN id SET DEFAULT nextval('public.unit_instruction_languages_id_seq'::regclass);


--
-- Name: unit_instruction_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_types ALTER COLUMN id SET DEFAULT nextval('public.unit_instruction_types_id_seq'::regclass);


--
-- Name: unit_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_statuses ALTER COLUMN id SET DEFAULT nextval('public.unit_statuses_id_seq'::regclass);


--
-- Name: unit_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_types ALTER COLUMN id SET DEFAULT nextval('public.unit_types_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Name: university_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.university_types ALTER COLUMN id SET DEFAULT nextval('public.university_types_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: academic_terms academic_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.academic_terms
    ADD CONSTRAINT academic_terms_pkey PRIMARY KEY (id);


--
-- Name: action_text_rich_texts action_text_rich_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_text_rich_texts
    ADD CONSTRAINT action_text_rich_texts_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: administrative_functions administrative_functions_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrative_functions
    ADD CONSTRAINT administrative_functions_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: administrative_functions administrative_functions_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrative_functions
    ADD CONSTRAINT administrative_functions_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: administrative_functions administrative_functions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.administrative_functions
    ADD CONSTRAINT administrative_functions_pkey PRIMARY KEY (id);


--
-- Name: agenda_types agenda_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_types
    ADD CONSTRAINT agenda_types_pkey PRIMARY KEY (id);


--
-- Name: agendas agendas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: assessment_methods assessment_methods_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_methods
    ADD CONSTRAINT assessment_methods_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: assessment_methods assessment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assessment_methods
    ADD CONSTRAINT assessment_methods_pkey PRIMARY KEY (id);


--
-- Name: available_course_groups available_course_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_groups
    ADD CONSTRAINT available_course_groups_pkey PRIMARY KEY (id);


--
-- Name: available_course_lecturers available_course_lecturers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_lecturers
    ADD CONSTRAINT available_course_lecturers_pkey PRIMARY KEY (id);


--
-- Name: available_courses available_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses
    ADD CONSTRAINT available_courses_pkey PRIMARY KEY (id);


--
-- Name: calendar_committee_decisions calendar_committee_decisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_committee_decisions
    ADD CONSTRAINT calendar_committee_decisions_pkey PRIMARY KEY (id);


--
-- Name: calendar_event_types calendar_event_types_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_event_types
    ADD CONSTRAINT calendar_event_types_identifier_unique UNIQUE (identifier) DEFERRABLE;


--
-- Name: calendar_event_types calendar_event_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_event_types
    ADD CONSTRAINT calendar_event_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: calendar_event_types calendar_event_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_event_types
    ADD CONSTRAINT calendar_event_types_pkey PRIMARY KEY (id);


--
-- Name: calendar_events calendar_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT calendar_events_pkey PRIMARY KEY (id);


--
-- Name: calendars calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendars
    ADD CONSTRAINT calendars_pkey PRIMARY KEY (id);


--
-- Name: certifications certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_pkey PRIMARY KEY (id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: committee_decisions committee_decisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.committee_decisions
    ADD CONSTRAINT committee_decisions_pkey PRIMARY KEY (id);


--
-- Name: committee_meetings committee_meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.committee_meetings
    ADD CONSTRAINT committee_meetings_pkey PRIMARY KEY (id);


--
-- Name: countries countries_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: course_assessment_methods course_assessment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_assessment_methods
    ADD CONSTRAINT course_assessment_methods_pkey PRIMARY KEY (id);


--
-- Name: course_evaluation_types course_evaluation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_evaluation_types
    ADD CONSTRAINT course_evaluation_types_pkey PRIMARY KEY (id);


--
-- Name: course_group_types course_group_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_group_types
    ADD CONSTRAINT course_group_types_pkey PRIMARY KEY (id);


--
-- Name: course_groups course_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_groups
    ADD CONSTRAINT course_groups_pkey PRIMARY KEY (id);


--
-- Name: course_types course_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_types
    ADD CONSTRAINT course_types_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: curriculum_course_groups curriculum_course_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_course_groups
    ADD CONSTRAINT curriculum_course_groups_pkey PRIMARY KEY (id);


--
-- Name: curriculum_courses curriculum_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_courses
    ADD CONSTRAINT curriculum_courses_pkey PRIMARY KEY (id);


--
-- Name: curriculum_programs curriculum_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_programs
    ADD CONSTRAINT curriculum_programs_pkey PRIMARY KEY (id);


--
-- Name: curriculum_semesters curriculum_semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_semesters
    ADD CONSTRAINT curriculum_semesters_pkey PRIMARY KEY (id);


--
-- Name: curriculums curriculums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculums
    ADD CONSTRAINT curriculums_pkey PRIMARY KEY (id);


--
-- Name: districts districts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);


--
-- Name: document_types document_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (id);


--
-- Name: duties duties_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.duties
    ADD CONSTRAINT duties_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: evaluation_types evaluation_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_types
    ADD CONSTRAINT evaluation_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: evaluation_types evaluation_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_types
    ADD CONSTRAINT evaluation_types_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: group_courses group_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_courses
    ADD CONSTRAINT group_courses_pkey PRIMARY KEY (id);


--
-- Name: high_school_types high_school_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.high_school_types
    ADD CONSTRAINT high_school_types_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: languages languages_iso_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_iso_unique UNIQUE (iso) DEFERRABLE;


--
-- Name: languages languages_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: meeting_agendas meeting_agendas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agendas
    ADD CONSTRAINT meeting_agendas_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: prospective_employees prospective_employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_employees
    ADD CONSTRAINT prospective_employees_pkey PRIMARY KEY (id);


--
-- Name: prospective_students prospective_students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT prospective_students_pkey PRIMARY KEY (id);


--
-- Name: query_stores query_stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.query_stores
    ADD CONSTRAINT query_stores_pkey PRIMARY KEY (id);


--
-- Name: registration_documents registration_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_documents
    ADD CONSTRAINT registration_documents_pkey PRIMARY KEY (id);


--
-- Name: role_assignments role_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_assignments
    ADD CONSTRAINT role_assignments_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scope_assignments scope_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_assignments
    ADD CONSTRAINT scope_assignments_pkey PRIMARY KEY (id);


--
-- Name: student_disability_types student_disability_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_disability_types
    ADD CONSTRAINT student_disability_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_disability_types student_disability_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_disability_types
    ADD CONSTRAINT student_disability_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_disability_types student_disability_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_disability_types
    ADD CONSTRAINT student_disability_types_pkey PRIMARY KEY (id);


--
-- Name: student_drop_out_types student_drop_out_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_drop_out_types
    ADD CONSTRAINT student_drop_out_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_drop_out_types student_drop_out_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_drop_out_types
    ADD CONSTRAINT student_drop_out_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_drop_out_types student_drop_out_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_drop_out_types
    ADD CONSTRAINT student_drop_out_types_pkey PRIMARY KEY (id);


--
-- Name: student_education_levels student_education_levels_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_education_levels
    ADD CONSTRAINT student_education_levels_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_education_levels student_education_levels_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_education_levels
    ADD CONSTRAINT student_education_levels_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_education_levels student_education_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_education_levels
    ADD CONSTRAINT student_education_levels_pkey PRIMARY KEY (id);


--
-- Name: student_entrance_point_types student_entrance_point_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_point_types
    ADD CONSTRAINT student_entrance_point_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_entrance_point_types student_entrance_point_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_point_types
    ADD CONSTRAINT student_entrance_point_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_entrance_point_types student_entrance_point_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_point_types
    ADD CONSTRAINT student_entrance_point_types_pkey PRIMARY KEY (id);


--
-- Name: student_entrance_types student_entrance_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_types
    ADD CONSTRAINT student_entrance_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_entrance_types student_entrance_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_types
    ADD CONSTRAINT student_entrance_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_entrance_types student_entrance_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_entrance_types
    ADD CONSTRAINT student_entrance_types_pkey PRIMARY KEY (id);


--
-- Name: student_grades student_grades_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_grades student_grades_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_grades student_grades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grades
    ADD CONSTRAINT student_grades_pkey PRIMARY KEY (id);


--
-- Name: student_grading_systems student_grading_systems_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grading_systems
    ADD CONSTRAINT student_grading_systems_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_grading_systems student_grading_systems_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grading_systems
    ADD CONSTRAINT student_grading_systems_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_grading_systems student_grading_systems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_grading_systems
    ADD CONSTRAINT student_grading_systems_pkey PRIMARY KEY (id);


--
-- Name: student_punishment_types student_punishment_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_punishment_types
    ADD CONSTRAINT student_punishment_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_punishment_types student_punishment_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_punishment_types
    ADD CONSTRAINT student_punishment_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_punishment_types student_punishment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_punishment_types
    ADD CONSTRAINT student_punishment_types_pkey PRIMARY KEY (id);


--
-- Name: student_studentship_statuses student_studentship_statuses_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_studentship_statuses
    ADD CONSTRAINT student_studentship_statuses_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: student_studentship_statuses student_studentship_statuses_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_studentship_statuses
    ADD CONSTRAINT student_studentship_statuses_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: student_studentship_statuses student_studentship_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.student_studentship_statuses
    ADD CONSTRAINT student_studentship_statuses_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: titles titles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.titles
    ADD CONSTRAINT titles_pkey PRIMARY KEY (id);


--
-- Name: unit_calendars unit_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_calendars
    ADD CONSTRAINT unit_calendars_pkey PRIMARY KEY (id);


--
-- Name: unit_instruction_languages unit_instruction_languages_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_languages
    ADD CONSTRAINT unit_instruction_languages_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: unit_instruction_languages unit_instruction_languages_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_languages
    ADD CONSTRAINT unit_instruction_languages_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: unit_instruction_languages unit_instruction_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_languages
    ADD CONSTRAINT unit_instruction_languages_pkey PRIMARY KEY (id);


--
-- Name: unit_instruction_types unit_instruction_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_types
    ADD CONSTRAINT unit_instruction_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: unit_instruction_types unit_instruction_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_types
    ADD CONSTRAINT unit_instruction_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: unit_instruction_types unit_instruction_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_instruction_types
    ADD CONSTRAINT unit_instruction_types_pkey PRIMARY KEY (id);


--
-- Name: unit_statuses unit_statuses_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_statuses
    ADD CONSTRAINT unit_statuses_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: unit_statuses unit_statuses_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_statuses
    ADD CONSTRAINT unit_statuses_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: unit_statuses unit_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_statuses
    ADD CONSTRAINT unit_statuses_pkey PRIMARY KEY (id);


--
-- Name: unit_types unit_types_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_code_unique UNIQUE (code) DEFERRABLE;


--
-- Name: unit_types unit_types_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_name_unique UNIQUE (name) DEFERRABLE;


--
-- Name: unit_types unit_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_types
    ADD CONSTRAINT unit_types_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: university_types university_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.university_types
    ADD CONSTRAINT university_types_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email) DEFERRABLE;


--
-- Name: users users_id_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_number_unique UNIQUE (id_number) DEFERRABLE;


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_action_text_rich_texts_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_action_text_rich_texts_uniqueness ON public.action_text_rich_texts USING btree (record_type, record_id, name);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_addresses_on_district_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_district_id ON public.addresses USING btree (district_id);


--
-- Name: index_addresses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_user_id ON public.addresses USING btree (user_id);


--
-- Name: index_agendas_on_agenda_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_agendas_on_agenda_type_id ON public.agendas USING btree (agenda_type_id);


--
-- Name: index_agendas_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_agendas_on_unit_id ON public.agendas USING btree (unit_id);


--
-- Name: index_articles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_articles_on_user_id ON public.articles USING btree (user_id);


--
-- Name: index_available_course_groups_on_available_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_course_groups_on_available_course_id ON public.available_course_groups USING btree (available_course_id);


--
-- Name: index_available_course_lecturers_on_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_course_lecturers_on_group_id ON public.available_course_lecturers USING btree (group_id);


--
-- Name: index_available_course_lecturers_on_lecturer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_course_lecturers_on_lecturer_id ON public.available_course_lecturers USING btree (lecturer_id);


--
-- Name: index_available_courses_on_academic_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_courses_on_academic_term_id ON public.available_courses USING btree (academic_term_id);


--
-- Name: index_available_courses_on_coordinator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_courses_on_coordinator_id ON public.available_courses USING btree (coordinator_id);


--
-- Name: index_available_courses_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_courses_on_course_id ON public.available_courses USING btree (course_id);


--
-- Name: index_available_courses_on_curriculum_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_courses_on_curriculum_id ON public.available_courses USING btree (curriculum_id);


--
-- Name: index_available_courses_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_available_courses_on_unit_id ON public.available_courses USING btree (unit_id);


--
-- Name: index_calendar_committee_decisions_on_calendar_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_calendar_committee_decisions_on_calendar_id ON public.calendar_committee_decisions USING btree (calendar_id);


--
-- Name: index_calendar_committee_decisions_on_committee_decision_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_calendar_committee_decisions_on_committee_decision_id ON public.calendar_committee_decisions USING btree (committee_decision_id);


--
-- Name: index_calendar_events_on_calendar_event_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_calendar_events_on_calendar_event_type_id ON public.calendar_events USING btree (calendar_event_type_id);


--
-- Name: index_calendar_events_on_calendar_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_calendar_events_on_calendar_id ON public.calendar_events USING btree (calendar_id);


--
-- Name: index_calendars_on_academic_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_calendars_on_academic_term_id ON public.calendars USING btree (academic_term_id);


--
-- Name: index_certifications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_certifications_on_user_id ON public.certifications USING btree (user_id);


--
-- Name: index_cities_on_country_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cities_on_country_id ON public.cities USING btree (country_id);


--
-- Name: index_committee_decisions_on_meeting_agenda_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_committee_decisions_on_meeting_agenda_id ON public.committee_decisions USING btree (meeting_agenda_id);


--
-- Name: index_committee_meetings_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_committee_meetings_on_unit_id ON public.committee_meetings USING btree (unit_id);


--
-- Name: index_course_assessment_methods_on_assessment_method_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_assessment_methods_on_assessment_method_id ON public.course_assessment_methods USING btree (assessment_method_id);


--
-- Name: index_course_assessment_methods_on_course_evaluation_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_assessment_methods_on_course_evaluation_type_id ON public.course_assessment_methods USING btree (course_evaluation_type_id);


--
-- Name: index_course_evaluation_types_on_available_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_evaluation_types_on_available_course_id ON public.course_evaluation_types USING btree (available_course_id);


--
-- Name: index_course_evaluation_types_on_evaluation_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_evaluation_types_on_evaluation_type_id ON public.course_evaluation_types USING btree (evaluation_type_id);


--
-- Name: index_course_groups_on_course_group_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_groups_on_course_group_type_id ON public.course_groups USING btree (course_group_type_id);


--
-- Name: index_course_groups_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_groups_on_unit_id ON public.course_groups USING btree (unit_id);


--
-- Name: index_courses_on_course_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_course_type_id ON public.courses USING btree (course_type_id);


--
-- Name: index_courses_on_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_language_id ON public.courses USING btree (language_id);


--
-- Name: index_courses_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_unit_id ON public.courses USING btree (unit_id);


--
-- Name: index_curriculum_course_groups_on_course_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_course_groups_on_course_group_id ON public.curriculum_course_groups USING btree (course_group_id);


--
-- Name: index_curriculum_course_groups_on_curriculum_semester_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_course_groups_on_curriculum_semester_id ON public.curriculum_course_groups USING btree (curriculum_semester_id);


--
-- Name: index_curriculum_courses_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_courses_on_course_id ON public.curriculum_courses USING btree (course_id);


--
-- Name: index_curriculum_courses_on_curriculum_course_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_courses_on_curriculum_course_group_id ON public.curriculum_courses USING btree (curriculum_course_group_id);


--
-- Name: index_curriculum_courses_on_curriculum_semester_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_courses_on_curriculum_semester_id ON public.curriculum_courses USING btree (curriculum_semester_id);


--
-- Name: index_curriculum_programs_on_curriculum_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_programs_on_curriculum_id ON public.curriculum_programs USING btree (curriculum_id);


--
-- Name: index_curriculum_programs_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_programs_on_unit_id ON public.curriculum_programs USING btree (unit_id);


--
-- Name: index_curriculum_semesters_on_curriculum_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculum_semesters_on_curriculum_id ON public.curriculum_semesters USING btree (curriculum_id);


--
-- Name: index_curriculums_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_curriculums_on_unit_id ON public.curriculums USING btree (unit_id);


--
-- Name: index_districts_on_city_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_districts_on_city_id ON public.districts USING btree (city_id);


--
-- Name: index_duties_on_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_duties_on_employee_id ON public.duties USING btree (employee_id);


--
-- Name: index_duties_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_duties_on_unit_id ON public.duties USING btree (unit_id);


--
-- Name: index_employees_on_title_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_employees_on_title_id ON public.employees USING btree (title_id);


--
-- Name: index_employees_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_employees_on_user_id ON public.employees USING btree (user_id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON public.friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON public.friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON public.friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_group_courses_on_course_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_courses_on_course_group_id ON public.group_courses USING btree (course_group_id);


--
-- Name: index_group_courses_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_group_courses_on_course_id ON public.group_courses USING btree (course_id);


--
-- Name: index_identities_on_student_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_identities_on_student_id ON public.identities USING btree (student_id);


--
-- Name: index_identities_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_identities_on_user_id ON public.identities USING btree (user_id);


--
-- Name: index_meeting_agendas_on_agenda_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agendas_on_agenda_id ON public.meeting_agendas USING btree (agenda_id);


--
-- Name: index_meeting_agendas_on_committee_meeting_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_meeting_agendas_on_committee_meeting_id ON public.meeting_agendas USING btree (committee_meeting_id);


--
-- Name: index_permissions_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_name ON public.permissions USING btree (name);


--
-- Name: index_positions_on_administrative_function_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_positions_on_administrative_function_id ON public.positions USING btree (administrative_function_id);


--
-- Name: index_positions_on_duty_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_positions_on_duty_id ON public.positions USING btree (duty_id);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_user_id ON public.projects USING btree (user_id);


--
-- Name: index_prospective_employees_on_title_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_employees_on_title_id ON public.prospective_employees USING btree (title_id);


--
-- Name: index_prospective_employees_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_employees_on_unit_id ON public.prospective_employees USING btree (unit_id);


--
-- Name: index_prospective_students_on_academic_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_students_on_academic_term_id ON public.prospective_students USING btree (academic_term_id);


--
-- Name: index_prospective_students_on_high_school_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_students_on_high_school_type_id ON public.prospective_students USING btree (high_school_type_id);


--
-- Name: index_prospective_students_on_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_students_on_language_id ON public.prospective_students USING btree (language_id);


--
-- Name: index_prospective_students_on_student_disability_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_students_on_student_disability_type_id ON public.prospective_students USING btree (student_disability_type_id);


--
-- Name: index_prospective_students_on_student_entrance_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_students_on_student_entrance_type_id ON public.prospective_students USING btree (student_entrance_type_id);


--
-- Name: index_prospective_students_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prospective_students_on_unit_id ON public.prospective_students USING btree (unit_id);


--
-- Name: index_query_stores_on_scope_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_query_stores_on_scope_name ON public.query_stores USING btree (scope_name);


--
-- Name: index_registration_documents_on_academic_term_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registration_documents_on_academic_term_id ON public.registration_documents USING btree (academic_term_id);


--
-- Name: index_registration_documents_on_document_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registration_documents_on_document_type_id ON public.registration_documents USING btree (document_type_id);


--
-- Name: index_registration_documents_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registration_documents_on_unit_id ON public.registration_documents USING btree (unit_id);


--
-- Name: index_role_assignments_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_assignments_on_role_id ON public.role_assignments USING btree (role_id);


--
-- Name: index_role_assignments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_assignments_on_user_id ON public.role_assignments USING btree (user_id);


--
-- Name: index_role_permissions_on_permission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_permissions_on_permission_id ON public.role_permissions USING btree (permission_id);


--
-- Name: index_role_permissions_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_role_permissions_on_role_id ON public.role_permissions USING btree (role_id);


--
-- Name: index_role_permissions_on_role_id_and_permission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_role_permissions_on_role_id_and_permission_id ON public.role_permissions USING btree (role_id, permission_id);


--
-- Name: index_roles_on_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_roles_on_identifier ON public.roles USING btree (identifier);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_scope_assignments_on_query_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scope_assignments_on_query_store_id ON public.scope_assignments USING btree (query_store_id);


--
-- Name: index_scope_assignments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scope_assignments_on_user_id ON public.scope_assignments USING btree (user_id);


--
-- Name: index_students_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_students_on_unit_id ON public.students USING btree (unit_id);


--
-- Name: index_students_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_students_on_user_id ON public.students USING btree (user_id);


--
-- Name: index_unit_calendars_on_calendar_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_unit_calendars_on_calendar_id ON public.unit_calendars USING btree (calendar_id);


--
-- Name: index_unit_calendars_on_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_unit_calendars_on_unit_id ON public.unit_calendars USING btree (unit_id);


--
-- Name: index_units_on_ancestry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_ancestry ON public.units USING btree (ancestry);


--
-- Name: index_units_on_district_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_district_id ON public.units USING btree (district_id);


--
-- Name: index_units_on_unit_instruction_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_unit_instruction_language_id ON public.units USING btree (unit_instruction_language_id);


--
-- Name: index_units_on_unit_instruction_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_unit_instruction_type_id ON public.units USING btree (unit_instruction_type_id);


--
-- Name: index_units_on_unit_status_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_unit_status_id ON public.units USING btree (unit_status_id);


--
-- Name: index_units_on_unit_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_unit_type_id ON public.units USING btree (unit_type_id);


--
-- Name: index_units_on_university_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_units_on_university_type_id ON public.units USING btree (university_type_id);


--
-- Name: index_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_id_and_role_id ON public.role_assignments USING btree (user_id, role_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_id_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_id_number ON public.users USING btree (id_number);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: calendar_events fk_rails_0011c39cc3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT fk_rails_0011c39cc3 FOREIGN KEY (calendar_id) REFERENCES public.calendars(id);


--
-- Name: calendars fk_rails_02803298e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendars
    ADD CONSTRAINT fk_rails_02803298e9 FOREIGN KEY (academic_term_id) REFERENCES public.academic_terms(id);


--
-- Name: courses fk_rails_051656b790; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_051656b790 FOREIGN KEY (course_type_id) REFERENCES public.course_types(id);


--
-- Name: meeting_agendas fk_rails_05369f2b5b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agendas
    ADD CONSTRAINT fk_rails_05369f2b5b FOREIGN KEY (agenda_id) REFERENCES public.agendas(id);


--
-- Name: curriculum_courses fk_rails_085e487ff3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_courses
    ADD CONSTRAINT fk_rails_085e487ff3 FOREIGN KEY (curriculum_course_group_id) REFERENCES public.curriculum_course_groups(id);


--
-- Name: agendas fk_rails_11f2fa1aba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT fk_rails_11f2fa1aba FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: students fk_rails_148c9e88f4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT fk_rails_148c9e88f4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: duties fk_rails_1b35a03564; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.duties
    ADD CONSTRAINT fk_rails_1b35a03564 FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- Name: addresses fk_rails_1b98d66e19; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_1b98d66e19 FOREIGN KEY (district_id) REFERENCES public.districts(id);


--
-- Name: registration_documents fk_rails_2f3d74d701; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_documents
    ADD CONSTRAINT fk_rails_2f3d74d701 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: students fk_rails_3154ddd827; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT fk_rails_3154ddd827 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: curriculum_semesters fk_rails_32e14f7893; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_semesters
    ADD CONSTRAINT fk_rails_32e14f7893 FOREIGN KEY (curriculum_id) REFERENCES public.curriculums(id);


--
-- Name: curriculum_programs fk_rails_33195b0adb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_programs
    ADD CONSTRAINT fk_rails_33195b0adb FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: course_assessment_methods fk_rails_3351011c48; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_assessment_methods
    ADD CONSTRAINT fk_rails_3351011c48 FOREIGN KEY (course_evaluation_type_id) REFERENCES public.course_evaluation_types(id);


--
-- Name: available_courses fk_rails_356137da91; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses
    ADD CONSTRAINT fk_rails_356137da91 FOREIGN KEY (academic_term_id) REFERENCES public.academic_terms(id);


--
-- Name: group_courses fk_rails_3b3edaa11b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_courses
    ADD CONSTRAINT fk_rails_3b3edaa11b FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: curriculums fk_rails_3befe032e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculums
    ADD CONSTRAINT fk_rails_3befe032e9 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: articles fk_rails_3d31dad1cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT fk_rails_3d31dad1cc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: duties fk_rails_3f1a2d48dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.duties
    ADD CONSTRAINT fk_rails_3f1a2d48dd FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: course_groups fk_rails_40d03200ff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_groups
    ADD CONSTRAINT fk_rails_40d03200ff FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: units fk_rails_410eb899ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT fk_rails_410eb899ca FOREIGN KEY (unit_status_id) REFERENCES public.unit_statuses(id);


--
-- Name: employees fk_rails_4126944f82; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_rails_4126944f82 FOREIGN KEY (title_id) REFERENCES public.titles(id);


--
-- Name: curriculum_courses fk_rails_4181a1584a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_courses
    ADD CONSTRAINT fk_rails_4181a1584a FOREIGN KEY (curriculum_semester_id) REFERENCES public.curriculum_semesters(id);


--
-- Name: role_permissions fk_rails_439e640a3f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_rails_439e640a3f FOREIGN KEY (permission_id) REFERENCES public.permissions(id);


--
-- Name: committee_decisions fk_rails_44d9592deb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.committee_decisions
    ADD CONSTRAINT fk_rails_44d9592deb FOREIGN KEY (meeting_agenda_id) REFERENCES public.meeting_agendas(id);


--
-- Name: available_courses fk_rails_4783d78ac5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses
    ADD CONSTRAINT fk_rails_4783d78ac5 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: unit_calendars fk_rails_47a7d8ee6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_calendars
    ADD CONSTRAINT fk_rails_47a7d8ee6a FOREIGN KEY (calendar_id) REFERENCES public.calendars(id);


--
-- Name: addresses fk_rails_48c9e0c5a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_48c9e0c5a2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: course_groups fk_rails_4af2ef6ebe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_groups
    ADD CONSTRAINT fk_rails_4af2ef6ebe FOREIGN KEY (course_group_type_id) REFERENCES public.course_group_types(id);


--
-- Name: calendar_committee_decisions fk_rails_4f3eb3da94; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_committee_decisions
    ADD CONSTRAINT fk_rails_4f3eb3da94 FOREIGN KEY (calendar_id) REFERENCES public.calendars(id);


--
-- Name: identities fk_rails_5373344100; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT fk_rails_5373344100 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: prospective_students fk_rails_54b90f3e1c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT fk_rails_54b90f3e1c FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: curriculum_programs fk_rails_5503b9bced; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_programs
    ADD CONSTRAINT fk_rails_5503b9bced FOREIGN KEY (curriculum_id) REFERENCES public.curriculums(id);


--
-- Name: units fk_rails_5951990ba9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT fk_rails_5951990ba9 FOREIGN KEY (district_id) REFERENCES public.districts(id);


--
-- Name: calendar_committee_decisions fk_rails_5d6264c4f2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_committee_decisions
    ADD CONSTRAINT fk_rails_5d6264c4f2 FOREIGN KEY (committee_decision_id) REFERENCES public.committee_decisions(id);


--
-- Name: role_permissions fk_rails_60126080bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_rails_60126080bd FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: calendar_events fk_rails_64d7b22524; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT fk_rails_64d7b22524 FOREIGN KEY (calendar_event_type_id) REFERENCES public.calendar_event_types(id);


--
-- Name: meeting_agendas fk_rails_694b3fc610; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meeting_agendas
    ADD CONSTRAINT fk_rails_694b3fc610 FOREIGN KEY (committee_meeting_id) REFERENCES public.committee_meetings(id);


--
-- Name: group_courses fk_rails_728bb39a67; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_courses
    ADD CONSTRAINT fk_rails_728bb39a67 FOREIGN KEY (course_group_id) REFERENCES public.course_groups(id);


--
-- Name: positions fk_rails_78999e7b17; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT fk_rails_78999e7b17 FOREIGN KEY (administrative_function_id) REFERENCES public.administrative_functions(id);


--
-- Name: scope_assignments fk_rails_796253dfbd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_assignments
    ADD CONSTRAINT fk_rails_796253dfbd FOREIGN KEY (query_store_id) REFERENCES public.query_stores(id);


--
-- Name: prospective_employees fk_rails_7e3da1fde7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_employees
    ADD CONSTRAINT fk_rails_7e3da1fde7 FOREIGN KEY (title_id) REFERENCES public.titles(id);


--
-- Name: units fk_rails_83a021318e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT fk_rails_83a021318e FOREIGN KEY (unit_instruction_language_id) REFERENCES public.unit_instruction_languages(id);


--
-- Name: identities fk_rails_8540afbff7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identities
    ADD CONSTRAINT fk_rails_8540afbff7 FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: available_course_lecturers fk_rails_86397e28ff; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_lecturers
    ADD CONSTRAINT fk_rails_86397e28ff FOREIGN KEY (lecturer_id) REFERENCES public.employees(id);


--
-- Name: curriculum_course_groups fk_rails_89bfbfdd76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_course_groups
    ADD CONSTRAINT fk_rails_89bfbfdd76 FOREIGN KEY (curriculum_semester_id) REFERENCES public.curriculum_semesters(id);


--
-- Name: units fk_rails_8ab0da65e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT fk_rails_8ab0da65e4 FOREIGN KEY (unit_instruction_type_id) REFERENCES public.unit_instruction_types(id);


--
-- Name: positions fk_rails_8d264a5cbc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.positions
    ADD CONSTRAINT fk_rails_8d264a5cbc FOREIGN KEY (duty_id) REFERENCES public.duties(id);


--
-- Name: role_assignments fk_rails_8ddd873ee0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_assignments
    ADD CONSTRAINT fk_rails_8ddd873ee0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: available_course_lecturers fk_rails_917e7d3603; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_lecturers
    ADD CONSTRAINT fk_rails_917e7d3603 FOREIGN KEY (group_id) REFERENCES public.available_course_groups(id);


--
-- Name: districts fk_rails_92c48f7cf2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT fk_rails_92c48f7cf2 FOREIGN KEY (city_id) REFERENCES public.cities(id);


--
-- Name: prospective_students fk_rails_93498b6370; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT fk_rails_93498b6370 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: cities fk_rails_996e05be41; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT fk_rails_996e05be41 FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: certifications fk_rails_99ad041748; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT fk_rails_99ad041748 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: scope_assignments fk_rails_9d2d00a9ee; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_assignments
    ADD CONSTRAINT fk_rails_9d2d00a9ee FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: prospective_students fk_rails_a6111d55a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT fk_rails_a6111d55a4 FOREIGN KEY (high_school_type_id) REFERENCES public.high_school_types(id);


--
-- Name: courses fk_rails_a72394c071; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_a72394c071 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: registration_documents fk_rails_a7647dd384; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_documents
    ADD CONSTRAINT fk_rails_a7647dd384 FOREIGN KEY (academic_term_id) REFERENCES public.academic_terms(id);


--
-- Name: available_courses fk_rails_a9099f01f5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses
    ADD CONSTRAINT fk_rails_a9099f01f5 FOREIGN KEY (coordinator_id) REFERENCES public.employees(id);


--
-- Name: prospective_students fk_rails_b1c146f76e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT fk_rails_b1c146f76e FOREIGN KEY (student_entrance_type_id) REFERENCES public.student_entrance_types(id);


--
-- Name: course_evaluation_types fk_rails_b25d062eb5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_evaluation_types
    ADD CONSTRAINT fk_rails_b25d062eb5 FOREIGN KEY (evaluation_type_id) REFERENCES public.evaluation_types(id);


--
-- Name: projects fk_rails_b872a6760a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_rails_b872a6760a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: agendas fk_rails_b92b5eaf98; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT fk_rails_b92b5eaf98 FOREIGN KEY (agenda_type_id) REFERENCES public.agenda_types(id);


--
-- Name: course_evaluation_types fk_rails_bb4be290e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_evaluation_types
    ADD CONSTRAINT fk_rails_bb4be290e9 FOREIGN KEY (available_course_id) REFERENCES public.available_courses(id);


--
-- Name: available_courses fk_rails_c4a7c8b06e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses
    ADD CONSTRAINT fk_rails_c4a7c8b06e FOREIGN KEY (curriculum_id) REFERENCES public.curriculums(id);


--
-- Name: courses fk_rails_cb5582d97e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_cb5582d97e FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: registration_documents fk_rails_cb709e42ad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_documents
    ADD CONSTRAINT fk_rails_cb709e42ad FOREIGN KEY (document_type_id) REFERENCES public.document_types(id);


--
-- Name: prospective_employees fk_rails_cfef503ec1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_employees
    ADD CONSTRAINT fk_rails_cfef503ec1 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: prospective_students fk_rails_d94afad69b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT fk_rails_d94afad69b FOREIGN KEY (academic_term_id) REFERENCES public.academic_terms(id);


--
-- Name: units fk_rails_db99877142; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT fk_rails_db99877142 FOREIGN KEY (unit_type_id) REFERENCES public.unit_types(id);


--
-- Name: employees fk_rails_dcfd3d4fc3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_rails_dcfd3d4fc3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: role_assignments fk_rails_e4bfc1cd2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_assignments
    ADD CONSTRAINT fk_rails_e4bfc1cd2c FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: curriculum_courses fk_rails_e756d4597e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_courses
    ADD CONSTRAINT fk_rails_e756d4597e FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: units fk_rails_ea494f8318; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT fk_rails_ea494f8318 FOREIGN KEY (university_type_id) REFERENCES public.university_types(id);


--
-- Name: prospective_students fk_rails_ea9bbc92e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospective_students
    ADD CONSTRAINT fk_rails_ea9bbc92e2 FOREIGN KEY (student_disability_type_id) REFERENCES public.student_disability_types(id);


--
-- Name: available_course_groups fk_rails_edbeba9693; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_course_groups
    ADD CONSTRAINT fk_rails_edbeba9693 FOREIGN KEY (available_course_id) REFERENCES public.available_courses(id);


--
-- Name: curriculum_course_groups fk_rails_f0035661f5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.curriculum_course_groups
    ADD CONSTRAINT fk_rails_f0035661f5 FOREIGN KEY (course_group_id) REFERENCES public.course_groups(id);


--
-- Name: course_assessment_methods fk_rails_f2b5f80e2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_assessment_methods
    ADD CONSTRAINT fk_rails_f2b5f80e2c FOREIGN KEY (assessment_method_id) REFERENCES public.assessment_methods(id);


--
-- Name: available_courses fk_rails_f75b60bc6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_courses
    ADD CONSTRAINT fk_rails_f75b60bc6a FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: committee_meetings fk_rails_f85b219ea4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.committee_meetings
    ADD CONSTRAINT fk_rails_f85b219ea4 FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- Name: unit_calendars fk_rails_faff5aa83d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_calendars
    ADD CONSTRAINT fk_rails_faff5aa83d FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180304233108'),
('20180305010433'),
('20180305142048'),
('20180430103419'),
('20180503160019'),
('20180503160241'),
('20180503160350'),
('20180503162057'),
('20180503162130'),
('20180503162207'),
('20180503162231'),
('20180503162428'),
('20180503162541'),
('20180503162700'),
('20180503162721'),
('20180503162736'),
('20180503162854'),
('20180503163040'),
('20180503183140'),
('20180503201708'),
('20180505103618'),
('20180506085730'),
('20180506124416'),
('20180506144416'),
('20180507045201'),
('20180507052504'),
('20180507054557'),
('20180507131709'),
('20180519215220'),
('20180525173627'),
('20180620113700'),
('20180621072455'),
('20180707205827'),
('20180710213813'),
('20180712130547'),
('20180807230631'),
('20180912131204'),
('20180913075455'),
('20180918094522'),
('20180918101150'),
('20180918111151'),
('20180918151443'),
('20180918155235'),
('20180918174839'),
('20180919063348'),
('20180919072617'),
('20180919121858'),
('20181001111810'),
('20181004112631'),
('20181009073057'),
('20181019082622'),
('20181107102430'),
('20181112174827'),
('20181112175328'),
('20181112175343'),
('20181130131559'),
('20181210221451'),
('20181225180258'),
('20181225195123'),
('20181225201818'),
('20181226013104'),
('20190115062149'),
('20190115100844'),
('20190116104001'),
('20190116115745'),
('20190122203727'),
('20190130105509'),
('20190130114547'),
('20190304052823'),
('20190321163816'),
('20190321213030'),
('20190321213059'),
('20190325051222'),
('20190419113152'),
('20190422103239'),
('20190422103754'),
('20190422104033'),
('20190422104410'),
('20190422104613'),
('20190422141252'),
('20190425065306');


