-- Average star rating by brand
SELECT brand,
       ROUND(AVG(star_rating), 2) AS avg_rating,
       COUNT(*) AS total_reviews
FROM caramel_reviews
GROUP BY brand
ORDER BY avg_rating DESC;

-- Sentiment breakdown by brand
SELECT brand,
       sentiment,
       COUNT(*) AS sentiment_count,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY brand), 1) AS percent_of_reviews
FROM caramel_reviews
GROUP BY brand, sentiment
ORDER BY brand;

-- Monthly sentiment count (used for line charts)
SELECT brand,
       SUBSTR(review_date, 7, 4) || '-' || SUBSTR(review_date, 1, 2) AS month,
       sentiment,
       COUNT(*) AS review_count
FROM caramel_reviews
GROUP BY brand, month, sentiment
ORDER BY brand, month;

-- Check for sentiment mismatches
SELECT *
FROM caramel_reviews
WHERE star_rating <= 2 AND sentiment = 'Positive';

-- Top positive review quotes per brand
SELECT brand, review_text
FROM caramel_reviews
WHERE sentiment = 'Positive' AND star_rating = 5
ORDER BY brand, review_date DESC;