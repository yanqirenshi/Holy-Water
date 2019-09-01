/* psql -U hw_sys -d holy_water */

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

/* ***** */
/* grant */
/* ***** */
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON th_angel_maledict TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON th_deamon_impure TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON th_ghost_shadow_angel TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON th_ghost_shadow_deccot TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON th_orthodox_angel TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON re_impure TO hw_user;


GRANT USAGE, SELECT, UPDATE ON th_angel_maledict_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON th_deamon_impure_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON th_ghost_shadow_angel_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON th_ghost_shadow_deccot_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON th_orthodox_angel_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON re_impure_id_seq TO hw_user;
