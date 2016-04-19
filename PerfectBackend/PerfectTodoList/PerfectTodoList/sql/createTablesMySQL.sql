
USE PerfectTodoList;

 CREATE TABLE `Status` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 CREATE TABLE `Task` (
    `completed` BIT,
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `order` INT(10),
    `title` VARCHAR(255),
    `todo_id` bigint(20) NOT NULL,
    KEY `FK1461108813531` (`todo_id`),
    CONSTRAINT `FK1461108813531` FOREIGN KEY (`todo_id`) REFERENCES `TodoItem` (`id`),
    PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 CREATE TABLE `TodoItem` (
    `dueDate` Date,
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `notes` VARCHAR(255),
    `status_id` bigint(20) NOT NULL,
    `tasks_id` bigint(20) NOT NULL,
    `title` VARCHAR(255),
    KEY `FK1461108813560` (`status_id`),
    CONSTRAINT `FK1461108813560` FOREIGN KEY (`status_id`) REFERENCES `Status` (`id`),
    KEY `FK1461108813560` (`tasks_id`),
    CONSTRAINT `FK1461108813560` FOREIGN KEY (`tasks_id`) REFERENCES `Task` (`id`),
    PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 

