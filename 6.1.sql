-- 1.

SELECT from_user_id, count(*),
(SELECT firstname from users WHERE from_user_id = id) as name,
(SELECT lastname from users WHERE from_user_id = id) as lastname
FROM messages WHERE to_user_id = 1 
AND ((SELECT status FROM friend_requests WHERE initiator_user_id = 1 and target_user_id = from_user_id) or
(SELECT status FROM friend_requests WHERE initiator_user_id = from_user_id and target_user_id = 1) = 'approved')
GROUP BY from_user_id
ORDER BY count(*) DESC; 

-- 2.

 
SELECT count(*) as quantity
-- (SELECT user_id from media where id = media_id) as user_id,
-- (SELECT firstname FROM users where id = (SELECT user_id from media where id = media_id)) as firstname,
-- (SELECT lastname FROM users where id = (SELECT user_id from media where id = media_id)) as l,
-- (SELECT birthday from profiles where user_id = (SELECT id FROM users where id = (SELECT user_id from media where id = media_id))) as birthday
from likes
WHERE TIMESTAMPDIFF(YEAR, (SELECT birthday from profiles where user_id = 
(SELECT id FROM users where id = (SELECT user_id from media where id = media_id))), NOW()) < 12;


-- 3.
SELECT gender, count(*) 
FROM
(SELECT user_id as user, 
(SELECT gender from profiles WHERE user_id = user) as gender
FROM  likes) ppma
GROUP BY gender;  

