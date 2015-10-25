$(document).ready(function(){
    $(".buy").unbind("click").click(function(){
        $.post("/posts/comment",
        {
          comment: { buy: true,
                     post_id: $(this).attr("value")}
        },
        function(data,status){
            //alert("post Data: " + data + "\nStatus: " + status);
            $.post("/posts/buyCount",
            {
              comment: { post_id: data}
            },
            function(data,status){
                //alert("get data buy: " + JSON.parse(data)["post_id"] + "\nStatus: " + status);
                data_array = JSON.parse(data);
                post_id = data_array["post_id"]
                buy = data_array["buy"]
                nbuy = data_array["nbuy"]
                html_string = "buy : "+buy+", don't buy : "+nbuy
                $("#"+post_id).html(html_string);
            });
        });
    });
});
