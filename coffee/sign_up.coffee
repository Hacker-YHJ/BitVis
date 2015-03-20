do ->
  $(document).ready ->
    $('form').submit (e) ->
      e.preventDefault()
      console.log('submit')