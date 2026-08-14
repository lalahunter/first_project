-- ============================================================
-- Unique Stays Curator — SQL Analysis
-- Business question: which property types and locations deserve the most marketing/partnership investment?
-- ============================================================
USE CrossDataHosts;

-- Query 1: Niche vs. Saturated Property Types
-- Which property types combine strong satisfaction (rating) and trong popularity (review count)? 
-- Only types with >=10 listing are considered reliable
SELECT
    p.property_type_name,
    COUNT(*) AS num_listings,
    ROUND(AVG(l.rating_value), 2) AS avg_rating,
    ROUND(AVG(l.amount_of_answers), 1) AS avg_reviews
FROM listing l
JOIN property p ON l.property_type_id = p.property_type_id
GROUP BY p.property_type_name
HAVING COUNT(*) >= 10
ORDER BY avg_reviews DESC;


-- Query 2: Which cities, in the US, have proven demand + satisfaction worth investing in Partnerships?
-- Scoped to the US market. A city needs >=5 listings to be a reliable one.
SELECT
    loc.city,
    loc.state,
    COUNT(*) AS num_listings,
    ROUND(AVG(l.rating_value), 2) AS avg_rating,
    ROUND(AVG(l.amount_of_answers), 1) AS avg_reviews
FROM listing l
JOIN locations loc ON l.location_id = loc.location_id
WHERE loc.country = 'US' OR (loc.country IS NULL AND loc.state IS NOT NULL)
GROUP BY loc.city, loc.state
HAVING COUNT(*) >= 5
ORDER BY avg_reviews DESC
LIMIT 10;


-- Query 3: 21 "Hidden Gem" Listings Worldwide — Proven Quality, Still Flying Under the Radar -> Prime Targets for Future Marketing Expansion
-- Scoped globally on purpose (unlike Query 2). Acommodations underpriced, high-rating, low-review listings 
-- as early evidence of opportunity beyond the US market.
SELECT
    p.property_type_name,
    loc.city,
    COALESCE(loc.country, 'US') AS country,
    l.price,
    l.rating_value,
    l.amount_of_answers
FROM listing l
JOIN property p ON l.property_type_id = p.property_type_id
JOIN locations loc ON l.location_id = loc.location_id
WHERE l.rating_value >= 4.9
  AND l.amount_of_answers BETWEEN 1 AND 20
  AND l.price < (SELECT AVG(price) FROM listing)
ORDER BY l.rating_value DESC, l.price ASC;


-- Query 4: Does Price Reflect Quality or Demand? — Weak Correlation
-- Confirms a Real Market Inefficiency
-- Important note: Pulls the raw values + the correlation itself is computed in Python 
-- (see 02_sql_analysis.ipynb
SELECT
    l.price,
    l.rating_value,
    l.amount_of_answers
FROM listing l
WHERE l.price IS NOT NULL AND l.rating_value IS NOT NULL AND l.amount_of_answers IS NOT NULL;