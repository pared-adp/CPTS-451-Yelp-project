CREATE TABLE User (
	user_id CHAR,
	user_name VARCHAR(50),
	user_stars DECIMAL(3,2),
  	user_yelp_since DATE,
  	user_num_of_fans INTEGAR,
	PRIMARY KEY (user_id) 
);

CREATE TABLE Friend (
	friend_name VARCHAR(50),
	friend_stars DECIMAL(3,2),
	friend_yelp_since DATE,
	PRIMARY KEY (friend_name),
	FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Review (
	review_author CHAR,
	review_id INTEGAR,
	review_contents VARCHAR(200),
	review_date DATE,
	review_rating DECIMAL(3,2),
	PRIMARY KEY (review_id)
);

CREATE TABLE Votes (
	votes_funny INTEGER,
	votes_Cool INTEGER,
	votes_Useful INTEGER,
	FOREIGN KEY (user_id) REFERENCES User(user_id),
	FOREIGN KEY (review_id) REFERENCES Review(review_id)
);

CREATE TABLE Business (
	busi_id CHAR,
	busi_name VARCHAR(50),
	busi_stars DECIMAL(3,2),
	busi_num_of_review INTEGER,
	busi_avg_rating DECIMAL(3,2),
	busi_state VARCHAR(20),
	busi_city VARCHAR(30),
	PRIMARY KEY (busi_id)
);

CREATE TABLE Zipcode (
	zip_population INTEGER,
	zip_avg_income INTEGER,
	zip_total_num_of_busi INTEGER,
	PRIMARY KEY (zip_avg_income),
	FOREIGN KEY (busi_id) REFERENCES Business(busi_id)
);

CREATE TABLE Overpriced (
	over_name VARCHAR(50),
	over_price_range INTEGER,
	over_num_of_checkin INTEGER,
	PRIMARY KEY (over_name),
	FOREIGN KEY (zip_avg_income) REFERENCES Zipcode(zip_avg_income)
);

CREATE TABLE Popular (
	pop_name VARCHAR(50),
	pop_stars DECIMAL(3,2),
	pop_review_rating DECIMAL(3,2),
	pop_num_of_review INTEGER,
	PRIMARY KEY (pop_name),
	FOREIGN KEY (zip_avg_income) REFERENCES Zipcode(zip_avg_income)
);

CREATE TABLE Successful (
	suc_name VARCHAR(50),
	suc_num_of_review INTEGER,
	suc_num_of_checkin INTEGER,
	PRIMARY KEY (suc_name),
	FOREIGN KEY (zip_avg_income) REFERENCES Zipcode(zip_avg_income)
);

CREATE TABLE Category (
	cat_name VARCHAR(50),
	PRIMARY KEY (cat_name),
	FOREIGN KEY (busi_id) REFERENCES Business(busi_id)
);

CREATE TABLE Reviews (
	review_id CHAR(11),
	friend_name VARCHAR(50),
	user_id CHAR,
	busi_id CHAR,
	PRIMARY KEY (review_id,friend_name,user_id,busi_id),
	FOREIGN KEY (review_id) REFERENCES Review(review_id),
	FOREIGN KEY (friend_name) REFERENCES Friend(name),
	FOREIGN KEY (user_id) REFERENCES User(user_id),
	FOREIGN KEY (busi_id) REFERENCES Business(business_id)
);

CREATE TABLE Rates (
	busi_id CHAR,
	user_id CHAR,
	PRIMARY KEY (busi_id,user_id),
	FOREIGN KEY (busi_id) REFERENCES Business(busi_id),
	FOREIGN KEY (user_id) REFERENCES User(user_id)
);

