// Submit the form when type enter
$('#message_content').on("keypress", function(e) {
     var code = (e.keyCode ? e.keyCode : e.which);
     if (code == 13) {
        e.preventDefault();
        e.stopPropagation();
        $(this).closest('form').submit();
     }
});