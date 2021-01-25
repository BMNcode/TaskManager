<#macro page>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="http://faviconka.ru/ico/faviconka_ru_12.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="http://faviconka.ru/ico/faviconka_ru_12.ico" type="image/x-icon" />
    <title>TaskManager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons">
    <style>
        body {
         padding: 5px;
        }
    </style>
</head>
<body>
<div class="container">
<#nested>
</div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://res.cloudinary.com/dxfq3iotg/raw/upload/v1567487539/jquery.tabledit.js"></script>

    <script type="text/javascript">
        $(".editTextStepName").hide();
        $(".saveTextStepName").hide();
        $(".cancelEditTextStepName").hide();
        $(".editButton").click(function(){
            $(this).parents("tr").find(".textStepName").toggle();
            $(this).parents("tr").find(".editTextStepName").toggle();
            $(this).parents("tr").find(".saveTextStepName").toggle();
            $(this).parents("tr").find(".cancelEditTextStepName").toggle();

        });
        $(".cancelEditTextStepName").click(function(){
                    $(this).parents("tr").find(".textStepName").toggle();
                    $(this).parents("tr").find(".editTextStepName").hide();
                    $(this).parents("tr").find(".saveTextStepName").hide();
                    $(this).parents("tr").find(".cancelEditTextStepName").hide();
        });
    </script>

    <script type="text/javascript">
        var maxHeight = 0;
        $('.cardsComment').each(function(){
          if ($(this).height() > maxHeight) {
            maxHeight = $(this).height();
          }
        });
        $('.cardsComment').each(function(){
          $(this).css('min-height', maxHeight + 'px');
        });
    </script>

</body>
</html>
</#macro>