DROP DATABASE WTS_DB;
CREATE DATABASE WTS_DB;

use WTS_DB;


create table  WTS_process_tab(
   process_id INTEGER NOT NULL AUTO_INCREMENT,
   sequence INTEGER NOT NULL,
   expected_start_time TIMESTAMP,
   expected_end_time TIMESTAMP,
   comments VARCHAR(200) ,
   last_update_time TIMESTAMP,
   name varchar(50) NOT NULL,
   weight INTEGER,
   enable_flag boolean,
   PRIMARY KEY (process_id)
);


create table WTS_Trig_tab
(
   trig_id INTEGER NOT NULL AUTO_INCREMENT,
   expected_start_time time,
   expected_end_time time,
   host VARCHAR(100) NOT NULL,
   port VARCHAR(30) DEFAULT "23" ,
   trigger_file VARCHAR(100) NOT NULL,
   trigger_file_path VARCHAR(100) NOT NULL,
   last_update_time TIMESTAMP,
   comments VARCHAR(200) NOT NULL,
   enable_flag boolean default true,
   PRIMARY KEY (trig_id)
 );
 

create table  WTS_app_tab(
   application_id INTEGER NOT NULL AUTO_INCREMENT,
   name VARCHAR(50) NOT NULL,
   comments VARCHAR(100),
   enable_flag boolean default true,
   last_update_time TIMESTAMP,
   PRIMARY KEY (application_id)
); 


create table  WTS_process_app_map_tab(
   process_app_map_id INTEGER NOT NULL AUTO_INCREMENT,
   process_id INTEGER NOT NULL,
   application_id INTEGER NOT NULL,
   name VARCHAR(50) NOT NULL,
   sequence INTEGER NOT NULL,
   trig_id INTEGER NOT NULL,
   comments VARCHAR(100),
   weight INTEGER,
   start_time timestamp,
   end_time timestamp,
   buffer_minute_time integer,
   email_id varchar(200),
   support_contact numeric(20),
   enable_flag boolean default true,
   last_update_time TIMESTAMP,
   PRIMARY KEY (process_app_map_id),
   CONSTRAINT UC_proc_app_mapping_tab UNIQUE (process_id,application_id),
   FOREIGN KEY (process_id) REFERENCES WTS_process_tab(process_id),
   FOREIGN KEY (application_id) REFERENCES WTS_app_tab(application_id),
   FOREIGN KEY (trig_id) REFERENCES WTS_Trig_tab(trig_id)
); 



create table  WTS_app_mapping_tab(
   app_mapping_id INTEGER NOT NULL AUTO_INCREMENT,
   process_id INTEGER NOT NULL,
   parent_id INTEGER NOT NULL,
   child_id INTEGER NOT NULL,
   name VARCHAR(50) NOT NULL,
   sequence INTEGER NOT NULL,
   trig_id INTEGER NOT NULL,
   comments VARCHAR(100),
   weight INTEGER,
   start_time timestamp,
   end_time timestamp,
   buffer_minute_time integer,
   email_id varchar(200),
   support_contact numeric(20),
   enable_flag boolean default true,
   last_update_time TIMESTAMP,
   PRIMARY KEY (app_mapping_id),
   CONSTRAINT UC_app_mapping_tab UNIQUE (parent_id,child_id),
   FOREIGN KEY (parent_id) REFERENCES WTS_app_tab(application_id),
   FOREIGN KEY (child_id) REFERENCES WTS_app_tab(application_id),
   FOREIGN KEY (trig_id) REFERENCES WTS_Trig_tab(trig_id)
); 


 


create table wts_status_tab
(
status_id INTEGER NOT NULL,
name varchar(50) NOT NULL,
PRIMARY KEY (status_id)
); 

create table WTS_Trans_tab(
 transaction_id INTEGER NOT NULL AUTO_INCREMENT,
 event_date VARCHAR(20) ,
 process_id INTEGER ,
 application_id INTEGER ,
 parent_id INTEGER ,
 child_id INTEGER ,
 start_transaction TIMESTAMP NULL,
 end_transaction TIMESTAMP NULL,
 status_id INTEGER not null,
 process_btn_status_id INTEGER,
 app_btn_status_id INTEGER,
 sendemailflag integer default 0,
 sendetaemailflag integer default 0,
 PRIMARY KEY(transaction_id),
 FOREIGN KEY (status_id) REFERENCES wts_status_tab(status_id)
 ); 

create table  WTS_user_tab(
   user_id INTEGER NOT NULL,
   name VARCHAR(100) NOT NULL,
   application_id INTEGER NOT NULL,   
   comments VARCHAR(200) NOT NULL,
	PRIMARY KEY (user_id)
);


 create table wts_new_eta_tab(
 eta_id INTEGER NOT NULL AUTO_INCREMENT,
 event_date VARCHAR(20) ,
 process_id INTEGER ,
 parent_id INTEGER ,
 child_id INTEGER ,
 application_id INTEGER ,
 new_eta_start_transaction TIMESTAMP NULL,
 new_eta_end_transaction TIMESTAMP NULL,
 each_problem_flag boolean default false,
 PRIMARY KEY(eta_id)
 ); 
 
 
insert into WTS_process_tab (process_id,sequence,expected_start_time,
expected_end_time,comments,last_update_time,name,weight,enable_flag)
values(1,1,"2018-02-02  16:07:00","2020-02-03  16:09:00","Process the Forecast & Orders to generate the promise portfolio",
sysdate(),"Process 1",0,1);


insert into WTS_Trig_tab
(trig_id,expected_start_time,expected_end_time,host,port,trigger_file,trigger_file_path,last_update_time,comments)
values(1,"21:10:00","4:00:00","oncspdp2.onc.michelin.com",23,"A2P_TRG","/busdata/ra2p/nca0",sysdate(),"Comment2");


insert into WTS_Trig_tab
(trig_id,expected_start_time,expected_end_time,host,port,trigger_file,trigger_file_path,last_update_time,comments)
values(2,"22:10:00","8:00:00","oncspdp2.onc.michelin.com",23,"PMB_TRG","/busdata/ra2p/nca0",sysdate(),"Comment3");


insert into WTS_Trig_tab
(trig_id,expected_start_time,expected_end_time,host,port,trigger_file,trigger_file_path,last_update_time,comments)
values(3,"22:10:00","8:00:00","oncspdp2.onc.michelin.com",23,"PMB_TRG","/busdata/ra2p/nca0",sysdate(),"Comment2");


insert into WTS_process_tab (process_id,sequence,expected_start_time,
expected_end_time,comments,last_update_time,name,weight,enable_flag)
values(2,2,"2018-03-22  14:45:24","2020-03-24  13:45:43","Order processing",
sysdate(),"Process 2",0,1);


commit;

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(1,"SPD","DummyTExt",sysdate());

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(2,"A2P","DummyTExt",sysdate());

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(3,"PMB","DummyTExt" ,sysdate());

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(4,"EDS","DummyTExt" ,sysdate());

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(5,"DSS","DummyTExt" ,sysdate());

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(6,"SDS","DummyTExt" ,sysdate());


insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(7,"BAT1","SPD_BAT1" ,sysdate());

insert into WTS_app_tab (application_id,name,comments,last_update_time)
values(8,"BAT2","SPD_BAT2" ,sysdate());

COMMIT;

INSERT INTO wts_db.wts_process_app_map_tab (process_app_map_id, process_id, application_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time) VALUES ('1', '1', '1', 'P1-SPD', '1', '1', 'P1-SPD', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate());

INSERT INTO wts_db.wts_process_app_map_tab (process_app_map_id, process_id, application_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time) VALUES ('2', '1', '2', 'P1-A2P', '2', '1', 'P1-A2P', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate());

INSERT INTO wts_db.wts_process_app_map_tab (process_app_map_id, process_id, application_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time) VALUES ('3', '1', '3', 'P1-PMB', '3', '1', 'P1-SPD', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate());


INSERT INTO wts_db.wts_process_app_map_tab (process_app_map_id, process_id, application_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time) VALUES ('4', '2', '4', 'P2-EDS', '1', '1', 'P1-SPD', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate());

INSERT INTO wts_db.wts_process_app_map_tab (process_app_map_id, process_id, application_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time) VALUES ('5', '2', '5', 'P2-DSS', '2', '1', 'P1-A2P', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate());

INSERT INTO wts_db.wts_process_app_map_tab (process_app_map_id, process_id, application_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time) VALUES ('6', '2', '6', 'P2-SDS', '3', '1', 'P1-SPD', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate());

INSERT INTO wts_db.wts_app_mapping_tab (app_mapping_id, parent_id, child_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time,process_id) VALUES ('1', '1', '7', 'SPD_BAT1', '1', '1', 'SPD_BAT1', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate(),'1');

INSERT INTO wts_db.wts_app_mapping_tab (app_mapping_id, parent_id, child_id, name, sequence, trig_id, comments, weight, buffer_minute_time, enable_flag,start_time,end_time,last_update_time,process_id) VALUES ('2', '1', '8', 'SPD_BAT2', '2', '1', 'SPD_BAT2', '0', '1', '1','2018-04-06 20:19:05', '2018-04-06 20:19:05',sysdate(),'1');


create table  WTS_treatment_tab(
   treatment_date varchar(20)
);

commit;


DELETE FROM wts_db.wts_status_tab;
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('0', 'GREY');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('1', 'GREEN');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('2', 'RED');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('3', 'VIOLET');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('4', 'ORANGE');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('5', 'AMBER');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('6', 'LIGHT GREEN');


COMMIT;


UPDATE `wts_db`.`wts_app_tab` SET `name`='SPD_PROCESS_1' WHERE `application_id`='7';
UPDATE `wts_db`.`wts_app_tab` SET `name`='SPD_PROCESS_2' WHERE `application_id`='8';
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('9', 'A2P_PROCESS_1', 'A2P_BAT1', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('10', 'A2P_PROCESS_2', 'A2P_BAT1', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('11', 'PMB_PROCESS_1', 'A2P_BAT1', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('12', 'PMB_PROCESS_2', 'A2P_BAT1', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('13', 'SDS_PROCESS_1', 'A2P_BAT1', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('14', 'SDS_PROCESS_2', 'DUMMY', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('15', 'ERP_PROCESS_1', 'DUMMY', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('16', 'ERP_PROCESS_2', 'DUMMY', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('17', 'DSS_PROCESS_1', 'DUMMY', '1', '2018-04-10 15:04:42');
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('18', 'DSS_PROCESS_2', 'DUMMY', '1', '2018-04-10 15:04:42');






UPDATE `wts_db`.`wts_app_mapping_tab` SET `name`='SPD_PROCESS_1', `comments`='DUMMY' WHERE `app_mapping_id`='1';
UPDATE `wts_db`.`wts_app_mapping_tab` SET `name`='SPD_PROCESS_2', `comments`='DUMMY' WHERE `app_mapping_id`='2';
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('3', '1', '2', '9', 'A2P_PROCESS_1', '1', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('4', '1', '2', '10', 'A2P_PROCESS_2', '2', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('5', '1', '3', '11', 'PMB_PROCESS_1', '1', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('6', '1', '3', '12', 'PMB_PROCESS_2', '2', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('7', '2', '1', '13', 'SDS_PROCESS_1', '1', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('8', '2', '1', '14', 'SDS_PROCESS_2', '2', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('9', '2', '2', '15', 'ERP_PROCESS_1', '1', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('10', '2', '2', '16', 'ERP_PROCESS_2', '2', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('11', '2', '3', '17', 'DSS_PROCESS_1', '1', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');
INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('12', '2', '3', '18', 'DSS_PROCESS_2', '2', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-10 15:04:43');


UPDATE `wts_db`.`wts_app_tab` SET `name`='SDS' WHERE `application_id`='4';
UPDATE `wts_db`.`wts_app_tab` SET `name`='ERP' WHERE `application_id`='5';
UPDATE `wts_db`.`wts_app_tab` SET `name`='DSS' WHERE `application_id`='6';


UPDATE `wts_db`.`wts_app_tab` SET `name`='DSS_PROCESS_1' WHERE `application_id`='18';
INSERT INTO `wts_db`.`wts_app_tab` (`application_id`, `name`, `comments`, `enable_flag`, `last_update_time`) VALUES ('19', 'DSS_PROCESS_2', 'DUMMY', '1', '2018-04-10 15:04:42');
UPDATE `wts_db`.`wts_app_tab` SET `name`='ERP_PROCESS_3' WHERE `application_id`='17';


INSERT INTO `wts_db`.`wts_app_mapping_tab` (`app_mapping_id`, `process_id`, `parent_id`, `child_id`, `name`, `sequence`, `trig_id`, `comments`, `weight`, `start_time`, `end_time`, `buffer_minute_time`, `enable_flag`, `last_update_time`) VALUES ('13', '2', '3', '19', 'DSS_PROCESS_2', '2', '1', 'DUMMY', '0', '2018-04-12 12:05:00', '2018-04-12 12:05:00', '1', '1', '2018-04-12 12:05:00');
UPDATE `wts_db`.`wts_app_mapping_tab` SET `name`='DSS_PROCESS_1', `sequence`='1' WHERE `app_mapping_id`='12';
UPDATE `wts_db`.`wts_app_mapping_tab` SET `parent_id`='2', `name`='ERP_PROCESS_3', `sequence`='3' WHERE `app_mapping_id`='11';










 