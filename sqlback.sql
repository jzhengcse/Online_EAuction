
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE database IF NOT EXISTS Eauction;
USE Eauction ;

-- -----------------------------------------------------
-- Table `E-Auction`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS User (
	UserID			int not null auto_increment,
	Password		char(30) not null,
	AccountType     char(30) not null,
	FirstName		char(20) not null,
	MiddleName		char(20),
	LastName		char(20) not null,
	Membership		char(30),
	EmailAddress	char(60) not null,
	Street			char(30),
	City			char(30),
	State			char(30),
	ZipCode			char(30),
	Phone			char(30),
	CreditNum		char(16),
	CreditType		char(30),
	CreditCVN		char(30),
	CreditExpire	date,	
	unique index    (emailaddress),
	PRIMARY KEY		(UserID));

-- -----------------------------------------------------
-- Table `E-Auction`.`Individual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Individual (
	UserID			INT NOT NULL,
	Age				INT,
	Gender			CHAR(20),
	AnnualIncome	DOUBLE,
	Birthday		DATE,
	PRIMARY KEY		(UserID));


-- -----------------------------------------------------
-- Table `E-Auction`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Company (
	UserID			INT NOT NULL,
	PointofContact	CHAR(60),
	CompanyCategory CHAR(20),
	Revenue			DOUBLE,
	CompanyName		CHAR(60),
	PRIMARY KEY		(UserID));


-- -----------------------------------------------------
-- Table `E-Auction`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Category (
	CategoryID      INT NOT NULL auto_increment,
	ParentID		int not null,
	Name			VARCHAR(100) NOT NULL,
	PRIMARY KEY		(CategoryID));

-- -----------------------------------------------------
-- Table `E-Auction`.`Sell_Auction`
    /*WinnerID INT NULL,
    HighestBidPrice DOUBLE NULL,
    IsOver TINYINT(1) NULL,*/
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Item (
    UserID INT NOT NULL,
    ItemID INT NOT NULL auto_increment,
	Name CHAR(100) NOT NULL,
    Quantity INT NULL,
    Discount DOUBLE NULL,
	CategoryID INT NOT NULL,
	URL VARCHAR(10000) NULL,
    Description VARCHAR(1000) NULL,
	Picture CHAR(100) NULL,
	ReservePrice DOUBLE NOT NULL,
    IsBuyItNow TINYINT(1) NULL,
	BuyItNowPrice DOUBLE NOT NULL,
	Street CHAR(100) NULL,
	City CHAR(100) NULL,
	State CHAR(100) NULL,
    IsVoid TINYINT(1) NULL,
    Rating DOUBLE NULL,
    Comments VARCHAR(10000) NULL,
    PRIMARY KEY (ItemID),
    FOREIGN KEY (UserID) REFERENCES User (UserID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    INDEX UserID_idx (UserID ASC));

-- -----------------------------------------------------
-- Table `E-Auction`.`Bid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Bid (
	BidderID INT NOT NULL,
	ItemID INT NOT NULL,
	BidPrice DOUBLE NOT NULL,
	BidTime DATETIME NOT NULL,
	PRIMARY KEY (BidderID, ItemID),
    FOREIGN KEY (BidderID) REFERENCES User (UserID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
    FOREIGN KEY (ItemID) REFERENCES Item (ItemID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `user` 
(`UserID`, Password, AccountType, `FirstName`, `LastName`, `Membership`, `EmailAddress`,Street, City, State, ZipCode, Phone, CreditNum, CreditType, CreditCVN, CreditExpire ) 
VALUES ('1', '123','Individual','Yang', 'Meng',  '5', 'yang@psu.edu','Fraser St','State College','PA','16801','8149999999','1431142342135345','Vista','123','2016-03-21');

INSERT INTO `user` 
(`UserID`, Password,AccountType, `FirstName`, `LastName`, `Membership`, `EmailAddress`,Street, City, State, ZipCode, Phone, CreditNum, CreditType, CreditCVN, CreditExpire ) 
VALUES ('2', '123','Individual','Xianlian', 'Zhang', '5', 'xianliang@psu.edu','Fraser St','State College','PA','16801','8149999998','1431142342135346','Master','124','2016-03-21');

INSERT INTO `user` 
(`UserID`, Password, AccountType,`FirstName`, `LastName`, `Membership`, `EmailAddress`,Street, City, State, ZipCode, Phone, CreditNum, CreditType, CreditCVN, CreditExpire ) 
VALUES ('3','123', 'Company','Sobe', 'Kaushal',  '5', 'sobe@psu.edu','Fraser St','State College','PA','16801','8149999997','1431142342135347','Vista','125','2016-03-21');

INSERT INTO `individual` 
(`UserID`, `Age`, `Gender`, `AnnualIncome`,birthday) 
VALUES ('1', '18', 'Male', '100000','1993-01-01');

INSERT INTO `individual` 
(`UserID`, `Age`, `Gender`, `AnnualIncome`,birthday) 
VALUES ('2', '19', 'Male', '999999','1992-01-01');

INSERT INTO `company` 
(`UserID`, `PointofContact`, `CompanyCategory`, `Revenue`, `CompanyName`) 
VALUES ('3', 'Sobe', 'Shoes', '999999', 'SobeShoes');

INSERT INTO `category` (ParentID,`Name`) VALUES (0,'Automotive and Industrial');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Books');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Clothing, Shoes and Jewelry');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Electronics and Computers');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Health and Beauty');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Groceries');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Home, Garden and Tools');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Movies, Music and Games');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Sports and Outdoors ');
INSERT INTO `category` (ParentID,`Name`) VALUES (0, 'Toys, Kids and Baby');


INSERT INTO `category` (ParentID,`Name`) VALUES (4, 'Electronics');
INSERT INTO `category` (ParentID,`Name`) VALUES (4, 'Computers');
INSERT INTO `category` (ParentID,`Name`) VALUES (4, 'Cell Phones');

INSERT INTO `category` (ParentID,`Name`) VALUES (12, 'Desktop');
INSERT INTO `category` (ParentID,`Name`) VALUES (12, 'Laptops');


INSERT INTO `category` (ParentID,`Name`) VALUES (8, 'Movie');
INSERT INTO `category` (ParentID,`Name`) VALUES (8, 'Music');
INSERT INTO `category` (ParentID,`Name`) VALUES (8, 'Game');

INSERT INTO `category` (ParentID,`Name`) VALUES (15, 'Kids and Family');
INSERT INTO `category` (ParentID,`Name`) VALUES (15, 'Comedy');


select UserID,ItemID,Name,CategoryID,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid
from item;

INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 1,'Q5',11,'The 2014 Audi Q5 is a true multi-tasker offering luxury, handling and utility all at once. The Q5 features available advanced technologies, including Audi drive select and Audi connect® with Wi-Fi hotspot.', 'images/1.jpg', 50000, 1,55000, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 2,'MacBook Air',31,'It\'s just 0.68 inch thin and weighs as little as 2.38 pounds. But a sturdy aluminum unibody design makes MacBook Air tough and durable, too.', 'images/2.jpg', 1200, 1,1250, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 3,'MacBook Pro',31,'A groundbreaking Retina display. All-flash architecture. The latest Intel processors. Remarkably thin and light 13inch and 15inch designs. Together, these features take the notebook to a place it\'s never been.', 'images/3.jpg', 1400, 1,1499, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 4,'iMac',31,'Sit down in front of an iMac and something incredible happens: The world around you seems to disappear, and you lose yourself in the big, beautiful display.', 'images/4.jpg', 1500, 1,1600, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 5,'iPad Air',31,'The new iPad Air is unbelievably thin and light. And yet it\'s so much more powerful and capable. With the A7 chip, advanced wireless, and great apps for productivity and creativity, all beautifully integrated with iOS 7, iPad Air lets you do more than you ever imagined. In more places than you ever imagined.', 'images/5.jpg', 350, 1,480, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 6,'iPhone5s',42,'iPhone 5s is purposefully imagined. Meticulously considered. Precision crafted. It\'s not just a product of what\'s technologically possible. But what\'s technologically useful. It\'s not just what\'s next. But what should be next.', 'images/6.jpg', 160, 1,199, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1,7, 'iPhone5c',42,'iPhone 5c, in five anything-but-shy colors, does just that. It\'s not just for lovers of color. It\'s for the colorful.', 'images/7.jpg', 80, 1,99, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1,8, 'Samsung Galaxy S5',42,'Meaningful rewards from the world\'s top brands to make your GALAXY S5 experience even more enjoyable and productive. The Samsung GALAXY S5 comes with free, long-term subscriptions and premium services.', 'images/8.jpg', 150, 1,180, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 9,'Samsung Note 3',42,'The Samsung Galaxy Note® 3 is stunning from every angle. An all-new, thinner, lightweight design makes the Galaxy Note 3 even easier to carry, while its new stitched cover keeps your device protected.', 'images/9.jpg', 150, 1,180, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1,10, 'Breaking Bad',34,'Breaking Bad follows protagonist Walter White (Bryan Cranston), a chemistry teacher who lives in New Mexico with his wife (Anna Gunn) and teenage son (RJ Mitte) who has cerebral palsy.', 'images/10.jpg', 20, 1,30, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(UserID,ItemID,Name,CategoryID,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 11,'Call of Duty: Ghosts',8,'Call of Duty®: Ghosts is an extraordinary step forward for one of the largest entertainment franchises of all-time.', 'images/11.jpg', 30, 1,40, 'College Avenue','State College','PA', 0 );



INSERT INTO `bid` (`BidderID`, `ItemID`, `BidPrice`, `BidTime`) VALUES ('2', '1', '50000', '2014-4-1 12:00:00');
INSERT INTO `bid` (`BidderID`, `ItemID`, `BidPrice`, `BidTime`) VALUES ('1', '2', '1000', '2014-4-1 12:00:00');
INSERT INTO `bid` (`BidderID`, `ItemID`, `BidPrice`, `BidTime`) VALUES ('3', '2', '1100', '2014-4-1 12:00:00');

