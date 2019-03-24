# -*- coding: utf-8 -*-


import json
import psycopg2
from collections import defaultdict

def executeQuery(sql_str):
    try: 
        conn = psycopg2.connect("dbname='yelpdb' user ='postgres' host='localhost' password='8114'")
    except:
        print("Unable to connect")
    cur = conn.cursor()
    cur.execute(sql_str)
    conn.commit()
    conn.close()
    cur.close()
    
def cleandata(line):
    return line.replace("'", "`").replace("\n", " ")

def recursive_parse(dictionary):
    bus_attr = defaultdict(str)
    for key,value in dictionary.items():        
        if isinstance(value, dict):
            recursive_parse(value)
        else:            
           bus_attr[key] = value
    return bus_attr
def addSin(string):
    ''''
    In order to insert into database you need single quotes for the values,
    this adds the quotes to the insert values
    '''
    
    newString = "'" + string + "'"
    return newString
def test1(list1):
    return str(list1).replace('[','').replace(']','')
def parse_business(): 
    '''
    this would be used to populate business, category tables
    '''#complete for business table, still need to do category can't figure out how to get around apostrphes.  
    infile1=open("yelp_business.JSON", "r")
    #outfile1=open("business.txt", "w")
    line=infile1.readline() 
    i = 0
    while line:
        data=json.loads(line)
        BI = addSin(cleandata(data['business_id'])+'\t')
        BName = addSin(cleandata(data['name'])+'\t')
        BAdress = addSin(cleandata(data['address'])+'\t')
        BState = addSin(cleandata(data['state'])+'\t')
        BCity = addSin(cleandata(data['city'])+'\t')
        BPostal = addSin(cleandata(data['postal_code'])+'\t')
        BStars = addSin(str(data['stars'])+'\t')
        BRevCount = addSin(str(data['review_count'])+'\t')
        BOpen = addSin(str(data['is_open'])+'\t')
        Bcat = str([item for item in data['categories']])+'\t'
        sql = "INSERT INTO business (busi_id, name, busi_stars, busi_num_of_review, state, city, busaddress, buspostal, busopen) VALUES ("+ BI +","+ BName +","+ BStars +","+ BRevCount +","+ BState +","+ BCity +","+BAdress +","+BPostal+","+BOpen +");"
        executeQuery(sql)
        #test = test1(Bcat)
       
#        for cat in test.split(','):
#            if cat[0] = '"'
#                
#            #newcat = cat.strip('"')
#            #sql2 = "INSERT INTO category (cat_name, busi_id) VALUES ("+ newcat+ "," + BI +");"
#            #executeQuery(sql2)
        
#        test = recursive_parse(data['attributes'])
#        test_att = defaultdict(str)
        
        #outfile1.write('\n')
        line=infile1.readline()
    
        
    infile1.close()
    #outfile1.close()
    return 

def parse_review():
    '''
    this is used to insert the parse data into the reviews, review, votes , and rates tables
    '''
    infile2=open("yelp_review.JSON", "r")
    #outfile2=open("review.txt", "w")
    line=infile2.readline()
    while line:
        data=json.loads(line)
        RId = addSin(cleandata(data['review_id'])+'\t')
        UId = addSin(cleandata(data['user_id'])+'\t')
        BID = addSin(cleandata(data['business_id'])+'\t')
        Stars = addSin(str(data['stars'])+'\t')
        RDate = addSin(cleandata(data['date'])+'\t')
        RText = addSin(str(data['text'])+'\t')
        RUse = addSin(str(data['useful'])+'\t')
        Rfun = addSin(str(data['funny'])+'\t')
        Rcool = addSin(str(data['cool'])+'\t')
        #outfile2.write('\n')
        line=infile2.readline()
        sql = "INSERT INTO review (review_id, review_contents, review_date, review_rating) VALUES ("+ RId +","+ RText+","+ RDate+","+ Stars +");"
        sql2 = "INSERT INTO review (review_id, user_id, busi_id) VALUES ("+ RId +","+ UId+","+ busi_id+");"
        
        executeQuery(sql)
        executeQuery(sql2)
    infile2.close()
    #outfile2.close()
    return

def parse_user():
    
    '''
    this is used for the users and friends table
    '''# this is complete for the friends table
    infile3=open("yelp_user.JSON", "r")
    outfile3=open("user.txt", "w")  
    line=infile3.readline()
    uFriends = []
    while line:
        data=json.loads(line)
        AStars = addSin(str(data['average_stars'])+'\t')
        uCool = addSin(str(data['cool'])+'\t')
        uFans = addSin(str(data['fans'])+'\t')
        uFriends = str([item for item in data['friends']])+'\t'
        uFun = addSin(str(data['funny'])+'\t')
        uName = addSin(cleandata(data['name'])+'\t')
        uRevCount = addSin(str(data['review_count'])+'\t')
        uUse = addSin(str(data['useful'])+'\t')
        uID = addSin(str(data['user_id'])+'\t')
        uYelpSin = addSin(cleandata(data['yelping_since'])+'\t')
        line=infile3.readline()
        test = test1(uFriends)
        for item in test.split(","):
            print(item)
        #outfile3.write('\n')
        #sql = "INSERT INTO users (user_id, user_name, user_stars, user_yelp_since, user_num_of_fans) VALUES ("+ uID +","+ uName +","+ AStars + ","+ uYelpSin +","+ uFans +");"
        #executeQuery(sql)
    #print(len(uFriends))
    return
'''
Not sure how to calculate the popularity and overpriced tables
need to write update sql function for num of checkins 
'''
#        
#def parse_checkin():
#    infile4=open("yelp_checkin.JSON", "r")
#    outfile4=open("checkin.txt", "w")
#    line=infile4.readline()
#    while line:
#        data=json.loads(line)
#        recursive_parse(data['time'], outfile4)
#        outfile4.write(str(data['business_id']))
#        line=infile4.readline()
#        outfile4.write('\n')
#    
#    infile4.close()
#    outfile4.close()
#    return
#    
#parse_business()
#parse_review()
parse_user()
#parse_checkin()
#    