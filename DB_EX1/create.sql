create TABLE region(
	region varchar primary key
);

create TABLE incomegroup(
	incomegroup varchar primary key
);

create TABLE country(
	countrycode varchar(3) primary key,
	country varchar not NULL,
	region varchar not NULL,
	incomegroup varchar not NULL,
	foreign key (incomegroup) references incomegroup(incomegroup),
	foreign key (region) references region(region)
);


create TABLE university(
    iau_id1 varchar primary key,
    eng_name varchar not NULL,
	orig_name varchar not NULL,
	foundedyr integer not NULL,
	private01 integer not NULL check (private01 = 0 or private01 = 1),
	latitude float,
	longitude float,
	phd_granting integer not NULL check (phd_granting = 0 or phd_granting = 1),
	divisions integer,
	specialized integer not NULL check (specialized = 0 or specialized = 1),
	yrclosed integer,
	countrycode varchar(3) not NULL,
	foreign key (countrycode) references country(countrycode)
);

create TABLE admissions(
    iau_id1 varchar,
    year integer not NULL,
    students5_estimated integer,
    primary key (iau_id1, year),
    foreign key (iau_id1) references university(iau_id1)
);

