# -*- coding: utf-8 -*-
"""

@author: Angelina
"""

import sys
from PyQt5.QtWidgets import QMainWindow, QApplication, QWidget, QAction, QTableWidget,QTableWidgetItem,QVBoxLayout
from PyQt5 import uic, QtCore
from PyQt5.QtGui import QIcon, QPixmap
import psycopg2

qtCreatorFile = "milestoneUI.ui" # Enter file here.

Ui_MainWindow, QtBaseClass = uic.loadUiType(qtCreatorFile)

class milestone1(QMainWindow):
    def __init__(self):
        super(milestone1, self).__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.loadStateList()
        self.loadCatList()
        self.loadZipList()
        self.ui.stateList.currentTextChanged.connect(self.stateChanged)
        self.ui.cityList.itemSelectionChanged.connect(self.cityChanged)
        self.ui.catList.currentTextChanged.connect(self.catChanged)
        self.ui.zipList.currentTextChanged.connect(self.displayTotalBus)
        self.ui.zipList.currentTextChanged.connect(self.displayTotalPop)
        self.ui.zipList.currentTextChanged.connect(self.displayAvgIncome)
        self.ui.bname.textChanged.connect(self.getBusinessNames)
        self.ui.businesses.itemSelectionChanged.connect(self.displayBusinessCity)

    def executeQuery(self, sql_str):
        try: 
            conn = psycopg2.connect("dbname='yelpdb' user ='postgres' host='localhost' password='8114'")
        except:
            print("Unable to connect")
        cur = conn.cursor()
        cur.execute(sql_str)
        result = cur.fetchall()
        conn.close()
        return result
    def loadStateList(self):
        self.ui.stateList.clear()
        sql_str = "SELECT distinct state FROM business ORDER BY state"
        try:
            results = self.executeQuery(sql_str)
            for row in results:
                self.ui.stateList.addItem(row[0])
        except:
            print("Query Failed")
        self.ui.stateList.setCurrentIndex(-1)
        self.ui.stateList.clearEditText()
    
    def stateChanged(self):
        self.ui.cityList.clear()
        if (self.ui.stateList.currentIndex()>=0):
            state = self.ui.stateList.currentText()
            sql_str = "SELECT distinct city FROM business WHERE state ='" + state + "' ORDER BY city;"
            #sql_str2 ="SELECT distinct buspostal FROM business WHERE state ='" + state + "' ORDER BY buspostal;"
            try:
                results = self.executeQuery(sql_str)
                for row in results:
                    self.ui.cityList.addItem(row[0])
            except:
                print("Query Failed!")
            
            for i in reversed(range(self.ui.businessTable.rowCount())):
                self.ui.businessTable.removeRow(i)
            sql_str = "SELECT name, city, state, buspostal FROM business WHERE state ='" + state + "' ORDER BY name;"
            try:
                results = self.executeQuery(sql_str)
                style = ":: section(""background-color: #f3f3f3; )"
                self.ui.businessTable.horizontalHeader().setStyleSheet(style)
                self.ui.businessTable.setColumnCount(len(results[0]))
                self.ui.businessTable.setRowCount(len(results))
                self.ui.businessTable.setHorizontalHeaderLabels(['Business Name', 'City', 'State', 'Zip Code'])
                self.ui.businessTable.resizeColumnsToContents()
                self.ui.businessTable.setColumnWidth(0,300)
                self.ui.businessTable.setColumnWidth(1,100)
                self.ui.businessTable.setColumnWidth(2, 50)
                
                currentRowCount = 0
                for row in results:
                    for colCount in range(0,len(results[0])):
                        self.ui.businessTable.setItem(currentRowCount,colCount,QTableWidgetItem(row[colCount]))
                    currentRowCount += 1
                
            except:
                print("Query Failed!!")
                
    def cityChanged(self):
        self.ui.zipList.clear()
        if (self.ui.stateList.currentIndex() >= 0) and (len(self.ui.cityList.selectedItems()) > 0):
            state = self.ui.stateList.currentText()
            city = self.ui.cityList.selectedItems()[0].text()
            sql_str = "SELECT distinct buspostal FROM business WHERE city ='" + city + "' ORDER BY buspostal;"
            try:
                results = self.executeQuery(sql_str)
                for row in results:
                    self.ui.zipList.addItem(row[0])
            except:
                print("Query Failed!")
            sql_str = "SELECT name, city, state, buspostal FROM business WHERE city ='" + city + "' AND state= '" + state + "'ORDER BY name;" 
            #print(sql_str)
            results = self.executeQuery(sql_str)
            try:
                results = self.executeQuery(sql_str)
                style = ":: section(""background-color: #f3f3f3; )"
                self.ui.businessTable.horizontalHeader().setStyleSheet(style)
                self.ui.businessTable.setColumnCount(len(results[0]))
                self.ui.businessTable.setRowCount(len(results))
                self.ui.businessTable.setHorizontalHeaderLabels(['Business Name', 'City', 'State', 'Zip Code'])
                self.ui.businessTable.resizeColumnsToContents()
                self.ui.businessTable.setColumnWidth(0,300)
                self.ui.businessTable.setColumnWidth(1,100)
                self.ui.businessTable.setColumnWidth(2, 50)
                    
                currentRowCount = 0
                for row in results:
                    for colCount in range(0,len(results[0])):
                        self.ui.businessTable.setItem(currentRowCount,colCount,QTableWidgetItem(row[colCount]))
                    currentRowCount += 1
                    
            except:
                print("Query Failed!!")   
    def loadZipList(self):
        self.ui.zipList.clear()
        #city = self.ui.cityList.selectedItems()[0].text()
        sql_str = "SELECT distinct zip from zipdata ORDER BY zip;"
        try:
            results = self.executeQuery(sql_str)
            for row in results:
                self.ui.zipList.addItem(row[0])
        except:
            print("Query Failed, zip")
        self.ui.zipList.setCurrentIndex(-1)
        self.ui.zipList.clearEditText()
        
        #RUN A JOIN ON THE CATEGORY AND business table and select based on zipcode 
        #select * from business, category where business.id = category.id, select distinct category 
        #select * from business where zipcode = and business id ( select * from category where category = selected)
        
        
#    def zipChanged(self): #for zipcode in page 1 # cant connect to change the business table when zipcode is selected
#        if (len(self.ui.cityList.currentIndex()) >= 0 ) and (len(self.ui.zipList.selectedItems()) > 0):
#            state = self.ui.stateList.currentText()
#            city = self.ui.cityList.currentText()
#            zipCode = self.ui.zipList.selectedItems()[0].text()
#            
#            sql_str = "SELECT name, city, state, buspostal FROM business WHERE city ='" + city + "'AND state= '" + state + "' AND buspostal ='"+ zipCode+"'ORDER BY name;"
#            print(sql_str)
#            results = self.executeQuery(sql_str)
#            try:
#                results = self.executeQuery(sql_str)
#                style = ":: section(""background-color: #f3f3f3; )"
#                self.ui.catTable.horizontalHeader().setStyleSheet(style)
#                self.ui.catTable.setColumnCount(len(results[0]))
#                self.ui.catTable.setRowCount(len(results))
#                self.ui.catTable.setHorizontalHeaderLabels(['Business Name', 'City', 'State', 'Zip Code'])
#                self.ui.catTable.resizeColumnsToContents()
#                self.ui.catTable.setColumnWidth(0,300)
#                self.ui.businessTable.setColumnWidth(1,100)
#                self.ui.businessTable.setColumnWidth(2, 50)
#                    
#                currentRowCount = 0
#                for row in results:
#                    for colCount in range(0,len(results[0])):
#                        self.ui.Table.setItem(currentRowCount,colCount,QTableWidgetItem(row[colCount]))
#                    currentRowCount += 1
#                    
#            except:
#                print("Query Failed!!")

    def displayTotalBus(self):
        zipCode = self.ui.zipList.currentText()
        sql_str = "select count(name) from business where buspostal = '" + zipCode +"';"
        
        try:
            #print(sql_str)
            results = self.executeQuery(sql_str)
            #print(results)
            self.ui.numBus.setText(str(results[0][0]))
        except:
            print("Query Failed!!!")
            
    def displayTotalPop(self): #initalize, text on page 1
        zipcode = self.ui.zipList.currentText()
        sql_str = "select population from zipdata where zip = '" +zipcode +"';"
        try:
            results = self.executeQuery(sql_str)
            self.ui.pop.setText(str(results[0][0]))
        except:
            print("Query Failed!!!!")
##                    
    def displayAvgIncome(self): #initalize, text on page 1
        zipcode = self.ui.zipList.currentText()
        sql_str = "select meanincome from zipdata where zip = '" +zipcode +"';"
        try:
            results = self.executeQuery(sql_str)
            #print(results)
            self.ui.avg.setText(str(results[0][0]))
        except:
            print("Query Failed!!!!")
            
    def loadCatList(self): #similar to load state list is working 
        self.ui.catList.clear()
        sql_str = "SELECT distinct cat_name FROM category ORDER BY cat_name;"
        try:
            results = self.executeQuery(sql_str)
            for row in results:
                self.ui.catList.addItem(row[0])
        except:
            print("Query Failed")
        self.ui.catList.setCurrentIndex(-1)
        self.ui.catList.clearEditText()
##        
    def catChanged(self): #complete for cat table on page 2 
        #self.ui.cityList.clear()
        if (self.ui.catList.currentIndex()>=0):
            cat = self.ui.catList.currentText()
            sql_str = "select distinct name from business, category where category.busi_id = business.busi_id and cat_name = '"+ cat +"'order by name; "
            #sql_str2 ="SELECT distinct buspostal FROM business WHERE state ='" + state + "' ORDER BY buspostal;"
            
            for i in reversed(range(self.ui.catTable.rowCount())):
                self.ui.catTable.removeRow(i)
            #sql_str = "SELECT name, city, state, buspostal FROM business WHERE state ='" + state + "' ORDER BY name;"
            try:
                results = self.executeQuery(sql_str)
                style = ":: section(""background-color: #f3f3f3; )"
                self.ui.catTable.horizontalHeader().setStyleSheet(style)
                self.ui.catTable.setColumnCount(len(results[0]))
                self.ui.catTable.setRowCount(len(results))
                self.ui.catTable.setHorizontalHeaderLabels(['Business Name'])
                self.ui.catTable.resizeColumnsToContents()
                self.ui.catTable.setColumnWidth(0,300)
                #self.ui.businessTable.setColumnWidth(1,100)
                #self.ui.businessTable.setColumnWidth(2, 50)
                    
                currentRowCount = 0
                for row in results:
                    for colCount in range(0,len(results[0])):
                        self.ui.catTable.setItem(currentRowCount,colCount,QTableWidgetItem(row[colCount]))
                    currentRowCount += 1
                    
            except:
                print("Query Failed!!")
                
      
        
    def getBusinessNames(self):
        self.ui.businesses.clear()
        businessname = self.ui.bname.text()
        sql_str = "SELECT name FROM business WHERE name LIKE '%" +businessname+ "%' ORDER BY name;"
        try:
            results = self.executeQuery(sql_str)
            for row in results:
                self.ui.businesses.addItem(row[0])
        except:
            print("Query Failed!!!")
    def displayBusinessCity(self):
        businessname = self.ui.businesses.selectedItems()[0].text()
        sql_str = "SELECT city FROM business WHERE name ='" +businessname + "';"
        try:
            results = self.executeQuery(sql_str)
            self.ui.bcity.setText(results[0][0])
        except:
            print("Query Failed!!!!")
                
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = milestone1()
    window.show()
    sys.exit(app.exec_())
