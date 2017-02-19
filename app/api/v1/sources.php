<?php

  require_once(DIR_ROOT . "/lib/sources.php");

  $REQUEST_BODY = file_get_contents("php://input");
  if ($REQUEST_BODY && $REQUEST_METHOD == "GET") $REQUEST_METHOD = "POST";
  if (isset($_SERVER["CONTENT_TYPE"])) {
    switch ($_SERVER["CONTENT_TYPE"]) {
      case "application/json":
        $REQUEST_DATA = json_decode($REQUEST_BODY, true);
        break;
      default:
        $REQUEST_DATA = $REQUEST_BODY;
    }
  } else $REQUEST_DATA = $REQUEST_BODY;

  if (handle(["jointsources"])) switch ($REQUEST_METHOD) {

    case "GET":

      $data = \ICA\Sources\getJointSources();
      respondJSON($data);

      break;

    case "POST": \Session\requireVerification();

      // Validation
      if (!$REQUEST_DATA) throw new Error("No request data");
      if (empty($REQUEST_DATA["meta"]) || empty($REQUEST_DATA["meta"]["*"]))
        throw new Exception("Metadata must not be empty");
      if (empty($REQUEST_DATA["meta"]["*"]["title"])) throw new Exception("Untitled");
      if (empty($REQUEST_DATA["sources"])) throw new Exception("Must be at least one source");

      $DATABASE->autocommit(false);

      $jointSource = new \ICA\Sources\JointSource;
      $jointSource->meta = $REQUEST_DATA["meta"];

      $jointSourceId = \ICA\Sources\insertJointSource($jointSource);

      $dataSources = [];
      // For each source
      foreach ($REQUEST_DATA["sources"] as $requestDataSource) {
        $source = new \ICA\Sources\Source;
        $source->type = $requestDataSource["type"];
        $source->content = $requestDataSource["content"];

        $sourceId = \ICA\Sources\insertSource($jointSourceId, $source);

        $dataSources[$sourceId] = [
          "_id" => $requestDataSource["_id"]
        ];
      }

      $result = $DATABASE->commit();
      if (empty($result)) throw new \Exception($DATABASE->error);

      respondJSON([$jointSourceId => [
        "_id" => $REQUEST_DATA["_id"],
        "sources" => $dataSources
      ]]);

      break;

  } elseif (list($jointSourceId) = handle(["jointsources", REQUEST_PARAMETER])) switch ($REQUEST_METHOD) {

    case "PUT": \Session\requireVerification();

      // Validation
      if (!$REQUEST_DATA) throw new Error("No request data");
      if (empty($REQUEST_DATA["meta"]) || empty($REQUEST_DATA["meta"]["*"]))
        throw new Exception("Metadata must not be empty");
      if (empty($REQUEST_DATA["meta"]["*"]["title"])) throw new Exception("Untitled");

      \ICA\Sources\insertJointSourceMetaRevision($jointSourceId, $REQUEST_DATA["meta"]);

      respondJSON([]);

      break;

    case "DELETE":

      \ICA\Sources\insertJointSourceState($jointSourceId, STATE_UNPUBLISHED);

      respondJSON([]);

      break;

  } elseif (list($jointSourceId) = handle(["jointsources", REQUEST_PARAMETER, "sources"])) switch ($REQUEST_METHOD) {

    case "POST": \Session\requireVerification();

      $source = new \ICA\Sources\Source;
      $source->type = $REQUEST_DATA["type"];
      $source->content = $REQUEST_DATA["content"];

      $sourceId = \ICA\Sources\insertSource($jointSourceId, $source);

      respondJSON([$sourceId => [
        "_id" => $REQUEST_DATA["_id"]
      ]]);

      break;

  } elseif (list($jointSourceId, $sourceId) = handle(["jointsources", REQUEST_PARAMETER, "sources", REQUEST_PARAMETER])) switch ($REQUEST_METHOD) {

    case "PUT": \Session\requireVerification();

      \ICA\Sources\insertJointSourceContentRevision($sourceId, $REQUEST_DATA["content"]);

      respondJSON([]);

      break;

    case "DELETE": \Session\requireVerification();

      \ICA\Sources\insertSourceState($sourceId, STATE_UNPUBLISHED);

      respondJSON([]);

      break;

  }

?>
