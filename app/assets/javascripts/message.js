$(function(){
  function buildHTML(message){
    let html = `<div class="Main__right__message__block">
                  <div class="Main__right__message__block-text">
                    ${message.text}
                  </div>
                  <div class="Main__right__message__block-info">
                    <div class="Main__right__message__block-info-name">
                      ${message.user_name}
                    </div>
                    <div class="Main__right__message__block-info-time">
                      ${message.created_at}
                    </div>
                  </div>
                </div> `
    return html
  }

  $('#text-form').on('submit',function(e){
    e.preventDefault()
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.Main__right__message').append(html);
      $('.Main__right__message').animate({scrollTop: $('.Main__right__message')[0].scrollHeight});
      $('.Main__right__form-text').val('');
      $('.Main__right__form-btn').prop('disabled', false)
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.Main__right__form-btn').prop('disabled', false)
    });
  })
});