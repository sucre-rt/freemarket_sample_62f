$(function(){
  $('.image-list').hover(
    function(){
      var big = $('.product-box-content__product-main-content__product-image__big');
      var imageList = $(this).addClass('image-list-active');
      var index = imageList.index();

      if(!big.hasClass('sliding')) {
        big.addClass('sliding').animate({
          'scrollLeft': index * 300
        }, {
          'complete': function() {
            big.removeClass("sliding");
          }
        }, 500);
      }
    },
    function(){
      $(this).removeClass('image-list-active')
    }
  );
})

//ここからセレクトボックス
// $(function(){

//   function appendOption_c(category){
//     var html = `<option value="${category.id}">${category.name}</option>`;
//     return html;
//   }
//   function appendOption_d(delivery){
//     var html = `<option value="${delivery.id}">${delivery.responsibility}</option>`
//     return html;
//   }

//   function appendChidrenBox(insertHTML){ // 子セレクトボックスのhtml作成
//     var childSelectHtml = '';
//       childSelectHtml = `<div class='product-select-wrapper' id= 'children_wrapper'>
//                         <div class='product_category-select'>
//                         <select class="category_select-box" id="child_category" name="product[category_id]">
//                         <option value="---">---</option>
//                         ${insertHTML}
//                         </select>
//                         </div>
//                         <div class= 'select-grandchildren'>
//                         </div>
//                         </div>`;
//     $('.select-children').append(childSelectHtml);
//   }

//   function appendgrandChidrenBox(insertHTML){ // 孫セレクトボックスのhtml作成
//     var grandchildrenSelectHtml = '';
//     grandchildrenSelectHtml = `<div class='product-select-wrapper' id= 'grandchildren_wrapper'>
//                               <div class='product_category-select'>
//                               <select class="category_select-box" id="grandchild_category" name="product[category_id]">
//                               <option value="---">---</option>
//                               ${insertHTML} 
//                               </select>
//                               </div>
//                               <div class= 'product_select-grandchildren'>
//                               </div>
//                               </div>`;
//     $('.select-grandchildren').append(grandchildrenSelectHtml);
//   }

//   function appendDeliveryChildrenBox(insertHTML){
//     var deliverychildrenSelectHtml = '';
//     deliverychildrenSelectHtml = `<div class="form-group" id="form-group_children">
//                                   <label>
//                                   配送の方法
//                                   <span class="form-require">必須</span>
//                                   </label>
//                                   <div>
//                                   <div class="select-wrap">
//                                   <i class="icon-arrow-bottom"></i>
//                                   <select class="select-default" id="delivery_children" name="product[delivery_id]"><option value="">---</option>
//                                   ${insertHTML}
//                                   </select>
//                                   </div>
//                                   </div>
//                                   </div>
//                                   <div class="form-group_children></div>"`
//     $(".form-group_children").append(deliverychildrenSelectHtml);
//   }



//   $(document).on('change', '#category_select', function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
//     var productcategory = document.getElementById('category_select').value; //
//   // ↑ productcategoryに選択した親のvalueを代入
//     if (productcategory != ''){
//  // ↑ productcategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
//       $.ajax({
//         url: 'category_children',
//         type: 'GET',
//         data: { productcategory: productcategory },
//         dataType: 'json'
//       })
//       .done(function(children){  // 送られてきたデータをchildrenに代入
//         var insertHTML = '';
//         children.forEach(function(child){  
//   // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
//           insertHTML += appendOption_c(child); 
//         });
//         appendChidrenBox(insertHTML); 
//         $(document).on('change', '#category_select', function(){
//   // 通信成功時に親の選択肢を変えたらイベント発火｡子と孫を削除｡selectのidにかけるのではなく､親要素にかけないと残ってしまう
//           $('#children_wrapper').remove(); 
//           $('#grandchildren_wrapper').remove();
//         })
//       })
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       })
//     }
//   });


//   // document､もしくは親を指定しないと発火しない
//   $(document).on('change', '#child_category', function(){
//     var productcategory = document.getElementById('child_category').value;
//     if (productcategory != ''){
//     $.ajax ({
//       url: 'category_grandchildren',
//       type: 'GET',
//       data: { productcategory: productcategory },
//       dataType: 'json'
//     })
//     .done(function(grandchildren){
//       var insertHTML = '';
//       grandchildren.forEach(function(grandchild){
//         insertHTML += appendOption_c(grandchild);
//         });
//         appendgrandChidrenBox(insertHTML);  
//         $(document).on('change', '#child_category',function(){
//           $('#grandchildren_wrapper').remove();
//           })
//         })  
//         .fail(function(){
//           alert('カテゴリー取得に失敗しました');
//         })
//     }
//   });

//   $(document).on('change', '#delivery_select', function(){
//     var productdelivery = document.getElementById('delivery_select').value;

//     if (productdelivery != ''){

//       $.ajax ({
//         url: 'delivery_children',
//         type: 'GET',
//         data: { productdelivery: productdelivery },
//         dataType: 'json'
//       })

//       .done(function(deliveries){
//         var insertHTML = '';
//         deliveries.forEach(function(delivery){
//           insertHTML += appendOption_d(delivery);
//         });
//         appendDeliveryChildrenBox(insertHTML);
//         $(document).on('change', '#delivery_select',function(){
//           $('#form-group_children').remove();
//         })
//       })
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       })
//     }
//   });

// });
//ここまでセレクトボックス

//ここから画像プレビュー
$(function(){
  let dropzone = $('.sell-dropbox-container.clearfix.state-image-number-10');
  let dropzone2 = $('.sell-dropbox-container.clearfix.state-image-number-102');
  let images = [];
  let inputs  =[];
  let input_area = $('.sell-upload-drop-box.have-item-0');
  let preview = $('#preview');
  let preview2 = $('#preview2');
  let flex = $('#display-flex_box')
  let flex2 = $('#display-flex_box2')

  $(document).on('change', 'input[type= "file"]',function(event) {
    let file = $(this).prop('files')[0];
    let reader = new FileReader();
    inputs.push($(this));

    let img = $(`<div class="sell-upload-item">
                <div class= "img_view"><img width="116" height="65"></div></div>
                `);

    reader.onload = function(e) {
      let btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      // preview.append(box)
      img.find('img').attr({
        src: e.target.result
      })
    }

    reader.readAsDataURL(file);
    images.push(img); //配列にimgを入れる

    if(images.length == 5) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      flex2.css({
        'display': 'flex'
      })
    }
    if(images.length >= 6){
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        let data = image.data('image')
        if (data >= 5){
          preview2.append(image);
          dropzone.css({
            'width': `calc(100% - (116px * ${images.length - 5}))`
          })
        }
      })
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          if (image.find("data-image") == 6) {
            preview2.append(image);
          };
          preview.append(image);
          
        })
        dropzone.css({
          'width': `calc(100% - (116px * ${images.length}))`
        })
      }
    if(images.length == 10) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="images[:image][]" class="sell-upload-drop-file" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });

  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 10) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ここをクリックしてください</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 3) {
      dropzone.find('i').replaceWith('<p>ここをクリックしてください</p>')
    }
  })
});
//ここまで画像プレビュー
