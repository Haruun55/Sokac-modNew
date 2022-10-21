ALTER TABLE job_grades ADD `uplacivanje` tinyint(1) DEFAULT 0;
ALTER TABLE job_grades ADD `podizanje` tinyint(1) DEFAULT 0;
ALTER TABLE job_grades ADD `rankovi` tinyint(1) DEFAULT 0;
ALTER TABLE job_grades ADD `clanovi` tinyint(1) DEFAULT 0;
ALTER TABLE job_grades ADD `zaposljavanje` tinyint(1) DEFAULT 0;
ALTER TABLE job_grades ADD `permisije` tinyint(1) DEFAULT 0;
ALTER TABLE job_grades ADD `plate` tinyint(1) DEFAULT 0;

ALTER TABLE jobs ADD `black` bigint(20) DEFAULT 0;
ALTER TABLE jobs ADD `money` bigint(20) DEFAULT 0;
