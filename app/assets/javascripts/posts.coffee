
$ ->
  $('.btn-settings').click ->
    id = $(this).attr("id")
    $('#modal'  + (id)).click ->
      $('#post-options' + (id)).foundation('close')

  $('#post_content').froalaEditor({

    imageUploadToS3: {
        bucket: 'hyrav2'
        region: 's3'
        keyStart: 'uploads/' + $('.temp_information').data('username') + '/'
        callback: (url, key) ->
          console.log (url)
          console.log (key)
     },

    params: {
        acl: 'public-read'
        AWSAccessKeyId: $('.temp_information').data('awskey')
        policy:  $('.temp_information').data('policy')
        signature: $('.temp_information').data('signature')
    }
  })