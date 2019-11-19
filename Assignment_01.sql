
CREATE TABLE CUSTOMER (CUSTNO VARCHAR2(8) CONSTRAINT CustNoNotNull NOT NULL, 
                       CustName VARCHAR2(30) CONSTRAINT CustNameNotNull NOT NULL, 
                       Address VARCHAR2(50) CONSTRAINT AddressNotNull NOT NULL, 
                       Internal CHAR(1) CONSTRAINT InternalNotNull NOT NULL, 
                       Contact VARCHAR2(35) CONSTRAINT ContractNotNull NOT NULL, 
                       Phone VARCHAR2(11) CONSTRAINT CPhoneNotNull NOT NULL, 
                       City VARCHAR2(30) CONSTRAINT CityNotNull NOT NULL,
                       State VARCHAR2(2) CONSTRAINT StateNotNull NOT NULL, 
                       Zip VARCHAR2(10) CONSTRAINT zipNotNull NOT NULL,
                       CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUSTNO) ) ;

CREATE TABLE EMPLOYEE (EMPNO VARCHAR2(8) CONSTRAINT EMPNONotNull NOT NULL,
                      EMPNAME VARCHAR2(20) CONSTRAINT EmpNameRequired NOT NULL,
                      DEPARTMENT VARCHAR2(30) CONSTRAINT EmpLastNameRequired NOT NULL,
                      EMAIL VARCHAR2(50) CONSTRAINT EmpEmailRequired NOT NULL,
                      PHONE CHAR(15) CONSTRAINT PHONENOTNULL NOT NULL,
                      CONSTRAINT PK_Employee PRIMARY KEY (EMPNO),
                      CONSTRAINT UniqueEMail UNIQUE (EMAIL) );

CREATE TABLE LOCATIONS (LOCNO VARCHAR2(8) CONSTRAINT LocNoNotNull NOT NULL, 
                          FACNO VARCHAR2(8) CONSTRAINT FacNoFKNotNull NOT NULL, 
                          LocName VARCHAR2(30) CONSTRAINT LocNameNotNull NOT NULL,
                          CONSTRAINT PK_LOCATION PRIMARY KEY (LOCNO),
                          CONSTRAINT FK_FACILITY FOREIGN KEY (FACNO) 
                          REFERENCES FACILITY (FACNO) );

CREATE TABLE FACILITY (FACNO VARCHAR2(8) CONSTRAINT FacNoNotNull NOT NULL, 
                      FACName VARCHAR2(30) CONSTRAINT FacNameNotNull NOT NULL,
                      CONSTRAINT PK_FACILITY PRIMARY KEY (FACNO), 
                      CONSTRAINT Unique_FacName UNIQUE(FACName));

 CREATE TABLE RESOURCETBL (RESNO VARCHAR2(8) CONSTRAINT RESNONotNull NOT NULL,
                          RESNAME VARCHAR2(20) CONSTRAINT RESNameRequired NOT NULL,
                          RATE DECIMAL(10,2)   CONSTRAINT RATENOTNULL NOT NULL,
                          CONSTRAINT PK_RESOURCETBL PRIMARY KEY (RESNO),
                          CONSTRAINT RATE_CK CHECK (RATE > 0));
        
  CREATE TABLE EVENTREQUEST (EVENTNO VARCHAR2(8) CONSTRAINT EVENTNONotNull NOT NULL,
                            DATEHELD DATE CONSTRAINT HeldDateRequired NOT NULL,
                            DATEREQ DATE CONSTRAINT ReqDateRequired NOT NULL,
                            CUSTNO VARCHAR2(8) CONSTRAINT CustNotNull NOT NULL,
                            FACNO VARCHAR2(8) CONSTRAINT FacNotNull NOT NULL,
                            DATEAUTH  DATE ,
                            STATUS CHAR(10) CONSTRAINT STATUSNotNull NOT NULL,
                            ESTCOST DECIMAL(10,2) CONSTRAINT ESTNotNull NOT NULL,
                            ESTAUDIENCE DECIMAL(10) CONSTRAINT ESTAUDIENCENotNull NOT NULL,
                            BUDNO VARCHAR2(8),
                            CONSTRAINT PK_EVENTREQUEST PRIMARY KEY (EVENTNO),
                            CONSTRAINT FK_CUSTOMER FOREIGN KEY (CUSTNO) REFERENCES CUSTOMER (CUSTNO),
                            CONSTRAINT FK1_FACILITY FOREIGN KEY (FACNO)  REFERENCES FACILITY (FACNO),
                            CONSTRAINT Check_status CHECK (STATUS IN ('Pending','Denied','Approved')),
                            CONSTRAINT ESTAUDIENCE_CK CHECK (ESTAUDIENCE > 0));
                            
                            
                            
   CREATE TABLE EVENTPLAN (PLANNO VARCHAR2(8) CONSTRAINT PLANNONotNull NOT NULL,
                          EVENTNO VARCHAR2(8) CONSTRAINT EVENTNotNull NOT NULL,
                          WORKDATE DATE CONSTRAINT WORKDATERequired NOT NULL,
                          NOTES VARCHAR(50),
                          ACTIVITY VARCHAR(10) CONSTRAINT ACTIVITYNOTNULL NOT NULL,
                          EMPNO VARCHAR2(8),
                          CONSTRAINT PK_EVENTPLAN PRIMARY KEY (PLANNO),
                          CONSTRAINT FK_EVENTREQUEST FOREIGN KEY (EVENTNO) REFERENCES EVENTREQUEST (EVENTNO),
                          CONSTRAINT FK_EMPLOYEE FOREIGN KEY (EMPNO)  REFERENCES EMPLOYEE (EMPNO));
   
  
  
  CREATE TABLE EVENTPLANLINE (PLANNO VARCHAR2(8) CONSTRAINT PLANNotNull NOT NULL,
                              LINENO VARCHAR2(8) CONSTRAINT LINENONotNull NOT NULL,
                              TIMESTART DATE CONSTRAINT TIMESTARTRequired NOT NULL,
                              TIMEEND DATE CONSTRAINT TIMEENDRequired NOT NULL,
                              NUMBERFLD NUMBER(10,2) CONSTRAINT NUMBERFLDNOTNULL NOT NULL,
                              LOCNO  VARCHAR2(8) CONSTRAINT LNNotNull NOT NULL,
                              RESNO  VARCHAR2(8) CONSTRAINT RNNotNull NOT NULL,
                              
                              CONSTRAINT PK_EVENTPLANLINE PRIMARY KEY (LINENO,PLANNO),
                              CONSTRAINT FK_EVENTPLAN FOREIGN KEY (PLANNO) REFERENCES EVENTPLAN (PLANNO),
                              CONSTRAINT FK_LOCATIONS FOREIGN KEY (LOCNO)  REFERENCES LOCATIONS (LOCNO),
                              CONSTRAINT FK_RESOURCETBL FOREIGN KEY (RESNO)  REFERENCES RESOURCETBL (RESNO),
                              CONSTRAINT CK_START_END_TIME CHECK (TIMESTART < TIMEEND)
                              );
                              
                            
                            
                            
                            
                            
                            
                            
                            
