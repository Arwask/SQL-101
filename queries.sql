-- Query all of the entries in the Genre table

select *
from Genre

-- Using the INSERT statement, add one of your favorite artists to the Artist table.

INSERT into Artist
  (artistid, artistname, yearestablished)
values
  (29, "Artist1", 1990)

-- Using the INSERT statement, add one, or more, albums by your artist to the Album table.

INSERT into album
  (albumid, title, releasedate, albumlength, label, artistid, genreid)
values
  (25, "Hoola hoops", "3/7/1990", 458, "pop jam", 29, 7);

INSERT into album
  ( title, releasedate, albumlength, label, artistid, genreid)
SELECT "Hoola hoops", "3/7/1990", 458, "pop jam", ar.artistid, g.genreid
FROM artist ar, genre g
WHERE ar.artistname = "Artist1"
  AND g.label = "pop"


-- Using the INSERT statement, add some songs that are on that album to the Song table.

INSERT into song
  (songid, title, songlength, releasedate, genreid, artistid, AlbumId)
values
  (22, "Monkey biz", 110, "3/7/1990", 7, 29, 25);

INSERT into song
  (songid, title, songlength, releasedate, genreid, artistid, AlbumId)
--dynamic way to insert ids
SELECT "Monkey biz", 110, "3/7/1990", g.genreid, ar.artistid, al.albumid
FROM artist ar, genre g, album al
WHERE ar.artistname = "Artist1"
  AND g.label = "pop"
  AND al.title = "Hoola hoops"

-- Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added. Here is some more info on joins that might help.

SELECT s.title Song, a.title Album, r.artistname Artist
FROM song s
  LEFT JOIN album a
  ON(s.albumid = a.albumid)
  JOIN Artist r
  ON (a.artistid = r.artistid)
WHERE r.artistid = 29


SELECT s.title Song, a.title Album, r.artistname
FROM Artist r, album a
  LEFT JOIN song s
  ON(s.albumid = a.albumid)
WHERE r.artistname = "Artist1"
  AND r.Artistid = a.Artistid

-- Reminder: Direction of join matters. Try the following statements and see the difference in results.
-- SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.AlbumId;
-- SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.AlbumId;
-- Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(songid) AS "No. of Songs" , a.title Album
FROM song s, album a
WHERE s.albumid = a.albumid
GROUP BY s.albumid

-- Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(songid) AS "No. of Songs", r.artistname AS "Artist"
FROM song s, artist r
WHERE s.artistid = r.artistid
GROUP BY s.artistid

-- Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT COUNT(songid) AS "No. of Songs", g.label "Label"
FROM song s, genre g
WHERE s.genreid = g.genreid
GROUP BY s.genreid

-- Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

SELECT MAX(albumlength) AS "Longest Album", title
FROM album

-- Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.

SELECT MAX(songlength) AS "Longest Song", title
FROM song

-- Modify the previous query to also display the title of the album.

SELECT MAX(songlength) AS "Longest Song", s.title song, a.title album
FROM song s, album a
WHERE a.albumid = s.albumid