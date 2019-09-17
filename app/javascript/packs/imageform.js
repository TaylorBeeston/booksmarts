preview  = document.querySelector('#cover-preview')
uploader = document.querySelector('#book_cover');

uploader.onchange = function(e) {
  var reader = new FileReader();
  reader.onloadend = function() {
    preview.src = reader.result;
  }
  reader.readAsDataURL(uploader.files[0]);
}
