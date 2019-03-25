CREATE TABLE Users (
	user_id CHAR(100),
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
	friend_id CHAR(100),
	PRIMARY KEY (friend_name),
	FOREIGN KEY (friend_id) REFERENCES User(user_id)
);

CREATE TABLE Review (
	review_author CHAR(100),
	review_id CHAR(100),
	review_contents VARCHAR(200),
	review_date DATE,
	review_rating DECIMAL(3,2),
	votes_funny INTEGER,
	votes_cool INTEGER,
	votes_useful INTEGER,
	PRIMARY KEY (review_id)
);


CREATE TABLE Business (
	busi_id CHAR(60),
	busi_name VARCHAR(50),
	busi_stars DECIMAL(3,2),
	busi_num_of_review INTEGER,
	busi_avg_rating DECIMAL(3,2),
	busi_state VARCHAR(20),
	busi_city VARCHAR(30),
	numcheckin INTEGER,
	busaddress VARCHAR(200),
	buspostal CHAR(10) UNIQUE,
	busopen VARCHAR(200),
	PRIMARY KEY (busi_id)
);

CREATE TABLE Zipcode (
	buspostal CHAR(10),
	busi_id CHAR(60),
	zip_population INTEGER,
	zip_avg_income INTEGER UNIQUE,
	zip_total_num_of_busi INTEGER,
	PRIMARY KEY (buspostal, busi_id),
	FOREIGN KEY (buspostal) REFERENCES Business(buspostal),
	FOREIGN KEY (busi_id) REFERENCES Business(busi_id)
);

CREATE TABLE Overpriced (
	over_name VARCHAR(50),
	over_price_range INTEGER,
	over_num_of_checkin INTEGER,
	zip_avg_income INTEGER,
	PRIMARY KEY (over_name),
	FOREIGN KEY (zip_avg_income) REFERENCES Zipcode(zip_avg_income)
);

CREATE TABLE Popular (
	pop_name VARCHAR(50),
	pop_stars DECIMAL(3,2),
	pop_review_rating DECIMAL(3,2),
	pop_num_of_review INTEGER,
	zip_avg_income INTEGER,
	PRIMARY KEY (pop_name),
	FOREIGN KEY (zip_avg_income) REFERENCES Zipcode(zip_avg_income)
);

CREATE TABLE Successful (
	suc_name VARCHAR(50),
	suc_num_of_review INTEGER,
	suc_num_of_checkin INTEGER,
	zip_avg_income INTEGER,
	PRIMARY KEY (suc_name),
	FOREIGN KEY (zip_avg_income) REFERENCES Zipcode(zip_avg_income)
);



CREATE TABLE Reviews (
	review_id CHAR(100),
	user_id CHAR(100),
	busi_id CHAR(60),
	PRIMARY KEY (review_id,user_id, busi_id),
	FOREIGN KEY (review_id) REFERENCES Review(review_id),
	FOREIGN KEY (user_id) REFERENCES Users(user_id),
	FOREIGN KEY (busi_id) REFERENCES Business(busi_id)
);

CREATE TABLE Votes (
	votes_funny INTEGER,
	votes_Cool INTEGER,
	votes_Useful INTEGER,
	FOREIGN KEY (user_id) REFERENCES User(user_id),
	FOREIGN KEY (review_id) REFERENCES Review(review_id)
);
