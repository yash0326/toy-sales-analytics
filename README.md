# Toy Sales Analytics
<a href="https://public.tableau.com/app/profile/yash.tyagi1740/viz/ToySalesAnalytics/Dashboard1"> Interactive Tableau Dashboard-1</a>


<a href="https://public.tableau.com/app/profile/yash.tyagi1740/viz/ToySalesAnalytics-II/Dashboard2"> Interactive Tableau Dashboard-2</a>

![Screenshot (49)](https://github.com/yash0326/toy-sales-analytics/assets/116998155/d0eea1fb-05b1-435c-be57-c1b38ca9ab78)


## What is this Project?
The Project Focuses on analyzing twenty months' of sales data for a toy store chain based out of multiple locations in Mexico. In the project, we will try to delve into the intricacies of sales analysis, seeking patterns, trends, and valuable insights to enhance our understanding of the situation.

## Tech Stack:
  * MySQL
  * Tableau
  * Excel


## Data Manipulation Process
  * The Product cost and Product price had a ‘$’  as a prefix and were a varchar() type of columns, using Excel the prefix 
    was removed so that the column can be cast into a int() datatype.

  * Using Product cost and Product price columns a new column ‘Profit’ was generated using a simple Excel subtraction 
    formula. The Profit column will be very useful in doing further analysis of the sales data.

  * In Tableau’s Calculated fields column ‘DATENAME’ function was used to extract the day of the week on which the a 
    particular sale took place.

  * Tableau’s Calculated field function was used to generate important metrics such as ‘Profit %’, ‘Total Cost’, ‘Total 
    Price’ and ‘Total Profit’








