/* global e */

if (document.URL.match( /users/ ) || document.URL.match( /plans/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const NewImage = document.getElementById('new-image');

    const user_image_element = document.getElementById('user_image');
    const plan_image_element = document.getElementById('plan_image');
    const content_image_element = document.getElementById('content_image');

    if(user_image_element){
      user_image_element.addEventListener('change', function(e){ callback(e) } );
    }
    if(plan_image_element){
      plan_image_element.addEventListener('change', function(e){ callback(e) } );
    }
    if(content_image_element){
      content_image_element.addEventListener('change', function(e){ callback(e) } );
    }

    // document.getElementById('plan_image').addEventListener('change', callback(e));

    function callback(e){ //ここに'plan_image'を入れたい
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
    };
  });
}