UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-27 13:10:00',`end_time`='2018-03-27 13:11:00' WHERE `application_id`='1';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-27 13:12:00', `end_time`='2018-03-27 13:13:00' WHERE `application_id`='2';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-27 13:14:00', `end_time`='2018-03-27 13:15:00' WHERE `application_id`='3';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-27 14:06:00', `end_time`='2018-03-27 14:07:00' WHERE `application_id`='4';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-27 14:08:00', `end_time`='2018-03-27 18:30:00' WHERE `application_id`='5';
UPDATE `wts_db`.`wts_app_tab` SET `start_time`='2018-03-27 12:06:00', `end_time`='2018-03-27 19:06:00' WHERE `application_id`='6';

delete from wts_db.wts_trans_tab;
commit;

delete from wts_db.wts_new_eta_tab;
commit;


UPDATE `wts_db`.`wts_process_tab` SET `expected_start_time`='2018-03-29 04:00:00', `expected_end_time`='2018-03-29 04:07:00' WHERE `process_id`='1';
UPDATE `wts_db`.`wts_process_tab` SET `expected_start_time`='2018-03-29 04:07:00', `expected_end_time`='2018-03-29 04:15:00' WHERE `process_id`='2'; 

commit;
