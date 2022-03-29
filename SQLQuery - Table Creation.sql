----------------------------------------------------------------------------------BO_USERS
CREATE TABLE BO_USERS (
    Email varchar(200) NOT NULL,
    Password varchar(200) NOT NULL,
    Name varchar(200) NOT NULL,
    PRIMARY KEY (Email)
);

----------------------------------------------------------------------------------FC_USERS
CREATE TABLE FC_USERS (
	FCID int IDENTITY NOT NULL,
    Email varchar(200) NOT NULL,
    Password varchar(200) NOT NULL,
    Name varchar(200) NOT NULL,
	CompanyName varchar(200) NOT NULL,
    PRIMARY KEY (FCID)
);

----------------------------------------------------------------------------------JS_USERS
CREATE TABLE JS_USERS (
	NIC int NOT NULL,
    Email varchar(200) NOT NULL,
    Password varchar(200) NOT NULL,
    FirstName varchar(200) NOT NULL,
	LastName varchar(200) NOT NULL,
	DOB date NOT NULL,
	Address varchar(200) NOT NULL,
	Latitude float NOT NULL,
	Longitude float NOT NULL,
	Profession varchar(200) NOT NULL,
	Affiliation varchar(200) NOT NULL,
	Gender varchar(20) NOT NULL,
	Nationality varchar(200) NOT NULL,
	MaritalStatus varchar(200) NOT NULL,
  Validity bit NOT NULL,
    PRIMARY KEY (NIC)
);

----------------------------------------------------------------------------------JS_USERS_ARCHIVES
CREATE TABLE JS_USERS_ARCHIVES (
ArchiveID int IDENTITY NOT NULL,
	NIC int NOT NULL,
    Email varchar(200) NOT NULL,
    Password varchar(200) NOT NULL,
    FirstName varchar(200) NOT NULL,
	LastName varchar(200) NOT NULL,
	DOB date NOT NULL,
	Address varchar(200) NOT NULL,
	Latitude float NOT NULL,
	Longitude float NOT NULL,
	Profession varchar(200) NOT NULL,
	Affiliation varchar(200) NOT NULL,
	Gender varchar(20) NOT NULL,
	Nationality varchar(200) NOT NULL,
	MaritalStatus varchar(200) NOT NULL,
  Validity bit NOT NULL,
    PRIMARY KEY (ArchiveID)
);

----------------------------------------------------------------------------------JS_CONTACTS
CREATE TABLE JS_CONTACTS (
	ContactID int IDENTITY NOT NULL,
	JS_NIC int NOT NULL,
    Personal varchar(200) NOT NULL,
    Work  varchar(200) NOT NULL,
	Emmergency  varchar(200) NOT NULL,
    PRIMARY KEY (ContactID),
);

ALTER TABLE JS_CONTACTS
ADD FOREIGN KEY (JS_NIC) REFERENCES JS_USERS(NIC);

----------------------------------------------------------------------------------JS_DOCUMENTS
CREATE TABLE JS_DOCUMENTS (
	DocID int IDENTITY NOT NULL,
	JS_NIC int NOT NULL,
    OLevel varchar(500) NOT NULL,
    ALevel varchar(500) NOT NULL,
	BirthCertificate varchar(500) NOT NULL,
	CV varchar(500) NOT NULL,
	Passport varchar(500) NOT NULL,
	DrivingLicence varchar(500) NOT NULL,
	VaccineCard varchar(500) NOT NULL,
	Degree varchar(500) NOT NULL,
    PRIMARY KEY (DocID),
);

ALTER TABLE JS_DOCUMENTS
ADD FOREIGN KEY (JS_NIC) REFERENCES JS_USERS(NIC);

----------------------------------------------------------------------------------JS_QUALIFICATIONS
CREATE TABLE JS_QUALIFICATIONS (
	QualificationID int IDENTITY NOT NULL,
	JS_NIC int NOT NULL,
    OLStatus bit NOT NULL,
	ALStatus bit NOT NULL,
	DegreeStatus bit NOT NULL,
	DegreeField varchar(200) NOT NULL,
    PRIMARY KEY (QualificationID),
);

ALTER TABLE JS_QUALIFICATIONS
ADD FOREIGN KEY (JS_NIC) REFERENCES JS_USERS(NIC);

----------------------------------------------------------------------------------JS_COMPLAINS
CREATE TABLE JS_COMPLAINS (
	ComplaintID int IDENTITY NOT NULL,
	JS_NIC int NOT NULL,
    Complain varchar(1000) NOT NULL,
    Feedback varchar(1000) NOT NULL,
    PRIMARY KEY (ComplaintID),
);

ALTER TABLE JS_COMPLAINS
ADD FOREIGN KEY (JS_NIC) REFERENCES JS_USERS(NIC);