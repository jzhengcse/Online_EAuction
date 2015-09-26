
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE database IF NOT EXISTS Eauction;
USE Eauction ;

drop table user,individual,company,item,bid,watch;
-- -----------------------------------------------------
-- Table `E-Auction`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS User (
	EmailAddress	char(60) not null,
	Password		char(30) not null,
	AccountType     char(30) not null,
	FirstName		char(20) not null,
	MiddleName		char(20),
	LastName		char(20) not null,
	Membership		char(30),
	Street			char(30),
	City			char(30),
	State			char(30),
	ZipCode			char(30),
	Phone			char(30),
	CreditNum		char(16),
	CreditType		char(30),
	CreditCVN		char(30),
	CreditExpire	date,	
	primary key    (emailaddress));

-- -----------------------------------------------------
-- Table `E-Auction`.`Individual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Individual (
	EmailAddress	char(60) not null,
	Age				INT,
	Gender			CHAR(20),
	AnnualIncome	DOUBLE,
	Birthday		DATE,
	primary key    (emailaddress));


-- -----------------------------------------------------
-- Table `E-Auction`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Company (
	EmailAddress	char(60) not null,
	PointofContact	CHAR(60),
	CompanyCategory CHAR(20),
	Revenue			DOUBLE,
	CompanyName		CHAR(60),
	primary key    (emailaddress));


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
	EmailAddress	char(60) not null,
    ItemID INT auto_increment,
    WinnerID char(60),
    HighestBidPrice DOUBLE default 0,
	Name CHAR(100) NOT NULL,
    Quantity INT,
    Discount DOUBLE,
	CategoryID INT NOT NULL,
	URL VARCHAR(10000),
    Description VARCHAR(1000),
	Picture CHAR(100),
	ReservePrice DOUBLE,
    IsBuyItNow TINYINT(1),
	BuyItNowPrice DOUBLE NOT NULL default 0,
	EndTime DATETIME,
	Street CHAR(100),
	City CHAR(100),
	State CHAR(100),
    IsVoid TINYINT(1),
	Watch int default 0,
	Bid int default 0,
    Rating DOUBLE,
    Comments VARCHAR(10000),
    PRIMARY KEY (ItemID),
    FOREIGN KEY (emailaddress) REFERENCES User (emailaddress)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    INDEX (emailaddress));

-- -----------------------------------------------------
-- Table `E-Auction`.`Bid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Bid (
	EmailAddress	char(60) not null,
	ItemID INT NOT NULL,
	BidPrice DOUBLE NOT NULL,
	BidTime DATETIME NOT NULL,
	PRIMARY KEY (emailaddress, ItemID,bidprice),
    FOREIGN KEY (emailaddress) REFERENCES User (emailaddress)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
    FOREIGN KEY (ItemID) REFERENCES Item (ItemID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION);
create table if not exists watch (
	EmailAddress	char(60) not null,
	ItemID INT NOT NULL,
	PRIMARY KEY (emailaddress, ItemID),
    FOREIGN KEY (emailaddress) REFERENCES User (emailaddress)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
    FOREIGN KEY (ItemID) REFERENCES Item (ItemID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION);
	


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `user` 
( Password, AccountType, `FirstName`, `LastName`, `Membership`, `EmailAddress`,Street, City, State, ZipCode, Phone, CreditNum, CreditType, CreditCVN, CreditExpire ) 
VALUES ('123','Individual','Yang', 'Meng',  '5', 'yang@psu.edu','Fraser St','State College','PA','16801','8149999999','1431142342135345','Vista','123','2016-03-21');

INSERT INTO `user` 
(Password,AccountType, `FirstName`, `LastName`, `Membership`, `EmailAddress`,Street, City, State, ZipCode, Phone, CreditNum, CreditType, CreditCVN, CreditExpire ) 
VALUES ('123','Individual','Xianlian', 'Zhang', '5', 'xianliang@psu.edu','Fraser St','State College','PA','16801','8149999998','1431142342135346','Master','124','2016-03-21');

INSERT INTO `user` 
(Password, AccountType,`FirstName`, `LastName`, `Membership`, `EmailAddress`,Street, City, State, ZipCode, Phone, CreditNum, CreditType, CreditCVN, CreditExpire ) 
VALUES ('123', 'Company','Sobe', 'Kaushal',  '5', 'sobe@psu.edu','Fraser St','State College','PA','16801','8149999997','1431142342135347','Vista','125','2016-03-21');

INSERT INTO `individual` 
(`emailaddress`, `Age`, `Gender`, `AnnualIncome`,birthday) 
VALUES ('yang@psu.edu', '18', 'Male', '100000','1993-01-01');

INSERT INTO `individual` 
(`emailaddress`, `Age`, `Gender`, `AnnualIncome`,birthday) 
VALUES ('xianliang@psu.edu', '19', 'Male', '999999','1992-01-01');

INSERT INTO `company` 
(`emailaddress`, `PointofContact`, `CompanyCategory`, `Revenue`, `CompanyName`) 
VALUES ('sobe@psu.edu', 'Sobe', 'Shoes', '999999', 'SobeShoes');

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
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu', 1,'Q5',11,'item.jsp?itemid=1','The 2014 Audi Q5 is a true multi-tasker offering luxury, handling and utility all at once. The Q5 features available advanced technologies, including Audi drive select and Audi connect® with Wi-Fi hotspot.', 'images/1.jpg', 50000, 1,55000, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID, Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu',  2,'MacBook Air',31,'item.jsp?itemid=2','It\'s just 0.68 inch thin and weighs as little as 2.38 pounds. But a sturdy aluminum unibody design makes MacBook Air tough and durable, too.', 'images/2.jpg', 1200, 1,1250, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu', 3,'MacBook Pro',31,'item.jsp?itemid=3','A groundbreaking Retina display. All-flash architecture. The latest Intel processors. Remarkably thin and light 13inch and 15inch designs. Together, these features take the notebook to a place it\'s never been.', 'images/3.jpg', 1400, 1,1499, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu', 4,'iMac',31,'item.jsp?itemid=4','Sit down in front of an iMac and something incredible happens: The world around you seems to disappear, and you lose yourself in the big, beautiful display.', 'images/4.jpg', 1500, 1,1600, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu', 5,'iPad Air',31,'item.jsp?itemid=5','The new iPad Air is unbelievably thin and light. And yet it\'s so much more powerful and capable. With the A7 chip, advanced wireless, and great apps for productivity and creativity, all beautifully integrated with iOS 7, iPad Air lets you do more than you ever imagined. In more places than you ever imagined.', 'images/5.jpg', 350, 1,480, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu', 6,'iPhone5s',42,'item.jsp?itemid=6','iPhone 5s is purposefully imagined. Meticulously considered. Precision crafted. It\'s not just a product of what\'s technologically possible. But what\'s technologically useful. It\'s not just what\'s next. But what should be next.', 'images/6.jpg', 160, 1,199, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu',7, 'iPhone5c',42,'item.jsp?itemid=7','iPhone 5c, in five anything-but-shy colors, does just that. It\'s not just for lovers of color. It\'s for the colorful.', 'images/7.jpg', 80, 1,99, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu',8, 'Samsung Galaxy S5',42,'item.jsp?itemid=8','Meaningful rewards from the world\'s top brands to make your GALAXY S5 experience even more enjoyable and productive. The Samsung GALAXY S5 comes with free, long-term subscriptions and premium services.', 'images/8.jpg', 150, 1,180, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES (1, 9,'Samsung Note 3',42,'item.jsp?itemid=9','The Samsung Galaxy Note® 3 is stunning from every angle. An all-new, thinner, lightweight design makes the Galaxy Note 3 even easier to carry, while its new stitched cover keeps your device protected.', 'images/9.jpg', 150, 1,180, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu',10, 'Breaking Bad',34,'item.jsp?itemid=10','Breaking Bad follows protagonist Walter White (Bryan Cranston), a chemistry teacher who lives in New Mexico with his wife (Anna Gunn) and teenage son (RJ Mitte) who has cerebral palsy.', 'images/10.jpg', 20, 1,30, 'College Avenue','State College','PA', 0 );
INSERT INTO Item
(emailaddress,ItemID,Name,CategoryID,URL,Description,Picture,ReservePrice,IsBuyItNow,BuyItNowPrice,Street,City,State,IsVoid) 
VALUES ('sobe@psu.edu', 11,'Call of Duty: Ghosts',8,'item.jsp?itemid=11','Call of Duty®: Ghosts is an extraordinary step forward for one of the largest entertainment franchises of all-time.', 'images/11.jpg', 30, 1,40, 'College Avenue','State College','PA', 0 );


update item set endtime=now()+interval 2 hour;





INSERT INTO `bid` (`emailaddress`, `ItemID`, `BidPrice`, `BidTime`) VALUES ('sobe@psu.edu', '1', '50000', '2014-4-1 12:00:00');
INSERT INTO `bid` (`emailaddress`, `ItemID`, `BidPrice`, `BidTime`) VALUES ('sobe@psu.edu', '2', '1000', '2014-4-1 12:00:00');
INSERT INTO `bid` (`emailaddress`, `ItemID`, `BidPrice`, `BidTime`) VALUES ('sobe@psu.edu', '2', '1100', '2014-4-1 12:00:00');
insert into watch (emailaddress, itemid) values ('sobe@psu.edu','1');
insert into watch (emailaddress, itemid) values ('sobe@psu.edu','2');
insert into watch (emailaddress, itemid) values ('sobe@psu.edu','3');
