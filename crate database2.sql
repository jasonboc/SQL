-- Preliminaries
DROP   DATABASE IF EXISTS db_sales;
CREATE DATABASE db_sales;
USE    db_sales;

-- Creating the Entities (Tables)
CREATE TABLE providers(
  id              INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record
  NAME            VARCHAR(100) NOT NULL,                # Name of the continent
  ADDRESS         TEXT,                                 # Address of the provider 
  PHONE           INT               ,                # phone number of provider. Integer number
  PRIMARY KEY     (id)                                  # Make the id the primary key
);


CREATE TABLE customers (
    ID_CUSTOMER INT UNSIGNED NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    USERNAME VARCHAR(100) NOT NULL,
    PASSWORD TEXT,
    PHONE INT,
    ADDRESS TEXT,
    DESCRIPTION TEXT,
    PRIMARY KEY (ID_CUSTOMER)
);


CREATE TABLE products(
  ID_PRODUCT      INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record                         
  NAME            VARCHAR(100) NOT NULL,                # Name of the product               
  PRICE           FLOAT,                                # Updated daily price                 
  STOCK           VARCHAR(100) NOT NULL,                #  Stock available
  provider        INT unsigned NOT NULL,                # provider of the product
  category        INT unsigned NOT NULL,                # category of the product
  PRIMARY KEY     (ID_PRODUCT)                          #  Make the id the primary key                 
);


CREATE TABLE categories(
  id_categories   INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record   
  report          TEXT,                                 # report for the category
  PRIMARY KEY     (id_categories)                       # Make the id the primary key
);

CREATE TABLE transactions(
   ID_transactions  INT unsigned NOT NULL AUTO_INCREMENT, # Unique ID for the record  
   date             DATE,                                  # date of the transaction
   discount         Float,                                # Discount of the transaction
   amount_paid      Float,                                # revenue of transaction
   units            INT,                                  # Units of each product
   price            FLOAT,                                # Price at the day of transaction
   customer         INT unsigned NOT NULL,                 # client in the transaction
   product          INT unsigned NOT NULL,                 # product in the transaction
   PRIMARY KEY     (ID_transactions)                      # Make the id the primary key
   );

-- Adding Foreign keys
ALTER TABLE products   ADD CONSTRAINT FK_prodcutsProvider  FOREIGN KEY (provider) REFERENCES providers(id);
ALTER TABLE products   ADD CONSTRAINT FK_productsCategory  FOREIGN KEY (category)  REFERENCES categories(id_categories);
ALTER TABLE transactions  ADD CONSTRAINT FK_transactionsCustomer  FOREIGN KEY (customer)  REFERENCES customers(ID_CUSTOMER);
ALTER TABLE transactions   ADD CONSTRAINT FK_transactionsProduct  FOREIGN KEY (product)  REFERENCES products(ID_PRODUCT);
