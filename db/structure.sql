SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

--
-- Name: upsert2_2_1_flights_sel_fa_flight_id_set_actual_arriv2102768571(character varying, character varying, character varying, boolean, boolean, character varying, character varying, boolean, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION upsert2_2_1_flights_sel_fa_flight_id_set_actual_arriv2102768571(fa_flight_id_sel character varying, actual_arrival_time_set character varying, actual_departure_time_set character varying, blocked_set boolean, cancelled_set boolean, created_at_set character varying, destination_icao_set character varying, diverted_set boolean, estimated_arrival_time_set character varying, estimated_departure_time_set character varying, fa_flight_id_set character varying, filed_arrival_time_set character varying, filed_departure_time_set character varying, origin_icao_set character varying, tail_number_set character varying, updated_at_set character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
          DECLARE
            first_try INTEGER := 1;
          BEGIN
            LOOP
              -- first try to update the key
              UPDATE "flights" SET "actual_arrival_time" = CAST("actual_arrival_time_set" AS timestamp without time zone), "actual_departure_time" = CAST("actual_departure_time_set" AS timestamp without time zone), "blocked" = "blocked_set", "cancelled" = "cancelled_set", "destination_icao" = "destination_icao_set", "diverted" = "diverted_set", "estimated_arrival_time" = CAST("estimated_arrival_time_set" AS timestamp without time zone), "estimated_departure_time" = CAST("estimated_departure_time_set" AS timestamp without time zone), "fa_flight_id" = "fa_flight_id_set", "filed_arrival_time" = CAST("filed_arrival_time_set" AS timestamp without time zone), "filed_departure_time" = CAST("filed_departure_time_set" AS timestamp without time zone), "origin_icao" = "origin_icao_set", "tail_number" = "tail_number_set", "updated_at" = CAST("updated_at_set" AS timestamp without time zone)
                WHERE ("fa_flight_id" = "fa_flight_id_sel" OR ("fa_flight_id" IS NULL AND "fa_flight_id_sel" IS NULL));
              IF found THEN
                
                RETURN;
              END IF;
              -- not there, so try to insert the key
              -- if someone else inserts the same key concurrently,
              -- we could get a unique-key failure
              BEGIN
                INSERT INTO "flights"("actual_arrival_time", "actual_departure_time", "blocked", "cancelled", "created_at", "destination_icao", "diverted", "estimated_arrival_time", "estimated_departure_time", "fa_flight_id", "filed_arrival_time", "filed_departure_time", "origin_icao", "tail_number", "updated_at") VALUES (CAST("actual_arrival_time_set" AS timestamp without time zone), CAST("actual_departure_time_set" AS timestamp without time zone), "blocked_set", "cancelled_set", CAST("created_at_set" AS timestamp without time zone), "destination_icao_set", "diverted_set", CAST("estimated_arrival_time_set" AS timestamp without time zone), CAST("estimated_departure_time_set" AS timestamp without time zone), "fa_flight_id_set", CAST("filed_arrival_time_set" AS timestamp without time zone), CAST("filed_departure_time_set" AS timestamp without time zone), "origin_icao_set", "tail_number_set", CAST("updated_at_set" AS timestamp without time zone));
                
                RETURN;
              EXCEPTION WHEN unique_violation THEN
                -- seamusabshere 9/20/12 only retry once
                IF (first_try = 1) THEN
                  first_try := 0;
                ELSE
                  RETURN;
                END IF;
                -- Do nothing, and loop to try the UPDATE again.
              END;
            END LOOP;
          END;
          $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admin_users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: airfields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE airfields (
    id bigint NOT NULL,
    icao character varying,
    iata character varying,
    name character varying,
    city character varying,
    state character varying,
    country character varying,
    elevation integer,
    lat double precision,
    lon double precision,
    tz character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: airfields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE airfields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: airfields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE airfields_id_seq OWNED BY airfields.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: flights; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE flights (
    id bigint NOT NULL,
    origin_icao character varying,
    destination_icao character varying,
    fa_flight_id character varying,
    tail_number character varying,
    filed_departure_time timestamp without time zone,
    estimated_departure_time timestamp without time zone,
    actual_departure_time timestamp without time zone,
    filed_arrival_time timestamp without time zone,
    estimated_arrival_time timestamp without time zone,
    actual_arrival_time timestamp without time zone,
    blocked boolean,
    diverted boolean,
    cancelled boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


--
-- Name: flights_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flights_id_seq OWNED BY flights.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE logs (
    id bigint NOT NULL,
    aircraft character varying,
    reg character varying,
    start time without time zone,
    stop time without time zone,
    captain character varying,
    capacity character varying,
    "from" character varying,
    "to" character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE logs_id_seq OWNED BY logs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    aircraft character varying[] DEFAULT '{}'::character varying[],
    skydemon_key character varying,
    billing_status character varying,
    customer_id character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: airfields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY airfields ALTER COLUMN id SET DEFAULT nextval('airfields_id_seq'::regclass);


--
-- Name: flights id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flights ALTER COLUMN id SET DEFAULT nextval('flights_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: active_admin_comments active_admin_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT active_admin_comments_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: airfields airfields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY airfields
    ADD CONSTRAINT airfields_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_active_admin_comments_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_flights_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_flights_on_user_id ON flights USING btree (user_id);


--
-- Name: index_logs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_logs_on_user_id ON logs USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: logs fk_rails_8fc980bf44; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT fk_rails_8fc980bf44 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: flights fk_rails_f23525dbb0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flights
    ADD CONSTRAINT fk_rails_f23525dbb0 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180722235437'),
('20180722235934'),
('20180723010602'),
('20180723012430'),
('20180723023428'),
('20180723052745'),
('20180724023803'),
('20180724023804'),
('20180728025757'),
('20180728212249'),
('20180728223225'),
('20180729173144'),
('20180729175730');


