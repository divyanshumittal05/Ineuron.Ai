Create database CIA_Popualtion;
use CIA_Popualtion;

Set Global max_allowed_packet = 3700000;

	CREATE TABLE Populations (
		`County_Code` DECIMAL(38, 0) NOT NULL, 
		`County_Name` VARCHAR(15) NOT NULL, 
		`Year` DECIMAL(38, 0) NOT NULL, 
		`Race_Code` DECIMAL(38, 0) NOT NULL, 		
        `Race_Name` VARCHAR(54) NOT NULL, 
		`Gender` VARCHAR(6) NOT NULL, 		
        `Age` DECIMAL(38, 0) NOT NULL, 
		`Population` DECIMAL(38, 0) NOT NULL
	);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
set global local_infile = 1; 

-- Load The Data
load data local infile 'C:/Divyanshu/Sql/Assignment/Population/CA_DRU_proj_2010-2060.csv'
into table Populations
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- Showcase the data
select * from Populations;

-- Count Distinct Country Name 
Select count(Distinct(County_Name)) from Populations;
select distinct(County_Name) from  Populations;
-- Count the total number of record 
Select count(*) from populations;

								       -- Task 1: Which country has the highest population? --
                                       
select County_Name, sum(Population) as Total_Population
From populations
Group by County_Name
order by Total_Population desc limit 1;
    
                                      -- Task 2: Which country has the least number of people? --
                                      
select County_Name, sum(population) as total_popualtion
from populations
group by County_Name
order by total_popualtion limit 1;

                                      -- Task 3: Which country is witnessing the highest population growth? --

/* View that show the population data of next year by which we can calculate year wise growth 
and then by doing avg of the result we can find out over all growth of a country */

select * from population_data ;

select county_name, Avg(growth) as Avg_Growth
from(select county_name, 100*((Modify_Next_Year_Population-Total_population)/Total_population) as Growth
from population_data) as a
group by county_name
order by Avg_Growth desc limit 1;
         

                                   -- Task 4: Which country has an extraordinary number for the population? --
                                   
select County_Name, sum(Population) as Total_Population
From populations
Group by County_Name
order by Total_Population desc limit 1;

                                   -- Task 5: Which is the most densely populated country in the world? --

-- Densely Populated Country Means How Many People Lives in per kilometer area .
-- Which Depends On Area Field that not given in this data-set. So, for this reason I can't find it.