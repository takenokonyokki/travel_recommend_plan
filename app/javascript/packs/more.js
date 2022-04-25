const moreNum = 3;

$('.comment-list li:nth-child(n + ' + (moreNum + 1) + ')').addClass('is-hidden');
$('.more').on('click', function() {
  $('.comment-list li.is-hidden').slice(0, moreNum).removeClass('is-hidden');
  if ($('.comment-list li.is-hidden').length == 0) {
    $('.more').fadeOut();
  }
});