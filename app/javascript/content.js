$(function(){
  function buildField(index) {
    const html = `<div class="js-file-group" data-index="${index}">
                    <div>
                      時間を選択<input type="text" name="content[time]" id="content_time">
                    </div>
                    <div>
                      行先<input type="text" name="content[place]" id="content_place">
                    </div>
                    <div>
                      写真<input accept="image/*" type="file" name="content[image_id]" id="content_image_id">
                    <div>
                    <div>
                      行先についての説明<textarea name="content[explanation]" id="content_explanation"></textarea>
                    </div>
                    <div>
                    　【観光地・店舗】の基本情報
                    　<p>名称：<input type="text" name="content[name]" id="content_name"></p>
                      <p>住所：<input type="text" name="content[address]" id="content_address"></p>
                      <p>電話番号：<input type="text" name="content[telephonenumber]" id="content_telephonenumber"></p>
                      <p>アクセス：<input type="text" name="content[access]" id="content_access"></p>
                      <p>営業時間：<input type="text" name="content[businesshours]" id="content_businesshours"></p>
                      <P>料金など：<input type="text" name="content[price]" id="content_price"></P>
                      <p>滞在時間：<input type="text" name="content[stay_time]" id="content_stay_time"></p>
                      <p>評価：☆☆☆☆☆</p>
                    </div>
                    <div>
                      <select name="content[move_id]" id="content_move_id"><option value="">移動手段を選択してください</option>
                        <option value="0">walk</option>
                        <option value="1">bicycle</option>
                        <option value="2">car</option>
                        <option value="3">taxi</option>
                        <option value="4">train</option>
                        <option value="5">bus</option>
                      </select>
                      <span><input type="text" name="content[move_time]" id="content_move_time">分</span>
                    </div>
                    <span class="delete-form-btn">
                      削除する
                    </span>
                  </div>`;
    return html;
  }

  let fileIndex = [1, 2, 3, 4]
  var lastIndex = $(".js-file-group:last").data("index");
  fileIndex.splice(0, lastIndex);
  let fileCount = $(".hidden-destroy").length;
  let displayCount = $(".js-file-group").length
  $(".hidden-destroy").hide();
  if (fileIndex.length == 0) $(".add-form-btn").css("display","none");

  $(".add-form-btn").on("click", function() {
    $(".content-area").append(buildField(fileIndex[0]));
    fileIndex.shift();
    if (fileIndex.length == 0) $(".add-form-btn").css("display","none");
    displayCount += 1;
  })

  $(".content-area").on("click", ".delete-form-btn", function() {
    $(".add-form-btn").css("display","block");
    const targetIndex = $(this).parent().parent().data("index")
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    var lastIndex = $(".js-file-group:last").data("index");
    displayCount -= 1;
    if (targetIndex < fileCount) {
      $(this).parent().parent().css("display","none")
      hiddenCheck.prop("checked", true);
    } else {
      $(this).parent().parent().remove();
    }
    if (fileIndex.length >= 1) {
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    } else {
      fileIndex.push(lastIndex + 1);
    }
    if (displayCount == 0) {
      $(".content-area").append(buildField(fileIndex[0] - 1));
      fileIndex.shift();
      displayCount += 1;
    }
  })
})