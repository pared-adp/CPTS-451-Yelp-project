# -*- coding: utf-8 -*-


import json
def cleandata(line):
    return line.replace("'", "`").replace("\n", " ")

def recursive_parse(dictionary, outfile):
    for key,value in dictionary.items():        
        if isinstance(value, dict):
            recursive_parse(value, outfile)
        else:            
           outfile.write("%s " %str(value))
            
def parse_business():    
    infile1=open("data\yelp_business.JSON", "r")
    outfile1=open("business.txt", "w")
    line=infile1.readline()
    while line:
        data=json.loads(line)
        outfile1.write(cleandata(data['business_id'])+'\t')
        outfile1.write(cleandata(data['name'])+'\t')
        outfile1.write(cleandata(data['address'])+'\t')
        outfile1.write(cleandata(data['state'])+'\t')
        outfile1.write(cleandata(data['city'])+'\t')
        outfile1.write(cleandata(data['postal_code'])+'\t')
        outfile1.write(str(data['stars'])+'\t')
        outfile1.write(str(data['review_count'])+'\t')
        outfile1.write(str(data['is_open'])+'\t')
        outfile1.write(str([item for item in data['categories']])+'\t')
        recursive_parse(data['attributes'], outfile1)
        outfile1.write('\n')
        line=infile1.readline()
    
    infile1.close()
    outfile1.close()
    return

def parse_review():
    infile2=open("data\yelp_review.JSON", "r")
    outfile2=open("review.txt", "w")
    line=infile2.readline()
    while line:
        data=json.loads(line)
        outfile2.write(cleandata(data['review_id'])+'\t')
        outfile2.write(cleandata(data['user_id'])+'\t')
        outfile2.write(cleandata(data['business_id'])+'\t')
        outfile2.write(str(data['stars'])+'\t')
        outfile2.write(cleandata(data['date'])+'\t')
        outfile2.write(str(data['text'])+'\t')
        outfile2.write(str(data['useful'])+'\t')
        outfile2.write(str(data['funny'])+'\t')
        outfile2.write(str(data['cool'])+'\t')
        outfile2.write('\n')
        line=infile2.readline()
    
    infile2.close()
    outfile2.close()
    return

def parse_user():
    infile3=open("data\yelp_user.JSON", "r")
    outfile3=open("user.txt", "w")  
    line=infile3.readline()
    while line:
        data=json.loads(line)
        outfile3.write(str(data['average_stars'])+'\t')
        outfile3.write(str(data['cool'])+'\t')
        outfile3.write(str(data['fans'])+'\t')
        outfile3.write(str([item for item in data['friends']])+'\t')
        outfile3.write(str(data['funny'])+'\t')
        outfile3.write(cleandata(data['name'])+'\t')
        outfile3.write(str(data['review_count'])+'\t')
        outfile3.write(str(data['useful'])+'\t')
        outfile3.write(str(data['user_id'])+'\t')
        outfile3.write(cleandata(data['yelping_since'])+'\t')
        line=infile3.readline()
        outfile3.write('\n')
    
    infile3.close()
    outfile3.close()
    return
        
def parse_checkin():
    infile4=open("data\yelp_checkin.JSON", "r")
    outfile4=open("checkin.txt", "w")
    line=infile4.readline()
    while line:
        data=json.loads(line)
        recursive_parse(data['time'], outfile4)
        outfile4.write(str(data['business_id']))
        line=infile4.readline()
        outfile4.write('\n')
    
    infile4.close()
    outfile4.close()
    return
    
parse_business()
parse_review()
parse_user()
parse_checkin()
    