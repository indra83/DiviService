#= require active_admin/base
#
#= require vendor/jquery.ui.widget
#= require vendor/jquery.fileupload
#
#= require vendor/jquery.color
#= require vendor/jquery.Jcrop

$ ->
  $("input:file.directUpload").each (i, elem) ->
    fileInput = $(elem)
    form = $(fileInput.parents("form:first"))
    submitButton = form.find("input[type=\"submit\"]")
    progressBar = $("<div class='bar status_tag'>&nbsp;</div>")
    progressText = $("<div class='text status_tag'>Select file to upload</div>")
    barContainer = $("<div class='progress'>&nbsp;</div>").prepend(progressBar).prepend(progressText)


    fileUrlInput = $("<input />",
                      name: fileInput.attr("name"),
                      placeholder: 'or enter the url')
    fileInput.after fileUrlInput
    fileUrlInput.after barContainer

    crop_factor = $("##{fileInput.attr('id')}_crop_factor")
    if crop_factor.length > 0
      image = $("<img />").insertAfter crop_factor
      preview = $("<div class='crop-preview' />")
                  .insertAfter(crop_factor)
                  .append("<img />")
                  .children()
      jcrop_api = null
      jcropOpts =
        aspectRatio: 1
        minSize: [150, 150]
        onChange: (coords)->
          return unless jcrop_api
          crop_factor.val JSON.stringify coords
          rx = 150/coords.w
          ry = 150/coords.h
          image_size = jcrop_api.getBounds()

          preview.css
            width: "#{Math.round(rx*image_size[0])}px"
            height: "#{Math.round(ry*image_size[1])}px"
            marginLeft: "-#{Math.round(rx * coords.x)}px"
            marginTop: "-#{Math.round(ry * coords.y)}px"

      image.Jcrop jcropOpts, ->
        jcrop_api = this



    fileInput.fileupload
      fileInput: fileInput
      url: fileInput.data("url")
      type: "POST"
      autoUpload: true
      formData: fileInput.data("fields")
      paramName: "file" # S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType: "XML" # S3 returns XML if success_action_status is set to 201
      replaceFileInput: false
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        progressBar.css "width", "#{progress}%"
        progressText.text "Uploading... #{progress}%"

      start: (e) ->
        submitButton.prop "disabled", true
        progressBar.removeClass('red green').addClass('orange').css("width", "0%")
        progressText.text "Upload starting..."

      done: (e, data) ->
        submitButton.prop "disabled", false
        progressBar.removeClass('red orange').addClass('green')
        progressText.text "Uploading done"

        # extract key and generate URL from response
        key = $(data.jqXHR.responseXML).find("Key").text()
        url = "#{window.location.protocol}//#{fileInput.data('host')}/#{key}"

        fileUrlInput.val(url)
        fileInput.val(null)

        if jcrop_api
          preview.attr('src', url)
          if jcrop_api.tellSelect().w
            s = jcrop_api.tellSelect()
            select = [s.x, s.y, s.x2, s.y2]
          else
            select = [0,0,150,150]
          jcrop_api.setImage url, ->
            jcrop_api.setSelect select

      fail: (e, data) ->
        submitButton.prop "disabled", false
        progressBar.removeClass('orange green').addClass('red')
        progressText.text "Failed"

