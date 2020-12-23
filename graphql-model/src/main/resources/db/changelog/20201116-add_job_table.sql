create table sync_table
(
	id uuid not null,
	entity varchar(20),
	entity_id uuid,
	expired timestamp,
	last_complete timestamp,
	locked boolean default false
);

create unique index sync_table_id_uindex
	on sync_table (id);

alter table sync_table
	add constraint sync_table_pk
		primary key (id);
