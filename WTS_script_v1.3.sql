DROP DATABASE WTS_DB;
CREATE DATABASE WTS_DB;

use WTS_DB;


create table  WTS_process_tab(
   process_id INTEGER NOT NULL,
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
   trig_id INTEGER NOT NULL,
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
   application_id INTEGER NOT NULL,
   name VARCHAR(50) NOT NULL,
   process_id INTEGER NOT NULL,
   sequence INTEGER NOT NULL,
   trig_id INTEGER NOT NULL,
   comments VARCHAR(100),
   weight INTEGER,
   enable_flag boolean default true,
   last_update_time TIMESTAMP,
   PRIMARY KEY (application_id),
   FOREIGN KEY (process_id) REFERENCES WTS_process_tab(process_id),
   FOREIGN KEY (trig_id) REFERENCES WTS_Trig_tab(trig_id)
); 

 create table WTS_batch_tab(
   batch_id INTEGER NOT NULL,
   application_id INTEGER NOT NULL,
   name VARCHAR(200) NOT NULL,
   UOT VARCHAR(50) NOT NULL,
   process_id INTEGER NOT NULL,
   sequence INTEGER NOT NULL,
   trig_id INTEGER NOT NULL,
   weight INTEGER,
   enable_flag boolean default true,
   comments VARCHAR(200) NOT NULL,
   last_update_time TIMESTAMP,
	PRIMARY KEY (batch_id),
	FOREIGN KEY (process_id) REFERENCES WTS_process_tab(process_id),
	FOREIGN KEY (application_id) REFERENCES WTS_app_tab(application_id),
   FOREIGN KEY (trig_id) REFERENCES WTS_Trig_tab(trig_id)
); 

 


create table WTS_status
(
status_id INTEGER NOT NULL,
name varchar(50) NOT NULL,
PRIMARY KEY (status_id)
); 

create table WTS_Trans_tab(
 transaction_id INTEGER NOT NULL AUTO_INCREMENT,
 event_date VARCHAR(20) ,
 process_id INTEGER ,
 batch_id INTEGER ,
 application_id INTEGER ,
 start_transaction TIMESTAMP NULL,
 end_transaction TIMESTAMP NULL,
 status_id INTEGER not null,
 PRIMARY KEY(transaction_id),
 FOREIGN KEY (status_id) REFERENCES WTS_status(status_id)
 ); 

create table  WTS_user_tab(
   user_id INTEGER NOT NULL,
   name VARCHAR(100) NOT NULL,
   application_id INTEGER NOT NULL,   
   comments VARCHAR(200) NOT NULL,
	PRIMARY KEY (user_id)
);



insert into wts_status(status_id,NAME) values(1,"GREEN"); 

insert into wts_status(status_id,NAME) values(2,"RED");

insert into wts_status(status_id,NAME) values(3,"GREY"); 
 

 
insert into WTS_process_tab (process_id,sequence,expected_start_time,
expected_end_time,comments,last_update_time,name,weight,enable_flag)
values(1,1,"2018-02-02  00:00:00","2020-02-02  00:00:00","Process the Forecast & Orders to generate the promise portfolio",
sysdate(),"Order Promiser",0,1);


insert into WTS_Trig_tab
(trig_id,expected_start_time,expected_end_time,host,port,trigger_file,trigger_file_path,last_update_time,comments)
values(1,"21:10:00","4:00:00","oncspdp2.onc.michelin.com",23,"A2P_TRG","/busdata/ra2p/nca0",sysdate(),"Comment2");


insert into WTS_Trig_tab
(trig_id,expected_start_time,expected_end_time,host,port,trigger_file,trigger_file_path,last_update_time,comments)
values(2,"22:10:00","8:00:00","oncspdp2.onc.michelin.com",23,"PMB_TRG","/busdata/ra2p/nca0",sysdate(),"Comment3");


insert into WTS_Trig_tab
(trig_id,expected_start_time,expected_end_time,host,port,trigger_file,trigger_file_path,last_update_time,comments)
values(3,"22:10:00","8:00:00","oncspdp2.onc.michelin.com",23,"PMB_TRG","/busdata/ra2p/nca0",sysdate(),"Comment2");

insert into WTS_app_tab (application_id,name,sequence,process_id,trig_id,comments,weight,last_update_time)
values(1,"SupplyPlanDeployment",1,1,1,"DummyTExt",0,sysdate());

insert into WTS_app_tab (application_id,name,sequence,process_id,trig_id,comments,weight,last_update_time)
values(2,"A2P",2,1,2,"DummyTXt",0,sysdate());

insert into WTS_app_tab (application_id,name,sequence,process_id,trig_id,comments,weight,last_update_time)
values(3,"PMB",3,1,2,"DummyTXt",0,sysdate());

insert into wts_db.wts_process_tab (process_id,sequence,expected_start_time,
expected_end_time,comments,last_update_time,name,weight,enable_flag)
values(2,1,"2018-02-02  00:00:00","2020-02-02  00:00:00","Process the Forecast & Orders to generate the promise portfolio",
sysdate(),"Order Promiser",0,true);


COMMIT;

alter table wts_app_tab add column transaction_id Integer;
alter table wts_app_tab
add  foreign key (transaction_id) references wts_db.wts_trans_tab(transaction_id);

RENAME TABLE wts_status to wts_status_tab;

alter table wts_db.wts_app_tab
add column start_time timestamp;

alter table wts_db.wts_app_tab
add column end_time timestamp;



create table  WTS_treatment_tab(
   treatment_date date
);

commit;


UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-08 07:20:00', `end_time`='2018-03-08 07:25:00' WHERE `application_id`='1';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-08 07:30:00', `end_time`='2018-03-07 07:35:00' WHERE `application_id`='2';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-08 07:40:00', `end_time`='2018-03-07 07:45:00' WHERE `application_id`='3';


DELETE FROM wts_db.wts_status_tab;
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('0', 'GREY');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('1', 'GREEN');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('2', 'RED');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('3', 'VIOLET');
INSERT INTO wts_db.wts_status_tab (status_id, name) VALUES ('4', 'ORANGE');

COMMIT;