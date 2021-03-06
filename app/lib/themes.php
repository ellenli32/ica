<?php

  namespace ICA\Themes;

  require_once(__DIR__ . "/shared.php");

  /**
   * Returns a list of most frequent (time insensitive) themes.
   */
  function getThemesByFrequency($limit = 200) {

    $stateEncoded = STATE_PUBLISHED_ENCODED;
    $result = query("SELECT
        tbl_deleg.theme AS theme,
        COUNT(*) AS freq
      FROM jointsources_themes_summary AS tbl_deleg
      INNER JOIN jointsources_summary AS tbl_jointsource
        ON tbl_jointsource.jointsource_id = tbl_deleg.jointsource_id
        AND tbl_jointsource.state = {$stateEncoded}
      WHERE tbl_deleg.state = {$stateEncoded}
      GROUP BY theme
      ORDER BY freq DESC, theme ASC
      LIMIT {$limit};");

    return createArrayFromQueryResult($result, "theme");

  }

?>