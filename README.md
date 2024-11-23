# SQL_Challenge_Case_Study_7---Balanced-Tree-Clothing-Co.


I practice my SQL skills with the #8WeekSQLChallenge prepared by Danny Ma. Thank you Danny for the excellent case study.
If you are also looking for materials to improve your SQL skills you can find it [here](https://8weeksqlchallenge.com/) and try it yourself.

# <p align="center"> Case Study #7: 👕 Balanced Tree Clothing Co.
<p align="center"> <img src="https://8weeksqlchallenge.com/images/case-study-designs/7.png" alt="Image Balanced Tree - colothing company" height="400">

***

## Table of Contents

- [Business Case](#business-case)
- [Available Data](#available-data)
- [Case Study Questions](#case-study-questions)
- [SQL Skills Gained](#sql-skills-gained)


## Business Case
Balanced Tree Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer!

Danny, the CEO of this trendy fashion company has asked you to assist the team’s merchandising teams analyse their sales performance and generate a basic financial report to share with the wider business.


## Available Data


#### ``Table 1: product_details``

| product_id | price | product_name                   | category_id | segment_id | style_id | category_name | segment_name | style_name            |
|------------|-------|--------------------------------|-------------|------------|----------|---------------|--------------|-----------------------|
| c4a632     | 13    | Navy Oversized Jeans - Womens | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized        |
| e83aa3     | 32    | Black Straight Jeans - Womens | 1           | 3          | 8        | Womens        | Jeans        | Black Straight        |
| e31d39     | 10    | Cream Relaxed Jeans - Womens  | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed         |
| d5e9a6     | 23    | Khaki Suit Jacket - Womens    | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit            |
| 72f5d4     | 19    | Indigo Rain Jacket - Womens   | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain           |
| 9ec847     | 54    | Grey Fashion Jacket - Womens  | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion          |
| 5d267b     | 40    | White Tee Shirt - Mens        | 2           | 5          | 13       | Mens          | Shirt        | White Tee             |
| c8d436     | 10    | Teal Button Up Shirt - Mens   | 2           | 5          | 14       | Mens          | Shirt        | Teal Button Up        |
| 2a2353     | 57    | Blue Polo Shirt - Mens        | 2           | 5          | 15       | Mens          | Shirt        | Blue Polo             |
| f084eb     | 36    | Navy Solid Socks - Mens       | 2           | 6          | 16       | Mens          | Socks        | Navy Solid            |
| b9a74d     | 17    | White Striped Socks - Mens    | 2           | 6          | 17       | Mens          | Socks        | White Striped         |
| 2feb6b     | 29    | Pink Fluro Polkadot Socks - Mens | 2        | 6          | 18       | Mens          | Socks        | Pink Fluro Polkadot   |

#### ``Table 2: sales``
*Note: sample of data, 10 random rows*

| prod_id | qty | price | discount | member | txn_id | start_txn_time           |
|---------|-----|-------|----------|--------|--------|--------------------------|
| c4a632  | 4   | 13    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296 |
| 5d267b  | 4   | 40    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296 |
| b9a74d  | 4   | 17    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296 |
| 2feb6b  | 2   | 29    | 17       | t      | 54f307 | 2021-02-13 01:59:43.296 |
| c4a632  | 5   | 13    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| e31d39  | 2   | 10    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| 72f5d4  | 3   | 19    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| 2a2353  | 3   | 57    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| f084eb  | 3   | 36    | 21       | t      | 26cc98 | 2021-01-19 01:39:00.3456 |
| c4a632  | 1   | 13    | 21       | f      | ef648d | 2021-01-27 02:18:17.1648 |

<br>

<details><summary>
    Two additional tables for the bonus question
  </summary> 


#### ``Table 3: product_hierarchy``
*Those table is used only for the bonus question in **part D***

| id  | parent_id | level_text          | level_name |
|-----|-----------|---------------------|------------|
| 1   |           | Womens             | Category   |
| 2   |           | Mens               | Category   |
| 3   | 1         | Jeans              | Segment    |
| 4   | 1         | Jacket             | Segment    |
| 5   | 2         | Shirt              | Segment    |
| 6   | 2         | Socks              | Segment    |
| 7   | 3         | Navy Oversized     | Style      |
| 8   | 3         | Black Straight     | Style      |
| 9   | 3         | Cream Relaxed      | Style      |
| 10  | 4         | Khaki Suit         | Style      |
| 11  | 4         | Indigo Rain        | Style      |
| 12  | 4         | Grey Fashion       | Style      |
| 13  | 5         | White Tee          | Style      |
| 14  | 5         | Teal Button Up     | Style      |
| 15  | 5         | Blue Polo          | Style      |
| 16  | 6         | Navy Solid         | Style      |
| 17  | 6         | White Striped      | Style      |
| 18  | 6         | Pink Fluro Polkadot | Style      |


#### ``Table 4: product_prices``
*Those table is used only for the bonus question in **part D***

| id  | product_id | price |
|-----|------------|-------|
| 7   | c4a632     | 13    |
| 8   | e83aa3     | 32    |
| 9   | e31d39     | 10    |
| 10  | d5e9a6     | 23    |
| 11  | 72f5d4     | 19    |
| 12  | 9ec847     | 54    |
| 13  | 5d267b     | 40    |
| 14  | c8d436     | 10    |
| 15  | 2a2353     | 57    |
| 16  | f084eb     | 36    |
| 17  | b9a74d     | 17    |
| 18  | 2feb6b     | 29    |


  </details>

## Case Study Questions

- [A. High Level Sales Analysis](https://github.com/ElaWajdzik/SQL_Challenge_Case_Study_7---Balanced-Tree-Clothing-Co/blob/main/A.%20High%20Level%20Sales%20Analysis.md)

- [B. Transaction Analysis](https://github.com/ElaWajdzik/SQL_Challenge_Case_Study_7---Balanced-Tree-Clothing-Co/blob/main/B.%20Transaction%20Analysis.md)

- [C. Reporting Challenge](https://github.com/ElaWajdzik/SQL_Challenge_Case_Study_7---Balanced-Tree-Clothing-Co/blob/main/C.%20Reporting%20Challenge.md)

- [D. Bonus Challenge](https://github.com/ElaWajdzik/SQL_Challenge_Case_Study_7---Balanced-Tree-Clothing-Co/blob/main/D.%20Bonus%20Challenge.md)


## SQL Skills Gained
- 


<br/>

*** 

 # <p align="center"> Thank you for your attention! 🫶️

**Thank you for reading.** If you have any comments on my work, please let me know. My email address is ela.wajdzik@gmail.com.

***