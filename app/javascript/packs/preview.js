if (document.URL.match( /users/ ) || document.URL.match( /plans/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const NewImage = document.getElementById('new-image');
    document.getElementById('user_image').addEventListener('change', function(e){ //ここに'plan_image'を入れたい
      // const imageContent = document.querySelector('img');
      if (NewImage){
        // imageContent.remove();
        NewImage.innerHTML = '';
      }
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.classList.add('preview-size');
      imageElement.appendChild(blobImage);
      NewImage.appendChild(imageElement);
    });
  });
}