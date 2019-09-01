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


GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_angel TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_deamon TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_deccot_gitlab TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_deccot_github TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_ghost_shadow TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_grigori TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_impure_active TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_impure_finished TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_impure_discarded TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_maledict TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_orthodox_duty TO hw_user;
GRANT SELECT,INSERT,UPDATE,DELETE,TRUNCATE ON rs_orthodox TO hw_user;


GRANT USAGE, SELECT, UPDATE ON rs_angel_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_deamon_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_deccot_gitlab_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_deccot_github_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_ghost_shadow_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_grigori_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_impure_active_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_impure_finished_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_impure_discarded_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_maledict_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_orthodox_duty_id_seq TO hw_user;
GRANT USAGE, SELECT, UPDATE ON rs_orthodox_id_seq TO hw_user;
