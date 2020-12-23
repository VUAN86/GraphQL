DROP TABLE IF EXISTS attachment CASCADE ;
DROP TABLE IF EXISTS petition_document CASCADE ;
DROP TABLE IF EXISTS building CASCADE ;
DROP TABLE IF EXISTS petition CASCADE ;
DROP TABLE IF EXISTS petition_building CASCADE ;
DROP TABLE IF EXISTS status_history CASCADE ;
DROP TABLE IF EXISTS sgs_building CASCADE ;

CREATE TABLE attachment (
	id uuid NOT NULL, -- Идентификатор
	created_date timestamp NOT NULL, -- Дата создания
	last_modified_date timestamp NULL, -- Дата последнего изменения
	attachment_type varchar(10) NOT NULL, -- Тип вложения ((SCAN, SIG))
	content_type varchar(50) NULL, -- Тип MIME контента
	deleted bool NULL DEFAULT false, -- Признак удаленого  вложения
	length int8 NULL, -- Размер вложения (байтах)
	"name" varchar(100) NULL, -- Наименование вложения
	storage_id varchar(50) NULL, -- Идентификатор вложения в файловом хранилище
	extension varchar(100) NULL, -- Тип документа
	created_by_user_first_name varchar(100) NULL, -- Имя пользователя создавшим запись
	created_by_user_last_name varchar(100) NULL, -- Фамилия пользователя создавшим запись
	created_by_user_patronymic_name varchar(100) NULL, -- Отчество пользователя создавшим запись
	created_by_user_phone varchar(50) NULL, -- Телефон пользователя создавшим запись
	created_by_user_email varchar(50) NULL, -- Эл.почта пользователя создавшим запись
	created_by_user_id uuid NULL, -- Идентификатор  пользователя создавшим запись
	updated_by_user_first_name varchar(100) NULL, -- Имя пользователя последним изменившим запись
	updated_by_user_last_name varchar(100) NULL, -- Фамилия пользователя последним изменившим запись
	updated_by_user_patronymic_name varchar(100) NULL, -- Отчество пользователя последним изменившим запись
	updated_by_user_phone varchar(50) NULL, -- Телефон пользователя последним изменившим запись
	updated_by_user_email varchar(50) NULL, -- Эл.почта пользователя последним изменившим запись
	updated_by_user_id uuid NULL, -- Идентификатор  пользователя последним изменившим запись
	CONSTRAINT attachment_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE attachment IS 'Вложение в ходатайство';

-- Column comments

COMMENT ON COLUMN attachment.id IS 'Идентификатор';
COMMENT ON COLUMN attachment.created_date IS 'Дата создания';
COMMENT ON COLUMN attachment.last_modified_date IS 'Дата последнего изменения';
COMMENT ON COLUMN attachment.attachment_type IS 'Тип вложения ((SCAN, SIG))';
COMMENT ON COLUMN attachment.content_type IS 'Тип MIME контента';
COMMENT ON COLUMN attachment.deleted IS 'Признак удаленого  вложения';
COMMENT ON COLUMN attachment.length IS 'Размер вложения (байтах)';
COMMENT ON COLUMN attachment."name" IS 'Наименование вложения';
COMMENT ON COLUMN attachment.storage_id IS 'Идентификатор вложения в файловом хранилище';
COMMENT ON COLUMN attachment.extension IS 'Тип расширения вложения';
COMMENT ON COLUMN attachment.created_by_user_first_name IS 'Имя пользователя создавшим запись';
COMMENT ON COLUMN attachment.created_by_user_last_name IS 'Фамилия пользователя создавшим запись';
COMMENT ON COLUMN attachment.created_by_user_patronymic_name IS 'Отчество пользователя создавшим запись';
COMMENT ON COLUMN attachment.created_by_user_phone IS 'Телефон пользователя создавшим запись';
COMMENT ON COLUMN attachment.created_by_user_email IS 'Эл.почта пользователя создавшим запись';
COMMENT ON COLUMN attachment.created_by_user_id IS 'Идентификатор  пользователя создавшим запись';
COMMENT ON COLUMN attachment.updated_by_user_first_name IS 'Имя пользователя последним изменившим запись';
COMMENT ON COLUMN attachment.updated_by_user_last_name IS 'Фамилия пользователя последним изменившим запись';
COMMENT ON COLUMN attachment.updated_by_user_patronymic_name IS 'Отчество пользователя последним изменившим запись';
COMMENT ON COLUMN attachment.updated_by_user_phone IS 'Телефон пользователя последним изменившим запись';
COMMENT ON COLUMN attachment.updated_by_user_email IS 'Эл.почта пользователя последним изменившим запись';
COMMENT ON COLUMN attachment.updated_by_user_id IS 'Идентификатор  пользователя последним изменившим запись';

-- building definition

CREATE TABLE building (
	id uuid NOT NULL, -- Идентификатор
	address varchar(700) NULL, -- Адрес  объекта строительства
	cadastr_number varchar(50) NULL, -- Кадастровый номер объекта
	erpo_number integer NULL, -- Идентификатор объекта  в реестре ЕРПО
	house_number varchar(50) NULL, -- Номер объекта
	object_name varchar(255) NULL, -- Наименование объекта строительства
	developer_inn varchar(12) NOT NULL, -- ИНН застройщика
	sgs_number integer NULL, -- Идентификатор объекта  в реестре ОС
	created_date timestamp NOT NULL, -- Дата создания
	last_modified_date timestamp NULL, -- Дата последнего изменения
	developer_name varchar(255) NOT NULL, -- Наименование застройщика
	developer_short_name varchar(255) NULL, -- Краткое наименование застройщика
	developer_id integer NOT NULL, -- Идентификатор застройщика в реестре затройщиков
	region_code integer NULL, -- Код региона
	status varchar(50) NOT NULL, -- Текущий статус объекта строительства
	documents text default '[]', -- дерево докуметов
	option varchar(100), -- Дополнительный признак
	CONSTRAINT building_sgs_number_un UNIQUE (sgs_number),
	CONSTRAINT building_erpo_number_un UNIQUE (erpo_number),
	CONSTRAINT building_pkey PRIMARY KEY (id)
);
CREATE INDEX building_sgs_number_idx ON building USING btree (sgs_number);
CREATE INDEX building_erpo_number_idx ON building USING btree (erpo_number);
CREATE INDEX building_id_idx ON building USING btree (id);
CREATE INDEX building_developer_id_idx ON building USING btree (developer_id);
CREATE INDEX building_developer_name_idx ON building USING btree (developer_name);
CREATE INDEX building_developer_inn_idx ON building USING btree (developer_inn);
CREATE INDEX building_region_code_idx ON building USING btree (region_code);
CREATE INDEX building_address_idx ON building USING btree (address);
CREATE INDEX building_option_index on building (option);
create INDEX building_erpo_number_varchar_idx on building(CAST(building.erpo_number AS VARCHAR(255)));
create INDEX building_sgs_number_varchar_idx on building(CAST(building.sgs_number AS VARCHAR(255)));

COMMENT ON TABLE building IS 'Объект строительства';

-- Column comments

COMMENT ON COLUMN building.id IS 'Идентификатор';
COMMENT ON COLUMN building.address IS 'Адрес  объекта строительства';
COMMENT ON COLUMN building.cadastr_number IS 'Кадастровый номер объекта';
COMMENT ON COLUMN building.erpo_number IS 'Идентификатор объекта  в реестре ЕРПО';
COMMENT ON COLUMN building.house_number IS 'Номер объекта';
COMMENT ON COLUMN building.object_name IS 'Наименование объекта строительства';
COMMENT ON COLUMN building.developer_inn IS 'ИНН застройщика';
COMMENT ON COLUMN building.sgs_number IS 'Идентификатор объекта  в реестре ОС';
COMMENT ON COLUMN building.created_date IS 'Дата создания';
COMMENT ON COLUMN building.last_modified_date IS 'Дата последнего изменения';
COMMENT ON COLUMN building.developer_name IS 'Наименование застройщика';
COMMENT ON COLUMN building.developer_short_name IS 'Краткое наименование застройщика';
COMMENT ON COLUMN building.developer_id IS 'Идентификатор застройщика в реестре затройщиков';
COMMENT ON COLUMN building.region_code IS 'Код региона';
COMMENT ON COLUMN building.status IS 'Текущий статус объекта строительства';
COMMENT ON COLUMN building.option IS 'Дополнительный признак';
COMMENT ON COLUMN building.documents IS 'Дерево докуметов';

-- petition definition

CREATE TABLE petition (
	id uuid NOT NULL, -- Идентификатор
	created_date timestamp NOT NULL, -- Дата создания
	last_modified_date timestamp NULL, -- Дата последнего изменения
	deleted bool NULL DEFAULT false, -- Признак удаления ходатайства
	external_id varchar(255) NULL, -- Идентификатор документа во внешней системе
	"source" varchar(255) NULL, -- Источник, где создан документ
	petition_type varchar(255) NULL, -- Тип ходатайства
	petition_number varchar(64) NULL, -- Исходящий номер  ходатайства
	petition_date date NULL, -- Дата ходатайства
	scan_attachment_id uuid NULL, -- Идентификатор вложения скана ходатайства
	sig_attachment_id uuid NULL, -- Идентификатор вложения КЭП ходатайства
	send_date timestamp NULL, -- Дата отправки ходатайства в CRM
	region_code int4 NULL, -- Код региона
	created_by_user_first_name varchar(100) NULL, -- Имя пользователя создавшим запись
	created_by_user_last_name varchar(100) NULL, -- Фамилия пользователя создавшим запись
	created_by_user_patronymic_name varchar(100) NULL, -- Отчество пользователя создавшим запись
	created_by_user_phone varchar(50) NULL, -- Телефон пользователя создавшим запись
	created_by_user_email varchar(50) NULL, -- Эл.почта пользователя создавшим запись
	created_by_user_id uuid NULL, -- Идентификатор  пользователя создавшим запись
	updated_by_user_first_name varchar(100) NULL, -- Имя пользователя последним изменившим запись
	updated_by_user_last_name varchar(100) NULL, -- Фамилия пользователя последним изменившим запись
	updated_by_user_patronymic_name varchar(100) NULL, -- Отчество пользователя последним изменившим запись
	updated_by_user_phone varchar(50) NULL, -- Телефон пользователя последним изменившим запись
	updated_by_user_email varchar(50) NULL, -- Эл.почта пользователя последним изменившим запись
	updated_by_user_id uuid NULL, -- Идентификатор  пользователя последним изменившим запись
	status varchar(50) NOT NULL, -- Текущий статус ходатайства
	CONSTRAINT petition_pkey PRIMARY KEY (id),
	CONSTRAINT fk_petition_scan_attachment FOREIGN KEY (scan_attachment_id) REFERENCES attachment(id),
	CONSTRAINT fk_petition_sig_attachment FOREIGN KEY (sig_attachment_id) REFERENCES attachment(id)
);
CREATE INDEX petition_external_id_idx ON petition USING btree (external_id);
CREATE INDEX petition_petition_date_idx ON petition USING btree (petition_date);
CREATE INDEX petition_petition_number_idx ON petition USING btree (petition_number);
CREATE INDEX petition_petition_type_idx ON petition USING btree (petition_type);
COMMENT ON TABLE petition IS 'Ходатайства';

-- Column comments

COMMENT ON COLUMN petition.id IS 'Идентификатор';
COMMENT ON COLUMN petition.created_date IS 'Дата создания';
COMMENT ON COLUMN petition.last_modified_date IS 'Дата последнего изменения';
COMMENT ON COLUMN petition.deleted IS 'Признак удаления ходатайства';
COMMENT ON COLUMN petition.external_id IS 'Идентификатор документа во внешней системе';
COMMENT ON COLUMN petition."source" IS 'Источник, где создан документ';
COMMENT ON COLUMN petition.petition_type IS 'Тип ходатайства';
COMMENT ON COLUMN petition.petition_number IS 'Исходящий номер  ходатайства';
COMMENT ON COLUMN petition.petition_date IS 'Дата ходатайства';
COMMENT ON COLUMN petition.scan_attachment_id IS 'Идентификатор вложения скана ходатайства';
COMMENT ON COLUMN petition.sig_attachment_id IS 'Идентификатор вложения КЭП ходатайства';
COMMENT ON COLUMN petition.send_date IS 'Дата отправки ходатайства в CRM';
COMMENT ON COLUMN petition.region_code IS 'Код региона';
COMMENT ON COLUMN petition.created_by_user_first_name IS 'Имя пользователя создавшим запись';
COMMENT ON COLUMN petition.created_by_user_last_name IS 'Фамилия пользователя создавшим запись';
COMMENT ON COLUMN petition.created_by_user_patronymic_name IS 'Отчество пользователя создавшим запись';
COMMENT ON COLUMN petition.created_by_user_phone IS 'Телефон пользователя создавшим запись';
COMMENT ON COLUMN petition.created_by_user_email IS 'Эл.почта пользователя создавшим запись';
COMMENT ON COLUMN petition.created_by_user_id IS 'Идентификатор  пользователя создавшим запись';
COMMENT ON COLUMN petition.updated_by_user_first_name IS 'Имя пользователя последним изменившим запись';
COMMENT ON COLUMN petition.updated_by_user_last_name IS 'Фамилия пользователя последним изменившим запись';
COMMENT ON COLUMN petition.updated_by_user_patronymic_name IS 'Отчество пользователя последним изменившим запись';
COMMENT ON COLUMN petition.updated_by_user_phone IS 'Телефон пользователя последним изменившим запись';
COMMENT ON COLUMN petition.updated_by_user_email IS 'Эл.почта пользователя последним изменившим запись';
COMMENT ON COLUMN petition.updated_by_user_id IS 'Идентификатор  пользователя последним изменившим запись';
COMMENT ON COLUMN petition.status IS 'Текущий статус ходатайства';

-- petition_building definition

CREATE TABLE petition_building (
	id uuid NOT NULL, -- Идентификатор
	petition_id uuid NOT NULL, -- Идентификатор ходатайства
	building_id uuid NOT NULL, -- Идентификатор ОС
	created_date timestamp NOT NULL, -- Дата создания
	last_modified_date timestamp NULL, -- Дата последнего изменения
	victim_persons_amount int4 NULL, -- Количество граждан, чьи права были нарушены
	CONSTRAINT fk_petition_building_building FOREIGN KEY (building_id) REFERENCES building(id),
	CONSTRAINT fk_petition_building_petition FOREIGN KEY (petition_id) REFERENCES petition(id)
);
CREATE UNIQUE INDEX petition_building_petition_id_idx ON petition_building USING btree (petition_id, building_id);
COMMENT ON TABLE petition_building IS 'Связь Ходатайство и ОС';

-- Column comments

COMMENT ON COLUMN petition_building.petition_id IS 'Идентификатор ходатайства';
COMMENT ON COLUMN petition_building.building_id IS 'Идентификатор ОС';
COMMENT ON COLUMN petition_building.created_date IS 'Дата создания';
COMMENT ON COLUMN petition_building.last_modified_date IS 'Дата последнего изменения';
COMMENT ON COLUMN petition_building.victim_persons_amount IS 'Количество граждан, чьи права были нарушены';

CREATE TABLE petition_document (
	id uuid NOT NULL, -- Идентификатор
	petition_id uuid NOT NULL, -- Идентификатор ходатайства
	attachment_id uuid NOT NULL, -- Идентификатор вложения
	document_type varchar(255) NULL, -- Тип документа
	CONSTRAINT petition_document_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE petition_document IS 'Документы ходатайства';

-- Column comments

COMMENT ON COLUMN petition_document.id IS 'Идентификатор';
COMMENT ON COLUMN petition_document.petition_id IS 'Идентификатор ходатайства';
COMMENT ON COLUMN petition_document.attachment_id IS 'Идентификатор вложения';
COMMENT ON COLUMN petition_document.document_type IS 'Тип документа';

CREATE INDEX etition_document_petition_id_idx ON petition_document USING btree (petition_id);

CREATE TABLE status_history (
	status_source varchar(50) NULL, -- Исходный статус
	id uuid NOT NULL, -- Идентификатор
	status_target varchar(50) NULL, -- Целевой статус
	"comment" varchar(700) NULL, -- Текст комментария ответственного лица из CRM
	petition_id uuid NULL, -- Идентификактор Ходатайства
	user_id uuid NULL, -- Идентификактор пользователя
	change_status_date timestamp NULL, -- Дата изменения статуса
	building_id uuid NULL, -- Идентификатор объекта строительства
	"type" varchar(50) NOT NULL, -- Тип статуса
	user_first_name varchar(255) NULL, -- ФИО ответственного лица из CRM
	user_phone varchar(50) NULL, -- Номер телефона ответственного лица  из CRM
	user_email varchar(50) NULL, -- Адрес электронной почты ответственного лица  из CRM
	user_last_name varchar(255) NULL, -- ФИО ответственного лица из CRM
	user_patronymic_name varchar(255) NULL, -- ФИО ответственного лица из CRM
	CONSTRAINT status_pkey PRIMARY KEY (id),
	CONSTRAINT fk_status_history_building FOREIGN KEY (building_id) REFERENCES building(id),
	CONSTRAINT fk_status_history_petition FOREIGN KEY (petition_id) REFERENCES petition(id)
);
CREATE INDEX status_history_building_id_idx ON status_history USING btree (building_id, type);
CREATE INDEX status_history_petition_id_idx ON status_history USING btree (petition_id, type);
COMMENT ON TABLE status_history IS 'История изменения статуса';

-- Column comments

COMMENT ON COLUMN status_history.status_source IS 'Исходный статус';
COMMENT ON COLUMN status_history.id IS 'Идентификатор';
COMMENT ON COLUMN status_history.status_target IS 'Целевой статус';
COMMENT ON COLUMN status_history."comment" IS 'Текст комментария ответственного лица из CRM';
COMMENT ON COLUMN status_history.petition_id IS 'Идентификактор Ходатайства';
COMMENT ON COLUMN status_history.user_id IS 'Идентификактор пользователя';
COMMENT ON COLUMN status_history.change_status_date IS 'Дата изменения статуса';
COMMENT ON COLUMN status_history.building_id IS 'Идентификатор объекта строительства';
COMMENT ON COLUMN status_history."type" IS 'Тип статуса';
COMMENT ON COLUMN status_history.user_first_name IS 'ФИО ответственного лица из CRM';
COMMENT ON COLUMN status_history.user_phone IS 'Номер телефона ответственного лица  из CRM';
COMMENT ON COLUMN status_history.user_email IS 'Адрес электронной почты ответственного лица  из CRM';
COMMENT ON COLUMN status_history.user_last_name IS 'ФИО ответственного лица из CRM';
COMMENT ON COLUMN status_history.user_patronymic_name IS 'ФИО ответственного лица из CRM';


CREATE TABLE IF NOT EXISTS sgs_building (
	id uuid NOT NULL, -- Идентификатор
	address varchar(700) NULL, -- Адрес  объекта строительства
	erpo_number varchar(50) NULL, -- Идентификатор объекта  в реестре ЕРПО
	house_number varchar(50) NULL, -- Номер объекта
	developer_inn varchar(12) NOT NULL, -- ИНН застройщика
	sgs_number varchar(50) NULL, -- Идентификатор объекта  в реестре ОС
	created_date timestamp NOT NULL, -- Дата создания
	last_modified_date timestamp NULL, -- Дата последнего изменения
	developer_name varchar(255) NOT NULL, -- Наименование застройщика
	developer_short_name varchar(255) NULL, -- Краткое наименование застройщика
	developer_id integer NOT NULL, -- Идентификатор застройщика в реестре затройщиков
	region_code int4 NULL, -- Код региона
	status varchar(50) NULL, -- Текущий статус объекта строительства
	building_payload jsonb,
	CONSTRAINT sgs_building_pkey PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS sgs_building_sgs_number_idx ON sgs_building USING btree (sgs_number);
CREATE INDEX IF NOT EXISTS sgs_building_erpo_number_idx ON sgs_building USING btree (erpo_number);
CREATE INDEX IF NOT EXISTS sgs_building_address_idx ON sgs_building USING btree (address);
CREATE INDEX IF NOT EXISTS sgs_building_id_idx ON sgs_building USING btree (id);
CREATE INDEX IF NOT EXISTS sgs_building_developer_id_idx ON sgs_building USING btree (developer_id);
CREATE INDEX IF NOT EXISTS sgs_building_developer_name_idx ON sgs_building USING btree (developer_name);
CREATE INDEX IF NOT EXISTS sgs_building_developer_inn_idx ON sgs_building USING btree (developer_inn);
CREATE INDEX IF NOT EXISTS sgs_building_region_code_idx ON sgs_building USING btree (region_code);
COMMENT ON TABLE sgs_building IS 'Объект строительства из СЖС';

COMMENT ON COLUMN sgs_building.id IS 'Идентификатор';
COMMENT ON COLUMN sgs_building.address IS 'Адрес  объекта строительства';
COMMENT ON COLUMN sgs_building.erpo_number IS 'Идентификатор объекта  в реестре ЕРПО';
COMMENT ON COLUMN sgs_building.house_number IS 'Номер объекта';
COMMENT ON COLUMN sgs_building.developer_inn IS 'ИНН застройщика';
COMMENT ON COLUMN sgs_building.sgs_number IS 'Идентификатор объекта  в реестре ОС';
COMMENT ON COLUMN sgs_building.created_date IS 'Дата создания';
COMMENT ON COLUMN sgs_building.last_modified_date IS 'Дата последнего изменения';
COMMENT ON COLUMN sgs_building.developer_name IS 'Наименование застройщика';
COMMENT ON COLUMN sgs_building.developer_short_name IS 'Краткое наименование застройщика';
COMMENT ON COLUMN sgs_building.developer_id IS 'Идентификатор застройщика в реестре затройщиков';
COMMENT ON COLUMN sgs_building.region_code IS 'Код региона';
COMMENT ON COLUMN sgs_building.status IS 'Текущий статус объекта строительства';
COMMENT ON COLUMN sgs_building.building_payload IS 'Объект строительства оригинальный';
