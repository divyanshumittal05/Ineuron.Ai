Create database Road_safety_UK;
use Road_safety_UK;

set global max_allowed_packet = 300000;

create table accidents(
     accident_index VARCHAR(13),
    accident_severity INT
);

CREATE TABLE vehicles(
	accident_index VARCHAR(13),
    vehicle_type VARCHAR(50)
);

CREATE TABLE vehicle_types(
     CODE INT,
     LABEL VARCHAR(100)
);

CREATE TABLE vehicle_Type_details(
    Code Int,
    Label Varchar(100)
);

SHOW GLOBAL VARIABLES LIKE 'local_infile';
set global local_infile = 1; 

load data local infile 'C:/Divyanshu/Sql/Assignment/Road_Safety/Accidents_2015.csv'
into table accidents
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows 
(accident_index,accident_severity);

load data local infile 'C:/Divyanshu/Sql/Assignment/Road_Safety/Vehicles_2015.csv'
into table vehicles
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows 
(accident_index,Vehicle_Type);

load data local infile 'C:/Divyanshu/Sql/Assignment/Road_Safety/vehicle_types.csv'
into table vehicle_types
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows ;

load data local infile 'C:/Divyanshu/Sql/Assignment/Road_Safety/Road-Accident-Safety-Data-Guide.csv'
into table vehicle_Type_details
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows ;

select * from accidents;
select * from vehicles;
select * from vehicle_Type_details;
select * from vehicle_types;

                      -- Task 1: Evaluate the median severity value of accidents caused by various Motorcycles.
select avg(avg_accident_servity) as Median_Servity_Caused_By_Various_Motorcycles
from(select a.*,row_number() over(order by avg_accident_servity desc) as desc_servity,
	   row_number() over(order by avg_accident_servity asc) as asc_servity
From (select v1.vehicle_type,v2.LABEL as MotorCylce_Type,avg(a.accident_severity) as avg_accident_servity, count(a.accident_index) as total_accidents
from accidents a
inner join vehicles v1 on a.accident_index = v1.accident_index
inner join vehicle_types v2 on v2.CODE = v1.vehicle_type
where v2.LABEL like '%Motorcycle%'
group by 1,2) a) b
where asc_servity in (desc_servity,desc_servity+1,desc_servity-1);

					  -- Task 2: Evaluate Accident Severity and Total Accidents per Vehicle Type
select v1.vehicle_type,avg(a.accident_severity) as avg_accident_servity, count(a.accident_index) as total_accidents
from accidents a
inner join vehicles v1 on a.accident_index = v1.accident_index
inner join vehicle_types v2 on v2.CODE = v1.vehicle_type
group by 1
order by 3;

                      -- Task 3: Calculate the Average Severity by vehicle type.
select v1.vehicle_type,avg(a.accident_severity) as avg_accident_servity
from accidents a
inner join vehicles v1 on a.accident_index = v1.accident_index
inner join vehicle_types v2 on v2.CODE = v1.vehicle_type
group by 1;

                      -- Task 4: Calculate the Average Severity and Total Accidents by Motorcycle.
select v1.vehicle_type,v2.LABEL as MotorCylce_Type,avg(a.accident_severity) as avg_accident_servity, count(a.accident_index) as total_accidents
from accidents a
inner join vehicles v1 on a.accident_index = v1.accident_index
inner join vehicle_types v2 on v2.CODE = v1.vehicle_type
where v2.LABEL like '%Motorcycle%'
group by 1,2;