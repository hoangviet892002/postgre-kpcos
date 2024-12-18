CREATE TABLE administrative_regions (
    id integer NOT NULL,
    "name" varchar(255) NOT NULL,
    name_en varchar(255) NOT NULL,
    code_name varchar(255) NULL,
    code_name_en varchar(255) NULL,
    CONSTRAINT administrative_regions_pkey PRIMARY KEY (id)
);
