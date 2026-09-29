# SolveSync LeetCode MySQL 검증 2026-09-29
SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;
