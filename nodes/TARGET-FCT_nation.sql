@id("c060cca4-f850-4ee3-b2f5-4149cc155078")
@nodeType("SQL:::SQLFact")
SELECT
    `N_NATIONKEY`                        AS `N_NATIONKEY`        @id("0abda8"),
    `N_NAME`                             AS `N_NAME`             @id("12a43c"),
    `N_REGIONKEY`                        AS `N_REGIONKEY`        @id("2e18de"),
    `N_COMMENT`                          AS `N_COMMENT`          @id("f88b9e"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS `SYSTEM_CREATE_DATE` @id("0cce23") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS `SYSTEM_UPDATE_DATE` @id("0489bd") @isSystemUpdateDate
FROM {{ ref('SRC', 'nation') }} `nation`