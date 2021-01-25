create sequence hibernate_sequence start 1 increment 1;

create table project_comments (
	comment_id int8 not null,
	comment varchar(255),
	status_comment boolean,
	project_id int8,
	primary key (comment_id)
);

create table project_steps (
	step_id int8 not null,
	status_step varchar(255) not null,
	step_name varchar(255) not null,
	project_id int8,
	primary key (step_id)
);

create table projects (
	project_id int8 not null,
	date_create varchar(255) not null,
	date_finishing varchar(255),
	description varchar(255),
	name_project varchar(255),
	number_project varchar(255) not null,
	revision varchar(255),
	status_project varchar(255),
	user_id int8,
	primary key (project_id)
);

create table steps (
	step_id int8 not null,
	step_name varchar(255),
	primary key (step_id)
);

create table user_role (
	user_id int8 not null,
	roles varchar(255)
);

create table usr (
	user_id int8 not null,
	active boolean not null,
	password varchar(255) not null,
	username varchar(255) not null,
	lastname varchar(255) not null,
	primary key (user_id)
);

alter table if exists project_comments
	add constraint comments_projects_fk
	foreign key (project_id) references projects;

alter table if exists project_steps
	add constraint project_steps_projects_fk
	foreign key (project_id) references projects;

alter table if exists projects
	add constraint projects_user_fk
	foreign key (user_id) references usr;

alter table if exists user_role
	add constraint user_role_user_fk
	foreign key (user_id) references usr;