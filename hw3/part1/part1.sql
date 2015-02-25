DROP VIEW IF EXISTS q1a, q1b, q1c, q1d, q2, q3, q4, q5, q6, q7;

-- Question 1a
CREATE VIEW q1a(id, amount)
AS
  SELECT cmte_id, transaction_amt
  FROM committee_contributions
  WHERE transaction_amt > 5000 -- replace this line
;

-- Question 1b
CREATE VIEW q1b(id, name, amount)
AS
  SELECT cmte_id, name, transaction_amt
  FROM committee_contributions
  WHERE transaction_amt > 5000 -- replace this line
;

-- Question 1c
CREATE VIEW q1c(id, name, avg_amount)
AS
  SELECT cmte_id, name, AVG(transaction_amt)
  FROM committee_contributions
  WHERE transaction_amt > 5000
  GROUP BY cmte_id, name -- replace this line
;

-- Question 1d
CREATE VIEW q1d(id, name, avg_amount)
AS
  SELECT cmte_id, name, AVG(transaction_amt)
  FROM committee_contributions
  WHERE transaction_amt > 5000
  GROUP BY cmte_id, name
  HAVING AVG(transaction_amt)>10000 -- replace this line
;

-- Question 2
CREATE VIEW q2(from_name, to_name)
AS
  SELECT 1,1 -- replace this line
;

-- Question 3
CREATE VIEW q3(name)
AS
  SELECT 1 -- replace this line
;

-- Question 4.
CREATE VIEW q4 (name)
AS
  SELECT 1 -- replace this line
;

-- Question 5
CREATE VIEW q5 (name, total_pac_donations) AS
  SELECT 1,1 -- replace this line
;

-- Question 6
CREATE VIEW q6 (id) AS
  SELECT 1 -- replace this line
;

-- Question 7
CREATE VIEW q7 (cand_name1, cand_name2) AS
  SELECT 1,1 -- replace this line
;
