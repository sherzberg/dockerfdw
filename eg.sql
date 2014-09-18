CREATE EXTENSION multicorn;

DROP FOREIGN TABLE IF EXISTS docker_containers;
DROP FOREIGN TABLE IF EXISTS docker_images;

DROP SERVER IF EXISTS docker_containers;
DROP SERVER IF EXISTS docker_images;


CREATE SERVER docker_containers FOREIGN DATA WRAPPER multicorn options (
    wrapper 'dockerfdw.wrappers.containers.ContainerFdw');

CREATE SERVER docker_image FOREIGN DATA WRAPPER multicorn options (
    wrapper 'dockerfdw.wrappers.images.ImageFdw');


CREATE foreign table docker_containers (
    "id"       TEXT,
    "image"    TEXT,
    "names"    TEXT[],
    "command"  TEXT,
    "created"  TIMESTAMP WITH TIME ZONE
) server docker_containers options (
    host 'unix:///run/docker.sock'
);


CREATE foreign table docker_images (
    "id"          TEXT,
    "repo_tag"    TEXT,
    "created"     TIMESTAMP WITH TIME ZONE
) server docker_image options (
    host 'unix:///run/docker.sock'
);


SELECT * FROM docker_images;
SELECT * FROM docker_containers;
