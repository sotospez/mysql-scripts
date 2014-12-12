
drop procedure if exists `sotosfreplace`; 
DELIMITER // 
CREATE PROCEDURE `sotosfreplace` (IN var1 VARCHAR(256) ,IN var2 VARCHAR(256) ) 
BEGIN
-- change the database name
-- use 
-- call sotosfreplace('a','b'); 
  DECLARE a,c VARCHAR(256);  
  DECLARE b INT;  
  DECLARE cur1 CURSOR FOR SELECT concat('UPDATE `',table_schema,'`.`',table_name, '` SET `' ,column_name, '`=replace(`',column_name,'`,"', var1, '","',var2,'");') AS s FROM information_schema.columns where table_schema='{databasename}' ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;
  DECLARE CONTINUE HANDLER FOR 1061 SET b = 0;  
  OPEN cur1;  
  SET b = 0;    
  WHILE b = 0 DO  
    FETCH cur1 INTO a;  
    IF b = 0 THEN
      SET @c = a;
       PREPARE stmt1 FROM @c;
      EXECUTE stmt1; 
      DEALLOCATE PREPARE stmt1; 
    END IF;  
  END WHILE;  
  CLOSE cur1;       
END // 
delimiter ;

-- end
