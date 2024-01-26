function doLike(pid,uid)
{
    console.log(pid +","+ uid)
//   create object which data that we requiere
    const d={
        uid:uid,
        pid:pid,
        operation:'like'
    }
    $.ajax({
        url:"LikeServlet",
        data:d,
        success:function (data,textStatus,jqXHR){
            console.log(data);
            console.log("success");
            if(data.trim()=='true')
            {
                let c=$(".like-counter").html();
                c++;
                $('.like-counter').html(c);
            }
        },
        error:function(jqXHR,textStatus,errorThrown)
        {
            
            console.log("errorrr");
        }
        
        
    })
}


