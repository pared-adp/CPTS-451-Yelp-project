CREATE TABLE Friend (
	friend_name VARCHAR(50),
	friend_stars DECIMAL(3,2),
	friend_yelp_since DATE,
	PRIMARY KEY (friend_name)

CREATE TABLE User (
	user_ID CHAR,
	user_name VARCHAR(50),
	user_stars DECIMAL(3,2),
  	user_yelp_since DATE,
  	user_num_of_fans INTEGAR,
	PRIMARY KEY (user_ID) 
);
CREATE TABLE Review(
	review_author CHAR,
	review_id INTEGAR,
	review_contents VARCHAR(200),
	review_date DATE,
	review_rating DECIMAL(3,2),
	PRIMARY KEY(review_id)
	
);

