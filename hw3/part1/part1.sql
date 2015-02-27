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
  WITH comms1(id,name) AS ( SELECT comm_cont.cmte_id, comm.name
                   FROM committee_contributions AS comm_cont
                   INNER JOIN committees as comm
                     ON comm.id = comm_cont.cmte_id
                     AND comm.pty_affiliation = 'DEM')


  SELECT comms1.name, comms2.name
  FROM intercommittee_transactions AS A
  INNER JOIN comms1
    ON comms1.id = A.cmte_id
  INNER JOIN comms1
    ON comms1.id = A.other_id
;

-- Question 3
CREATE VIEW q3(name)
AS
  SELECT DISTINCT C.name
  FROM committee_contributions AS C
  WHERE C.cmte_id NOT IN (SELECT A.cmte_id
     FROM intercommittee_transactions AS A
     INNER JOIN committee_contributions AS B
       ON A.other_id = B.cmte_id
       AND B.name = 'OBAMA, BARACK')
  GROUP BY C.name-- replace this line
;

-- Question 4.
CREATE VIEW q4 (name)
AS
  WITH cand_com_count(cand_id, cmte_count) AS (
    SELECT A.cand_id, COUNT(DISTINCT A.cmte_id)
    FROM committee_contributions AS A
    GROUP BY A.cand_id)
  SELECT cand.name
  FROM candidates AS cand, cand_com_count AS cand_com
  WHERE cand.id = cand_com.cand_id
     AND cand_com.cmte_count > (SELECT COUNT(DISTINCT cmte_tbl.id) * 0.01 
                                FROM committees AS cmte_tbl) -- replace this line
;

-- Question 5
CREATE VIEW q5 (name, total_pac_donations) AS
  WITH full_comms(id, name) AS ( SELECT A.id, A.name
                                 FROM committees AS A
                                 GROUP BY A.id ), 
  indiv_cont(id, amt) AS ( SELECT B.cmte_id, SUM(B.transaction_amt)
                                FROM individual_contributions AS B
                                WHERE B.entity_tp = 'ORG'
                                GROUP BY B.cmte_id)
  SELECT full_comms.name,indiv_cont.amt
  FROM full_comms
  LEFT OUTER JOIN indiv_cont 
    ON full_comms.id = indiv_cont.id -- replace this line
;

-- Question 6
CREATE VIEW q6 (id) AS
  WITH comm1 AS ( SELECT A.cand_id
                   FROM committee_contributions AS A
                   WHERE A.cand_id IS NOT NULL
                     AND A.entity_tp = 'PAC'
                   GROUP BY A.cand_id ), 
  comm2 AS ( SELECT B.cand_id
             FROM committee_contributions AS B
             WHERE B.cand_id IS NOT NULL
              AND B.entity_tp = 'CCM'
             GROUP BY B.cand_id)
  SELECT DISTINCT comm1.cand_id
  FROM comm1
  INNER JOIN comm2
    ON comm1.cand_id = comm2.cand_id
;

-- Question 7
CREATE VIEW q7 (cand_name1, cand_name2) AS
    WITH tbl1(cmte_id,cand_id,name) AS (SELECT comm_cont.cmte_id, comm_cont.cand_id, cands.name
          FROM committee_contributions AS comm_cont, candidates AS cands
          WHERE comm_cont.state = 'RI'
            AND cands.id  = comm_cont.cand_id), tbl2(cmte_id,cand_id,name) AS (SELECT comm_cont.cmte_id, comm_cont.cand_id, cands.name
          FROM committee_contributions AS comm_cont, candidates AS cands
          WHERE comm_cont.state = 'RI'
            AND cands.id  = comm_cont.cand_id)
    SELECT DISTINCT tbl1.name,tbl2.name
    FROM tbl1
    INNER JOIN tbl2
      ON  tbl1.cmte_id  = tbl2.cmte_id
      AND tbl1.cand_id != tbl2.cand_id -- replace this line
;
