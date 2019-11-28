$(function(){
  $('.image-list').hover(
    function(){
      $(this).addClass('image-list-active')
      let img = $(this).children('img').attr('src');
      $('.product-box-content__product-main-content__product-image__big').children('img').attr("src",img);
    },
    function(){
      $(this).removeClass('image-list-active')
    }
  );
})

//ここからajax通信
$(function(){

  function appendOption_c(category){ // optionの作成
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendOption_d(delivery){
    var html = `<option value="${delivery.id}">${delivery.responsibility}</option>`
    return html;
  }

  function appendChidrenBox(insertHTML){ // 子セレクトボックスのhtml作成
    var childSelectHtml = '';
      childSelectHtml = `<div class='product-select-wrapper' id= 'children_wrapper'>
                        <div class='product_category-select'>
                        <select class="category_select-box" id="child_category" name="product[category_id]">
                        <option value="---">---</option>
                        ${insertHTML}
                        </select>
                        </div>
                        <div class= 'select-grandchildren'>
                        </div>
                        </div>`;
    $('.select-children').append(childSelectHtml);
  }

  function appendgrandChidrenBox(insertHTML){ // 孫セレクトボックスのhtml作成
    var grandchildrenSelectHtml = '';
    grandchildrenSelectHtml = `<div class='product-select-wrapper' id= 'grandchildren_wrapper'>
                              <div class='product_category-select'>
                              <select class="category_select-box" id="grandchild_category" name="product[category_id]">
                              <option value="---">---</option>
                              ${insertHTML} 
                              </select>
                              </div>
                              <div class= 'product_select-grandchildren'>
                              </div>
                              </div>`;
    $('.select-grandchildren').append(grandchildrenSelectHtml);
  }

  function appendDeliveryChildrenBox(insertHTML){
    var deliverychildrenSelectHtml = '';
    deliverychildrenSelectHtml = `<div class="form-group" id="form-group_children">
                                  <label>
                                  配送の方法
                                  <span class="form-require">必須</span>
                                  </label>
                                  <div>
                                  <div class="select-wrap">
                                  <i class="icon-arrow-bottom"></i>
                                  <select class="select-default" id="delivery_children" name="product[delivery_id]"><option value="">---</option>
                                  ${insertHTML}
                                  </select>
                                  </div>
                                  </div>
                                  </div>
                                  <div class="form-group_children></div>"`
    $(".form-group_children").append(deliverychildrenSelectHtml);
  }



  $(document).on('change', '#category_select', function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
    var productcategory = document.getElementById('category_select').value; //
  // ↑ productcategoryに選択した親のvalueを代入
    if (productcategory != ''){
 // ↑ productcategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { productcategory: productcategory },
        dataType: 'json'
      })
      .done(function(children){  // 送られてきたデータをchildrenに代入
        var insertHTML = '';
        children.forEach(function(child){  
  // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
          insertHTML += appendOption_c(child); 
        });
        appendChidrenBox(insertHTML); 
        $(document).on('change', '#category_select', function(){
  // 通信成功時に親の選択肢を変えたらイベント発火｡子と孫を削除｡selectのidにかけるのではなく､親要素にかけないと残ってしまう
          $('#children_wrapper').remove(); 
          $('#grandchildren_wrapper').remove();
        })
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }
  });


  // document､もしくは親を指定しないと発火しない
  $(document).on('change', '#child_category', function(){
    var productcategory = document.getElementById('child_category').value;
    if (productcategory != ''){
    $.ajax ({
      url: 'category_grandchildren',
      type: 'GET',
      data: { productcategory: productcategory },
      dataType: 'json'
    })
    .done(function(grandchildren){
      var insertHTML = '';
      grandchildren.forEach(function(grandchild){
        insertHTML += appendOption_c(grandchild);
        });
        appendgrandChidrenBox(insertHTML);  
        $(document).on('change', '#child_category',function(){
          $('#grandchildren_wrapper').remove();
          })
        })  
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
    }
  });

  $(document).on('change', '#delivery_select', function(){
    var productdelivery = document.getElementById('delivery_select').value;

    if (productdelivery != ''){

      $.ajax ({
        url: 'delivery_children',
        type: 'GET',
        data: { productdelivery: productdelivery },
        dataType: 'json'
      })

      .done(function(deliveries){
        var insertHTML = '';
        deliveries.forEach(function(delivery){
          insertHTML += appendOption_d(delivery);
        });
        appendDeliveryChildrenBox(insertHTML);
        $(document).on('change', '#delivery_select',function(){
          $('#form-group_children').remove();
        })
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }
  });

});