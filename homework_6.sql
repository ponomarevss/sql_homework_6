/*
1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

DELIMITER $$
CREATE FUNCTION sec_formatter(sec INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE res VARCHAR(255) DEFAULT '';
    DECLARE d INT DEFAULT 0;
    DECLARE h INT DEFAULT 0;
    DECLARE m INT DEFAULT 0;
	
    IF sec < 0 THEN
		RETURN 'illegal argument';
	END IF;
    
    SET d = sec DIV (60 * 60 * 24);
    SET sec = sec % (60 * 60 * 24);
    SET h = sec DIV (60 * 60);
    SET sec = sec % (60 * 60);
    SET m = sec DIV 60;
    SET sec = sec % 60;
    
    SET res = CONCAT(d, ' days ', h, ' hours ', m, ' minutes ', sec, ' seconds');
    
	RETURN res;
END $$
DELIMITER ;

SELECT sec_formatter(123456);

/*
2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/

DELIMITER $$
CREATE PROCEDURE show_even(n INT)
BEGIN
	DECLARE res VARCHAR(255) DEFAULT '';
	DECLARE val INT DEFAULT 2;
    
    IF n < 2 THEN
		SELECT 'Illegal argument. set argument greater than 1.';
	ELSE
		WHILE val <= n DO
			IF val = 2 THEN
				SET res = val;
			ELSE
				SET res = CONCAT(res, ',', val);
			END IF;
			SET val = val + 2;
		END WHILE;
        SELECT res;
	END IF;
END $$
DELIMITER ;

CALL show_even(10);