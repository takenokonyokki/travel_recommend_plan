$(function(){
  function buildField(index) {
    const html = `<div class="js-file-group" data-index="${index}">
                    <div>
                      時間を選択
                      <input type="hidden" id="content_time_1i" name="content[time(1i)]" value="2022" autocomplete="off">
                      <input type="hidden" id="content_time_2i" name="content[time(2i)]" value="3" autocomplete="off">
                      <input type="hidden" id="content_time_3i" name="content[time(3i)]" value="29" autocomplete="off">
                      <select id="content_time_4i" name="content[time(4i)]">
                      <option value="00">00</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12" selected="selected">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      </select>
                       :
                      <select id="content_time_5i" name="content[time(5i)]">
                      <option value="00">00</option>
                      <option value="01">01</option>
                      <option value="02">02</option>
                      <option value="03">03</option>
                      <option value="04">04</option>
                      <option value="05">05</option>
                      <option value="06">06</option>
                      <option value="07">07</option>
                      <option value="08">08</option>
                      <option value="09">09</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                      <option value="13">13</option>
                      <option value="14">14</option>
                      <option value="15">15</option>
                      <option value="16" selected="selected">16</option>
                      <option value="17">17</option>
                      <option value="18">18</option>
                      <option value="19">19</option>
                      <option value="20">20</option>
                      <option value="21">21</option>
                      <option value="22">22</option>
                      <option value="23">23</option>
                      <option value="24">24</option>
                      <option value="25">25</option>
                      <option value="26">26</option>
                      <option value="27">27</option>
                      <option value="28">28</option>
                      <option value="29">29</option>
                      <option value="30">30</option>
                      <option value="31">31</option>
                      <option value="32">32</option>
                      <option value="33">33</option>
                      <option value="34">34</option>
                      <option value="35">35</option>
                      <option value="36">36</option>
                      <option value="37">37</option>
                      <option value="38">38</option>
                      <option value="39">39</option>
                      <option value="40">40</option>
                      <option value="41">41</option>
                      <option value="42">42</option>
                      <option value="43">43</option>
                      <option value="44">44</option>
                      <option value="45">45</option>
                      <option value="46">46</option>
                      <option value="47">47</option>
                      <option value="48">48</option>
                      <option value="49">49</option>
                      <option value="50">50</option>
                      <option value="51">51</option>
                      <option value="52">52</option>
                      <option value="53">53</option>
                      <option value="54">54</option>
                      <option value="55">55</option>
                      <option value="56">56</option>
                      <option value="57">57</option>
                      <option value="58">58</option>
                      <option value="59">59</option>
                      </select>
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
                      <p class="field" id="star" style="cursor: pointer;">
                      <label for="content_rate">評価：</label>
                      <input id="review_star" autocomplete="off" type="hidden" name="content[rate]">
                      <img alt="1" src="/assets/star-off-545623b9692f7e1a13280ea370b31bd9dd324abb4181f98497134795d012d472.png" title="bad">&nbsp;<img alt="2" src="/assets/star-off-545623b9692f7e1a13280ea370b31bd9dd324abb4181f98497134795d012d472.png" title="poor">&nbsp;<img alt="3" src="/assets/star-off-545623b9692f7e1a13280ea370b31bd9dd324abb4181f98497134795d012d472.png" title="regular">&nbsp;<img alt="4" src="/assets/star-off-545623b9692f7e1a13280ea370b31bd9dd324abb4181f98497134795d012d472.png" title="good">&nbsp;<img alt="5" src="/assets/star-off-545623b9692f7e1a13280ea370b31bd9dd324abb4181f98497134795d012d472.png" title="gorgeous"><input name="post[rate]" type="hidden"></p>
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