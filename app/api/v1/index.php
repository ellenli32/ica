<?php try {

  require_once(__DIR__ . "/init.php");

  if (handle(["jointsources"], true)) require_once(__DIR__ . "/jointsources.php");
  elseif (handle(["files"], true)) require_once(__DIR__ . "/files.php");
  elseif (handle(["themes"], true)) require_once(__DIR__ . "/themes.php");

  respondHeaderResponseCode(501, "Not Implemented");

  exit(json_encode([
    "error" => sprintf("Unhandled request: %s /%s/",
      $REQUEST_METHOD,
      implode("/", $REQUEST_PATH))
  ]));

} catch (Exception $e) {

  respondHeaderResponseCode(400, "Bad Request");

  exit(json_encode([
    "error" => isset($e) && $e
      ? $e->getMessage()
      : ""
  ]));

} ?>
