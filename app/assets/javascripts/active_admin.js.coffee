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
    progressBar = $("<div class='bar'></div>")
    barContainer = $("<div class='progress'></div>").append(progressBar)

    fileUrlInput = $("<input />",
                      name: fileInput.attr("name"),
                      placeholder: 'or enter the url')
    fileInput.after fileUrlInput
    fileUrlInput.after barContainer

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
        progressBar.css("width", "#{progress}%").text "Uploading... #{progress}%"

      start: (e) ->
        submitButton.prop "disabled", true
        progressBar.css("background", "green").css("display", "block").css("width", "0%").text "Upload starting..."

      done: (e, data) ->
        submitButton.prop "disabled", false
        progressBar.text "Uploading done"

        # extract key and generate URL from response
        key = $(data.jqXHR.responseXML).find("Key").text()
        url = "//#{fileInput.data('host')}/#{key}"

        fileUrlInput.val(url)
        fileInput.val(null)

        if url.match /\.(jpg|png)$/i
          image = $("<img />", src: url).insertAfter fileUrlInput
          preview = $("<div class='crop-preview' />")
                      .insertAfter(fileUrlInput)
                      .append("<img src='#{url}'/>")
                      .children()
          crop_factor = $("##{fileInput.attr('id')}_crop_factor")

          image.Jcrop
            aspectRatio: 1
            minSize: [150, 150]
            setSelect: [0, 0, 150, 150]
            onChange: (coords)->
              crop_factor.val JSON.stringify coords
              rx = 150/coords.w
              ry = 150/coords.h

              preview.css
                width: "#{Math.round(rx*image.width())}px"
                height: "#{Math.round(ry*image.height())}px"
                marginLeft: "-#{Math.round(rx * coords.x)}px"
                marginTop: "-#{Math.round(ry * coords.y)}px"


      fail: (e, data) ->
        submitButton.prop "disabled", false
        progressBar.css("background", "red").text "Failed"

