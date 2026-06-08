-- DATABASE: Gen-Z Career Aspirations Analysis

-- Create the database
CREATE DATABASE genz_careers;

USE genz_careers;

-- Create table
CREATE TABLE gen_z (
Response_TIMESTAMP TEXT,
Country TEXT,
Zip_Code TEXT,
Gender TEXT,
Career_Influence_Factor TEXT,
Willingness_Study_Abroad TEXT,
Willingness_Work_3Years TEXT,
Work_Without_Mission TEXT,
Work_Misaligned_values TEXT,
Social_Impact_Score INTEGER,
Preferred_Work_Env TEXT,
Employer_Preference TEXT,
Preferred_Learning_Env TEXT,
Aspirational_Job_Role TEXT,
Manager_Preference TEXT,
Preferred_Work_Setup TEXT,
Work_PostLayoff_Company TEXT,
Long_Term_Employment TEXT,
Email_Address TEXT,
Expected_Salary_First3Yrs TEXT,
Expected_Salary_After5Yrs TEXT,
No_Remote_Policy_Score TEXT,
Expected_Starting_Salary TEXT,
Preferred_Company_Type TEXT,
Unhealthy_Workspace TEXT,
Daily_Working_Hours TEXT,
Break_Frequency TEXT,
Key_Productivity_Factors TEXT,
Primary_Frustration TEXT);


-- Q1. What industries are Gen-Z most interested in pursuing careers in?
SELECT
  Aspirational_Job_Role,
  COUNT(*) AS Total_Responses,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gen_z WHERE Country = 'India'), 2) AS Percentage
FROM gen_z
WHERE Country = 'India'
GROUP BY Aspirational_Job_Role
ORDER BY Total_Responses DESC
LIMIT 10;

-- Q2. What are the top factors influencing Gen-Z's career choices?
SELECT 
  Career_Influence_Factor,
  COUNT(*) AS Total_Responses,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gen_z WHERE COUNTRY = 'India'), 2) AS Percentage
FROM gen_z
WHERE Country = 'India'
GROUP BY Career_Influence_Factor
ORDER BY Total_Responses DESC;


-- Q3. What is the desired work environment for Gen-Z?
SELECT
  Preferred_Work_Env,
  COUNT(*) AS Total_responses,
  ROUND(COUNT(*) * 100.0 / (
      SELECT COUNt(*) FROM gen_z WHERE Country = 'India'), 2) AS Percentage,
      CASE
          WHEN Preferred_Work_Env = 'Remote'
               THEN 'Full Flexibility'
          WHEN Preferred_Work_Env LIKE 'Hybrid%'
               THEN 'Partial Flexibility'
          WHEN Preferred_Work_Env = 'On-site'
                THEN 'No Flexibility'
      END AS Flexibility_Category
FROM gen_z
WHERE Country = 'India'
GROUP BY Preferred_Work_Env
ORDER BY Total_Responses DESC;


-- Q4. How do financial goals, such as salary and benefits, impact career aspirations among Gen-Z?
-- First 3 Years Salary
SELECT
  Expected_Salary_First3Yrs AS Salary_range,
  COUNT(*) AS Total_Responses,
  ROUND(Count(*) * 100.0 / ( SELECT COUNT(*) FROM gen_z
  WHERE Country = 'India'
  AND Expected_Salary_First3Yrs != 'Not Answered'), 2) AS Percentage,
  CASE
      WHEN Expected_Salary_First3Yrs IN ('5k-10k','11k-15k','16k-20k')
        THEN 'Low (Below 20k)'
      WHEN Expected_Salary_First3Yrs In ('21k-25k','26k-30k','31k-40k')
        THEN 'Mid (21k to 40k)'
      WHEN Expected_Salary_First3Yrs IN ('41k-50k','>50k')
        THEN 'High (Above 40k)'
   END AS Salary_Tier
FROM gen_z
WHERE Country = 'India'
  AND Expected_Salary_First3Yrs != 'Not Answered'
GROUP BY Expected_Salary_First3Yrs
ORDER BY Total_Responses DESC;

-- After 5 Years Salary
SELECT 
  Expected_Salary_After5Yrs AS Salary_Range,
  COUNT(*) AS Total_Responses,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gen_z
  WHERE Country = 'India'
  AND Expected_Salary_After5Yrs != 'Not Answered'), 2) AS Percentage
FROM gen_z
WHERE Country = 'India'
  AND Expected_Salary_After5Yrs != 'Not Answered'
GROUP BY Expected_Salary_After5Yrs
ORDER BY Total_Responses DESC;

-- Q5. What role do personal values and social impact play in career choices for Gen-Z?
SELECT
  CASE 
    WHEN Social_Impact_Score IN (1, 2, 3)
      THEN 'Low Tolerance - Highly Values Social Impact'
    WHEN Social_Impact_Score IN (4, 5, 6)
      THEN  'Moderate Tolerance - Partially Values Impact'
    WHEN Social_Impact_Score IN (7, 8, 9, 10)
      THEN 'High Tolerance - Less Concerned About Impact'
  END AS Impact_Category,
  COUNT(*) AS Total_Responses,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gen_z WHERE Country = 'India'), 2) AS Percentage
FROM gen_z
WHERE Country = 'India'
GROUP BY Impact_Category
ORDER BY Total_Responses DESC;

-- Work Without Mission
SELECT
  Work_Without_Mission AS Works_Without_Company_Mission,
  COUNT(*) AS Total_Responses,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gen_z WHERE Country = 'India'), 2) AS Percentage
FROM gen_z
WHERE Country = 'India'
GROUP BY Work_Without_Mission
ORDER BY Total_Responses DESC;
