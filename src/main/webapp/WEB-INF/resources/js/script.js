   $(document).ready(function(){
      $(".nav-elementt").click(function(){
        $(".nav-elementt").each(function(){
          $(this).removeClass("active-nav")
        })
        $(this).addClass("active-nav")
      });   
    });
   