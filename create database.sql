-- Preliminaries
DROP   DATABASE IF EXISTS db_orders;
CREATE DATABASE db_orders;
USE    db_orders;

-- Creating the Entities (Tables)

CREATE TABLE customers(
  ID_CUSTOMER     INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record                        
  NAME            VARCHAR(100) NOT NULL,                # NAME OF the customer                
  account_balance  FLOAT,                               # account balance of customer                                   
  directions       TEXT,                                # delivering addresses of customer
  credit_limit     FLOAT,                               # credit limit of customer
  PRIMARY KEY     (ID_CUSTOMER),                         # Make the id the primary key
  check(credit_limit>=1000 and credit_limit<=500000)      # give the boudary of the credit limit
);


CREATE TABLE articles(
  ID_ARTICLE      INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record
  NAME             VARCHAR(100) NOT NULL,                # NAME OF the article
  factory          INT unsigned NOT NULL,                # Name of the factory          
  STOCKLEVEL       FLOAT,                               #  Stock level of the factory
  description      TEXT,                                # description of the article
  PRIMARY KEY     (ID_ARTICLE)                          #  Make the id the primary key                 
);

CREATE TABLE orders (
    ID_ORDERS INT UNSIGNED NOT NULL AUTO_INCREMENT,
    date DATE,
    address TEXT,
    article INT UNSIGNED NOT NULL,
    units INT,
    customer INT UNSIGNED NOT NULL,
    PRIMARY KEY (ID_ORDERS)
);
   
CREATE TABLE factories(
  id_fact         INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record
  NAME            VARCHAR(100) NOT NULL,                # Name of the factory
  website         TEXT,                                 # website of the factory
  ADDRESS         TEXT,                                 # Address of the factory
  PHONE           INT               ,                  # phone number of factory. Integer number
  description     TEXT,                                 # description of the factory
  PRIMARY KEY     (id_fact)                              # Make the id the primary key
);

-- Adding Foreign keys
ALTER TABLE articles   ADD CONSTRAINT FK_articleFactory  FOREIGN KEY (factory) REFERENCES factories(id_fact);
ALTER TABLE orders   ADD CONSTRAINT FK_ordersCustomer  FOREIGN KEY (customer)  REFERENCES customers(ID_CUSTOMER);
ALTER TABLE orders   ADD CONSTRAINT FK_ordersArticle  FOREIGN KEY (article)  REFERENCES articles(ID_ARTICLE);
