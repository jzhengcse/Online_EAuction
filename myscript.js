/*
 * $(document).ready(function(){
    $("input").click(function() {
        $(this).hide();
    });
})
*/

/* main page description */
$(function() {
            $("div.article h2").hover(function() {
                    $(this).siblings("p.description").delay("500").slideToggle("slow");
                    },function() {
                    $(this).siblings("p.description").slideToggle("slow");
                    })

        })

/* account tab*/
$(function() {
            $("ul.accountinfo li").hover(function() {
                var i=$(this).index();
                $(this).children().fadeToggle("fast");
            },function() {
                var i=$(this).index();
                $(this).children().fadeToggle("fast");
            });

        });

$(function() {
	$("#bidbutton").click(function() {
		var price=$("#bidprice").val();
		$.ajax({
			type:		"post",
			url:		"bid.jsp",
			data:		"price=" +price,
			success:	function(msg) {
			                    if(msg=='signin.jsp') {
				alert("Please Signin first");
                $(location).attr('href',msg)}

                    else
                    alert(msg);
			}
		});
	});
});

$(function() {
    $("#watchbutton").click(function() {
        $.ajax({
            type:       "post",
            url:        "watch.jsp",
            success:    function(msg) {
							if(msg=='signin.jsp') {
				alert("Please Signin first");
					$(location).attr('href',msg)}

						else
						alert(msg);
            }
        });
    });
});
$(function() {
    $("#buybutton").click(function() {
        $.ajax({
            type:       "post",
            url:        "buy.jsp",
            success:    function(msg) {
					if(msg=='signin.jsp')  {
				alert("Please Signin first");
				$(location).attr('href',msg)
					}

					else
					alert(msg);

			}
        });
    });
});

$(function() {
    $("#signin").click(function() {
		var email=$("#email").val();
		var password=$("#password").val();
        $.ajax({
            type:       "post",
            url:        "checksignin.jsp",
			data:		{"email": email,
						"password": password},
            success:    function(msg) {
				if(msg.search('myaccount.jsp')!=-1) {
					$(location).attr('href',msg)
				}else  {
					alert(msg);
				}
            }
        });
    });
});

$(function() {
    $("#signout").click(function() {
        $.ajax({
            type:       "post",
            url:        "signout.jsp",
            success:    function() {
				$(location).attr('href',"signin.jsp")
            }
        });
    });
});

$(function() {
    $("#addbutton").click(function() {
        var name=$("#name").val();
        var categoryid=$("#categoryid").val();
        var buyitnowprice=$("#buyitnowprice").val();
        var description=$("#description").val();
		var picture=$("#image").val();
		var picture=picture.replace("C:\\fakepath\\", "");
		var picture="images/"+picture;
        $.ajax({
            type:       "post",
            url:        "additem.jsp",
            data:       {"name": name,
                        "categoryid": categoryid,
						"buyitnowprice": buyitnowprice,
						"description": description,
						"picture": picture,
						},
            success:    function(msg) {
                    alert(msg);
                    //alert(picture);
            }
        });
    });
});


