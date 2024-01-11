CREATE SCHEMA IPL;

SET SEARCH_PATH TO IPL;

CREATE TABLE Players(
    	PlayerID CHARACTER(5) PRIMARY KEY,
	"Name" VARCHAR(50) NOT NULL, 
	Nationality  VARCHAR(50) NOT NULL,
	DoB DATE NOT NULL,
	"Role"  VARCHAR(50),
	StrikeRate DECIMAL(5,2),
	BowlingStyle  VARCHAR(50),
	BattingStyle  VARCHAR(50)
);
CREATE TABLE kavya(
    	PlayerID CHARACTER(5) PRIMARY KEY,
	"Name" VARCHAR(50) NOT NULL, 
	Nationality  VARCHAR(50) NOT NULL,
	DoB DATE NOT NULL,
	"Role"  VARCHAR(50),
	StrikeRate DECIMAL(5,2),
	BowlingStyle  VARCHAR(50),
	BattingStyle  VARCHAR(50)
);

CREATE TABLE TitleSponsor(
	CompanyName VARCHAR(50) PRIMARY KEY,
	BusinessDomain VARCHAR(50) NOT NULL,
	Country VARCHAR(50) NOT NULL	
);

CREATE TABLE TeamOwner(
	CompanyName VARCHAR(50) PRIMARY KEY,
	BusinessDomain VARCHAR(50) NOT NULL,
	Country VARCHAR(50) NOT NULL	
);


CREATE TABLE Teams(
	TeamID VARCHAR(5) PRIMARY KEY,
	TeamName VARCHAR(50) UNIQUE NOT NULL,
	OwnerCompany VARCHAR(50) NOT NULL,
	FOREIGN KEY(OwnerCompany) REFERENCES TeamOwner
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Umpire(
	UmpireID CHARACTER(5) PRIMARY KEY,
	"Name" VARCHAR(50) NOT NULL,
	YearsOfExperience SMALLINT,
	Country VARCHAR(50) NOT NULL	
);

CREATE TABLE Stadium(
	StadiumName VARCHAR(50),
	City VARCHAR(50),
	Country VARCHAR(50) NOT NULL,
	Capacity INT,
	RentAmount BIGINT,
	PRIMARY KEY (StadiumName, City)
);

CREATE TABLE "Match"(
	MatchID CHARACTER(7) PRIMARY KEY,
	MatchType VARCHAR(10) NOT NULL,
	"Date" DATE NOT NULL,
	StadiumName VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	ManOfTheMatch CHARACTER(5) NOT NULL,
	FOREIGN KEY (StadiumName, City) REFERENCES Stadium
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ManOfTheMatch) REFERENCES Players
		ON DELETE CASCADE ON UPDATE CASCADE	
);

CREATE TABLE UmpiredBy(
	MatchID CHARACTER(7),
	UmpireID CHARACTER(5),
	PRIMARY KEY (MatchID, UmpireID),
	FOREIGN KEY (MatchID) REFERENCES "Match"
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (UmpireID) REFERENCES Umpire
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IPL(
	"Year" SMALLINT PRIMARY KEY, 
	TitleSponsor VARCHAR(50) NOT NULL,
	ManOfTheSeries CHARACTER(5) NOT NULL,
	ChampionTeam VARCHAR(5) NOT NULL,
	FOREIGN KEY (ChampionTeam) REFERENCES Teams
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (TitleSponsor) REFERENCES TitleSponsor
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ManOfTheSeries) REFERENCES Players
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TeamDetails(
	TeamID VARCHAR(5),
	"Year" SMALLINT,
	CaptainID CHARACTER(5) NOT NULL,
    	CoachID CHARACTER(5) NOT NULL,
	SponsorCompany VARCHAR(50) NOT NULL,
	SponsorAmount BIGINT NOT NULL,	
	PRIMARY KEY (TeamID, "Year"),
	FOREIGN KEY (CaptainID) REFERENCES Players
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (CoachID) REFERENCES HeadCoach
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (SponsorCompany) REFERENCES TitleSponsor
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (TeamID) REFERENCES Teams
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ("Year") REFERENCES IPL
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE YearwisePlayerDetails(
	PlayerID CHARACTER(5),
	"Year" SMALLINT, 
	TeamID VARCHAR(5) NOT NULL,
	TotalWickets INT,
	TotalRuns INT,
	MaximumWickets INT,
	MaximumWicketsRuns INT,
	MaximumRuns INT,
	PlayerPrice BIGINT,
	Out_NotOut BOOLEAN,
	PRIMARY KEY(PlayerID,"Year"),
	FOREIGN KEY (PlayerID) REFERENCES Players
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (TeamID,"Year") REFERENCES TeamDetails
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Played(
	MatchID CHARACTER(7),
	TeamID VARCHAR(5),
	TeamRuns INT NOT NULL,
	"4s" INT NOT NULL,
	"6s" INT NOT NULL,
	Wickets INT NOT NULL,
	Winner CHARACTER(1) NOT NULL, 
	PRIMARY KEY(MatchID,TeamID),
	FOREIGN KEY (TeamID) REFERENCES Teams
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (MatchID) REFERENCES "Match"
		ON DELETE CASCADE ON UPDATE CASCADE);

