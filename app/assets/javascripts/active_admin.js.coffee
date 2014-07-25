#= require active_admin/base
#
#= require vendor/filepicker
#
#= require vendor/jquery.ui.widget
#= require vendor/jquery.fileupload

$ ->
  $("input:file.directUpload").each (i, elem) ->
    fileInput = $(elem)
    form = $(fileInput.parents("form:first"))
    submitButton = form.find("input[type=\"submit\"]")
    progressBar = $("<div class='bar'></div>")
    barContainer = $("<div class='progress'></div>").append(progressBar)
    fileInput.after barContainer
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

      start: (e) ->
        submitButton.prop "disabled", true
        progressBar.css("background", "green").css("display", "block").css("width", "0%").text "Loading..."

      done: (e, data) ->
        submitButton.prop "disabled", false
        progressBar.text "Uploading done"

        # extract key and generate URL from response
        key = $(data.jqXHR.responseXML).find("Key").text()
        url = "//#{fileInput.data('host')}/#{key}"

        # create hidden field
        input = $("<input />",
          type: "hidden"
          name: fileInput.attr("name")
          value: url
        )
        form.append input

        if url.substr(-3,3).toLowerCase == "jpg"
          image = $("<img />", src: url, width: 150, height: 150)
          fileInput.parent.append image

      fail: (e, data) ->
        submitButton.prop "disabled", false
        progressBar.css("background", "red").text "Failed"

