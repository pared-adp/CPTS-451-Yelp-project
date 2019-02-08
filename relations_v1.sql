CREATE TABLE User (
	user_ID CHAR,
	user_name VARCHAR(50),
	user_stars DECIMAL(3,2),
  	user_yelp_since DATE,
  	user_num_of_fans INTEGAR,
	PRIMARY KEY (user_ID) 
);

CREATE TABLE Friend (
	friend_name VARCHAR(50),
	friend_stars DECIMAL(3,2),
	friend_yelp_since DATE,
	PRIMARY KEY (friend_name)
	FOREIGN KEY (user_ID) REFERENCES User(user_ID)
);

CREATE TABLE Votes (
	votes_funny INTEGER,
	votes_Cool INTEGER,
	votes_Useful INTEGER,
	FOREIGN KEY (user_ID) REFERENCES User(user_ID)
	FOREIGN KEY (review_ID) REFERENCES Review(review_ID)
);
