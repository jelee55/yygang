CREATE DATABASE IF NOT EXISTS `yygang_demo_db4` ;
USE `yygang_demo_db4`;


CREATE TABLE IF NOT EXISTS `role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE IF NOT EXISTS `question_board` (
  `qboard_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `qboard_title` varchar(50) NOT NULL,
  `qboard_content` longtext NOT NULL,
  `qboard_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `qboard_mdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`qboard_id`),
  KEY `fk_question_board_user` (`user_id`),
  CONSTRAINT `fk_question_board_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_GENERAL_CI;



CREATE TABLE IF NOT EXISTS `answer` (
  `answer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `qboard_id` bigint(20) NOT NULL,
  `answer_content` longtext NOT NULL,
  `answer_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `answer_mdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `FK_answer_user` (`user_id`),
  KEY `FK_answer_question_board` (`qboard_id`),
  CONSTRAINT `FK_answer_question_board` FOREIGN KEY (`qboard_id`) REFERENCES `question_board` (`qboard_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_answer_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `answer_like` (
  `user_id` bigint(20) NOT NULL,
  `answer_id` bigint(20) NOT NULL,
  KEY `FK_answer_like_user` (`user_id`),
  KEY `FK_answer_like_answer` (`answer_id`),
  CONSTRAINT `FK_answer_like_answer` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`answer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_answer_like_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `n_supplement` (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_name` char(50) NOT NULL,
  `caution` text NOT NULL,
  `brand` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `board` (
  `board_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `board_title` varchar(50) NOT NULL,
  `board_content` longtext NOT NULL,
  `board_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `board_mdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  KEY `fk_board_user` (`user_id`),
  CONSTRAINT `fk_board_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `board_like` (
  `user_id` bigint(20) NOT NULL,
  `board_id` bigint(20) NOT NULL,
  KEY `FK_board_like_user` (`user_id`),
  KEY `FK_board_like_board` (`board_id`),
  CONSTRAINT `FK_board_like_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_board_like_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user` (`user_id`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `cart_option` (
  `cart_option_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cart_id` bigint(20) NOT NULL,
  `products_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`cart_option_id`),
  KEY `fk_cart_option_cart` (`cart_id`),
  KEY `fk_cart_n_supplement` (`products_id`),
  CONSTRAINT `fk_cart_n_supplement` FOREIGN KEY (`products_id`) REFERENCES `n_supplement` (`product_id`),
  CONSTRAINT `fk_cart_option_cart` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `board_id` bigint(20) NOT NULL,
  `comment_content` text NOT NULL,
  `comment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment_mdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `fk_comment_user` (`user_id`),
  KEY `fk_comment_board` (`board_id`),
  CONSTRAINT `fk_comment_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`),
  CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `h_functional_item` (
  `health_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `health_name` varchar(25) NOT NULL,
  PRIMARY KEY (`health_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_GENERAL_CI;



CREATE TABLE IF NOT EXISTS `h_functional_category` (
  `hfunc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `products_id` bigint(20) NOT NULL,
  `health_id` bigint(20) NOT NULL,
  PRIMARY KEY (`hfunc_id`),
  KEY `fk_h_functional_category_n_supplement` (`products_id`),
  KEY `fk_h_functional_category_h_functional_item` (`health_id`),
  CONSTRAINT `fk_h_functional_category_h_functional_item` FOREIGN KEY (`health_id`) REFERENCES `h_functional_item` (`health_id`),
  CONSTRAINT `fk_h_functional_category_n_supplement` FOREIGN KEY (`products_id`) REFERENCES `n_supplement` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `ingredient` (
  `ingredient_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ingredient` varchar(50) NOT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `ingredient_category` (
  `i_category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `products_id` bigint(20) NOT NULL,
  `ingredient_id` bigint(20) NOT NULL,
  PRIMARY KEY (`i_category_id`),
  KEY `fk_ingredient_category_n_supplement` (`products_id`),
  KEY `fk_ingredient_category_ingredient` (`ingredient_id`),
  CONSTRAINT `fk_ingredient_category_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`),
  CONSTRAINT `fk_ingredient_category_n_supplement` FOREIGN KEY (`products_id`) REFERENCES `n_supplement` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `n_question` (
  `question_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `products_id` bigint(20) NOT NULL,
  `q_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `q_content` longtext NOT NULL,
  PRIMARY KEY (`question_id`),
  KEY `FK_n_question_user` (`customer_id`),
  KEY `FK_n_question_n_supplement` (`products_id`),
  CONSTRAINT `FK_n_question_n_supplement` FOREIGN KEY (`products_id`) REFERENCES `n_supplement` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_n_question_user` FOREIGN KEY (`customer_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `n_answer` (
  `answer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `a_content` longtext NOT NULL,
  `a_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`answer_id`),
  KEY `fk_n_answer_question_id` (`question_id`),
  KEY `fk_n_answer_user` (`seller_id`),
  CONSTRAINT `fk_n_answer_question_id` FOREIGN KEY (`question_id`) REFERENCES `n_question` (`question_id`),
  CONSTRAINT `fk_n_answer_user` FOREIGN KEY (`seller_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `order` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `order_status` varchar(10) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`order_id`),
  KEY `fk_order_user` (`user_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `order_option` (
  `order_option_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `products_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`order_option_id`),
  KEY `fk_order_option_n_supplement` (`products_id`),
  KEY `fk_order_option_order_id` (`order_id`),
  CONSTRAINT `fk_order_option_n_supplement` FOREIGN KEY (`products_id`) REFERENCES `n_supplement` (`product_id`),
  CONSTRAINT `fk_order_option_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `pay_method` varchar(255) NOT NULL,
  `total_price` int(11) NOT NULL,
  `pay_status` enum('WAITING','FAIL','SUCCESS') NOT NULL DEFAULT 'WAITING',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`payment_id`),
  KEY `fk_payment_order_id` (`order_id`),
  CONSTRAINT `fk_payment_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `personal_account` (
  `personal_account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `balance` int(11) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  PRIMARY KEY (`personal_account_id`),
  KEY `fk_personal_account_user` (`user_id`),
  CONSTRAINT `fk_personal_account_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `personal_health` (
  `survey_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `content` text DEFAULT NULL,
  `sur_date` timestamp NULL DEFAULT current_timestamp(),
  `sur_complete` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`survey_id`),
  KEY `fk_personal_health_user` (`user_id`),
  CONSTRAINT `fk_personal_health_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE IF NOT EXISTS `review` (
  `review_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `products_id` bigint(20) NOT NULL,
  `content` longtext NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`review_id`),
  KEY `fk_review_user` (`user_id`),
  KEY `fk_review_n_supplement` (`products_id`),
  CONSTRAINT `fk_review_n_supplement` FOREIGN KEY (`products_id`) REFERENCES `n_supplement` (`product_id`),
  CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

