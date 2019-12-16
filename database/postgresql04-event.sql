/* psql -U hw_sys -d holy_water */

/* **************************************************************** */
/* Resources                                                        */
/* **************************************************************** */
CREATE TABLE IF NOT EXISTS rs_angel (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);


CREATE TABLE IF NOT EXISTS rs_deamon (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    name_short VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    purged_at TIMESTAMPTZ,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_deccot_gitlab (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    private_token VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_deccot_github (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    oauth_token VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_ghost_shadow (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    ghost_id INTEGER NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_grigori (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_impure_active (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_impure_finished (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    finished_at TIMESTAMPTZ NOT NULL,
    finished_by BIGSERIAL NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_impure_discarded (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    discarded_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_maledict (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    maledict_type_id BIGSERIAL NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    deletable INTEGER NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_orthodox_duty (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS rs_orthodox (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);


/* **************************************************************** */
/* th                                                               */
/* **************************************************************** */
CREATE TABLE IF NOT EXISTS th_angel_maledict (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    angel_id BIGSERIAL NOT NULL,
    maledict_id BIGSERIAL NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS th_deamon_impure (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    deamon_id BIGSERIAL NOT NULL,
    impure_id BIGSERIAL NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS th_ghost_shadow_angel (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    ghost_shadow_id BIGSERIAL NOT NULL,
    angel_id BIGSERIAL NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS th_ghost_shadow_deccot (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    ghost_shadow_id BIGSERIAL NOT NULL,
    deccot_id BIGSERIAL NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS th_orthodox_angel (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    orthodox_id BIGSERIAL NOT NULL,
    orthodox_duty_id BIGSERIAL NOT NULL,
    angel_id BIGSERIAL NOT NULL,
    appointed_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);


/* **************************************************************** */
/* re */
/* **************************************************************** */
CREATE TABLE IF NOT EXISTS re_impure (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    id_from BIGSERIAL NOT NULL,
    id_to BIGSERIAL NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);


/* **************************************************************** */
/* ev */
/* **************************************************************** */
CREATE TABLE IF NOT EXISTS ev_collect_impure (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    maledict_id BIGSERIAL NOT NULL,
    impure_id BIGSERIAL NOT NULL,
    start TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_collect_impure_history (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    maledict_id BIGSERIAL NOT NULL,
    impure_id BIGSERIAL NOT NULL,
    start TIMESTAMPTZ NOT NULL,
    "end" TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_incantation_solo (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    impure_id BIGSERIAL NOT NULL,
    angel_id BIGSERIAL NOT NULL,
    spell TEXT NOT NULL,
    incantation_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_incantation_duet (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    impure_id BIGSERIAL NOT NULL,
    angel_id_ena BIGSERIAL NOT NULL,
    angel_id_duo BIGSERIAL NOT NULL,
    spell TEXT NOT NULL,
    incantation_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);


CREATE TABLE IF NOT EXISTS ev_purge_start (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    angel_id BIGSERIAL NOT NULL,
    impure_id BIGSERIAL NOT NULL,
    description TEXT NOT NULL,
    start TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_purge_end (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    angel_id BIGSERIAL NOT NULL,
    impure_id BIGSERIAL NOT NULL,
    description TEXT NOT NULL,
    start TIMESTAMPTZ NOT NULL,
    "end" TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_request (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    impure_id BIGSERIAL NOT NULL,
    angel_id_from BIGSERIAL NOT NULL,
    angel_id_to BIGSERIAL NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_request_message_unread (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    impure_id BIGSERIAL NOT NULL,
    angel_id_from BIGSERIAL NOT NULL,
    angel_id_to BIGSERIAL NOT NULL,
    contents TEXT NOT NULL,
    messaged_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    request_id BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_request_message_read (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    impure_id BIGSERIAL NOT NULL,
    angel_id_from BIGSERIAL NOT NULL,
    angel_id_to BIGSERIAL NOT NULL,
    contents TEXT NOT NULL,
    messaged_at TIMESTAMPTZ NOT NULL,
    readed_at TIMESTAMPTZ NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    request_id BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS ev_setting_auth (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    angel_id BIGSERIAL NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_by BIGSERIAL NOT NULL,
    updated_by BIGSERIAL NOT NULL,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);


/* ***** */
/* grant */
/* ***** */
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_collect_impure TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_collect_impure_history TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_incantation_solo TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_incantation_duet TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_purge_start TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_purge_end TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_request TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_request_message_unread TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_request_message_read TO hw_app;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON ev_setting_auth TO hw_app;


GRANT USAGE, SELECT, UPDATE ON ev_collect_impure_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_collect_impure_history_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_incantation_solo_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_incantation_duet_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_purge_start_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_purge_end_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_request_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_request_message_unread_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_request_message_read_id_seq TO hw_app;
GRANT USAGE, SELECT, UPDATE ON ev_setting_auth_id_seq TO hw_app;


/* ***** */
/* grant */
/* ***** */
GRANT SELECT ON ev_collect_impure TO hw_user;
GRANT SELECT ON ev_collect_impure_history TO hw_user;
GRANT SELECT ON ev_incantation_solo TO hw_user;
GRANT SELECT ON ev_incantation_duet TO hw_user;
GRANT SELECT ON ev_purge_start TO hw_user;
GRANT SELECT ON ev_purge_end TO hw_user;
GRANT SELECT ON ev_request TO hw_user;
GRANT SELECT ON ev_request_message_unread TO hw_user;
GRANT SELECT ON ev_request_message_read TO hw_user;
GRANT SELECT ON ev_setting_auth TO hw_user;


GRANT USAGE, SELECT ON ev_collect_impure_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_collect_impure_history_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_incantation_solo_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_incantation_duet_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_purge_start_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_purge_end_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_request_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_request_message_unread_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_request_message_read_id_seq TO hw_user;
GRANT USAGE, SELECT ON ev_setting_auth_id_seq TO hw_user;
