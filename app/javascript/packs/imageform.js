preview  = document.querySelector('.image-upload img')
uploader = document.querySelector('.image-upload input');

uploader.onchange = function(e) {
  var reader = new FileReader();
  reader.onloadend = function() {
    preview.src = reader.result;
  }
  reader.readAsDataURL(uploader.files[0]);
}
