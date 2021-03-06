
var ImageController = SingleModelController.createComponent("ImageController");

ImageController.createViewFragment = function () {
  return cloneTemplate("#template-image");
};

ImageController.defineAlias("model", "fileHandler");

ImageController.defineMethod("initView", function initView() {
  if (!this.view) return;

});

ImageController.defineMethod("updateView", function updateView() {
  if (!this.view) return;

  var parentNode = this.view.parentNode;
  var fragment = ImageController.createViewFragment();
  var element = fragment.querySelector(".image");
  parentNode.replaceChild(fragment, this.view);
  this.uninitView();
  this._view = element;
  this.initView(false);

  // Update the source of the view
  var img = this.view.querySelector(".image-view");
  img.src = this.fileHandler.blob
    ? this.fileHandler.blob instanceof Blob
      ? this.fileHandler.url
      : this.fileHandler.url + "?width=" + (img.offsetWidth * this.devicePixelRatio)
    : "";
});

ImageController.defineMethod("uninitView", function uninitView() {
  if (!this.view) return;

});
