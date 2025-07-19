SELECT dbhib.* FROM diabetes.diabetes_binary_health_indicators_brfss2015 AS dbhib
select * from diabetes.diabetes_binary_health_indicators_brfss2015 
select *, row_number() over (partition by Diabetes_binary, HighBP,HighChol,CholCheck,BMI,Smoker,Stroke,HeartDiseaseorAttack,PhysActivity,Fruits,Veggies,HvyAlcoholConsump,
AnyHealthcare,NoDocbcCost,GenHlth,PhysHlth,DiffWalk,Sex,Age,Education,Income) as row_n from diabetes.diabetes_binary_health_indicators_brfss2015;
where row_n = 1;

delete from diabetes.diabetes_binary_health_indicators_brfss2015 
where (Diabetes_binary, HighBP,HighChol,CholCheck,BMI,
Smoker,Stroke,
HeartDiseaseorAttack,PhysActivity,
Fruits,Veggies,HvyAlcoholConsump,
AnyHealthcare,NoDocbcCost,GenHlth,PhysHlth,
DiffWalk,Sex,Age,Education,Income)
not in 
( select * from(select Min(Diabetes_binary),
min(HighBP),min(HighChol),min(CholCheck),
min(BMI),min(Smoker),min(Stroke),
min(HeartDiseaseorAttack),
min(PhysActivity),min(Fruits),
min(Veggies),min(HvyAlcoholConsump),
min(AnyHealthcare),min(NoDocbcCost),min(GenHlth),
min(PhysHlth),min(DiffWalk),min(Sex),
min(Age),min(Education),min(Income) 
from diabetes.diabetes_binary_health_indicators_brfss2015
group by Diabetes_binary, 
HighBP,HighChol,
CholCheck,BMI,Smoker,Stroke,
HeartDiseaseorAttack,PhysActivity,
Fruits,Veggies,HvyAlcoholConsump,
AnyHealthcare,NoDocbcCost,GenHlth,
PhysHlth,DiffWalk,Sex,Age,Education,Income)
as sub );

create table diabetes_cleaned as (select * from (select*, row_number() over (partition by Diabetes_binary, HighBP,HighChol,CholCheck,BMI,Smoker,Stroke,HeartDiseaseorAttack,PhysActivity,Fruits,Veggies,HvyAlcoholConsump,
AnyHealthcare,NoDocbcCost,GenHlth,PhysHlth,DiffWalk,Sex,Age,Education,Income
order by BMI) as row_num from diabetes.diabetes_binary_health_indicators_brfss2015) as ranked
where row_num = 1);
select count(*) from diabetes_cleaned 
where Age > 13;
Alter table diabetes_cleaned
modify column sex VARCHAR(10);

Update diabetes_cleaned 
set sex = 'Male'
where sex = 1;

Update diabetes_cleaned 
set sex = 'Female'
where sex = '0';


select * from diabetes_cleaned;
select count(*) from diabetes_cleaned;
select Diabetes_binary, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2)as perc from diabetes_cleaned
where diabetes_binary = 1;
select Diabetes_binary, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2)as perc from diabetes_cleaned
where diabetes_binary = 0;
select HighBP,count(*), round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where HighBP = 1;
select HighBP,count(*), round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where HighBP = 0;
select HighChol, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where HighChol = 1;
select Smoker, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where Smoker = 1;
select HeartDiseaseorAttack, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where HeartDiseaseorAttack = 1;
select Stroke, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where Stroke = 1;
select Smoker, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where Smoker = 1;
select PhysActivity, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where PhysActivity = 1;
select Fruits, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where Fruits = 1;
select Veggies, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where Veggies = 1;
select HvyAlcoholConsump, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where HvyAlcoholConsump = 1;
select AnyHealthcare, count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where  AnyHealthcare= 1;
select NoDocbcCost , count(*), round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where  NoDocbcCost = 0;
select DiffWalk, count(*) as total, round(count(*) * 100/(select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where DiffWalk = 0;
select * from diabetes_cleaned;


select Genhlth, count(*) as total ,round(count(*)* 100 / (select count(*) from diabetes_cleaned),2) as perc  from diabetes_cleaned
group by GenHlth 
order by total desc;
select Menthlth, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
group by menthlth 
order by total desc;
select Physhlth, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
group by Physhlth 
order by total desc;
select Sex, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
group by sex
order by total desc;
select Age, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
group by Age
order by total desc;
select Education, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
group by Education
order by total desc;
select Income, count(*) as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
group by Income
order by total desc;
select count(*)as total, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as PERC from diabetes_cleaned 
where income in (1,2,3,4);
select count(*) as Middle_class, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where income in (5,6,7);

select  count(*), round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where BMI >= 25;
select * from diabetes_cleaned;

select count(GenHlth), count(Diabetes_binary),round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where Genhlth = 5 and Diabetes_binary = 1;
select Diabetes_binary, AVG(BMI) as avg from diabetes_cleaned 
group by Diabetes_binary;
select count(PhysActivity), count(BMI), round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where PhysActivity = 1 and BMI < 25;
select Diabetes_binary, count(Fruits) as total, count(Veggies) as total_n ,round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
where Fruits = 1 and Veggies = 1
group by Diabetes_binary;
select PhysActivity,count(PhysActivity), round(Avg(MentHlth),2), round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned
group by PhysActivity;

select avg(BMI), count(income),round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where income in (5,6,7);
select avg(BMI), count(income),round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where income in (1,2,3,4) ;
select avg(BMI), count(income),round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where income in (8);
select count(Genhlth), count(income), round(count(*)*100 / (select count(*) from diabetes_cleaned),2) as perc  from diabetes_cleaned dc 
where income in (1,2,3,4) and Genhlth = 5;
select count(BMI), Education,count(Education) as level, round(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where BMI < 25
group by Education ;
select Education, AVG(Diabetes_binary) as diabetes_rate from diabetes_cleaned 
group by Education;

with ranked as (
select *, rank() over (partition by sex order by BMI DESC) as bmi_rank from diabetes_cleaned)
select * from ranked
Where bmi_rank <= 3;
with ranked as ( select *, rank() over (partition by Genhlth order by BMI DESC) as bmi_rank from diabetes_cleaned)
select * from ranked
where bmi_rank <= 3;
with ranked as (select *, rank() over (partition by HvyAlcoholConsump order by BMI DESC) as bmi_ranked from diabetes_cleaned)
select * from ranked 
where bmi_ranked <= 3;
select *, count(*) over (partition by income, diabetes_binary) as data from diabetes_cleaned
where income in (5,6,7) and diabetes_binary = 1;
select *,count(*) over (partition by income,diabetes_binary) as data from diabetes_cleaned 
where income in (1,2,3,4) and diabetes_binary = 1;
select *,count(*) over (partition by income,diabetes_binary) as data from diabetes_cleaned 
where income in (8) and diabetes_binary = 1;
select *, AVG(BMI) over (partition by education) as data from diabetes_cleaned 
order by data;
select * from (select *, row_number() over (partition by income) as data from diabetes_cleaned
where diabetes_binary = 1) as ranked 
where data = 1 and income in (1,2,3,4)


with ranked_activity as (select *, rank() over (partition by income order by PhysHlth) as rk from diabetes_cleaned)
select * from ranked_activity
where rk =1 and income in (1,2,3,4);
select * from diabetes_cleaned 
where BMI > (select AVG(BMI) from diabetes_cleaned);
select count(*), ROUND(count(*) * 100 / (select count(*) from diabetes_cleaned),2) as perc from diabetes_cleaned 
where BMI > (select AVG(BMI) from diabetes_cleaned);
select BMI, Lag(BMI) over (order by BMI)
 as prev_bmi,
 lead(BMI) over (order by BMI) as next_bmi from diabetes_cleaned 