<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/css/style.css" var="styleUrl"/>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="${styleUrl}">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
 <div class="container-fluid">
    <div class="row content">
	<jsp:include page="../views/menus/adminmenu.jsp"></jsp:include>

      <div class="col-sm-9">
      <br><br>
      <jsp:include page="../views/header/adminheader.jsp"></jsp:include>
      
        <div class="row" style="margin-left:15px">
        <div class="col-sm-3" style=" padding:0px; padding-right:10px; color:white">
           <div style=" background-color:#00b29e; border-radius:5px;">
            <div style="text-align:center; padding:25px; border-radius:5px; ">
              <i class="fa fa-automobile" style="font-size:61px;"></i>
              </span>
            </div>
            <div style="text-align:center; background-color:rgba(0, 0, 0, 0.0980392); padding:12px; border-radius:5px;  ">
             15 total cars
           </div>

         </div>
       </div>
       <div class="col-sm-3" style="padding:0px; padding-right:10px; color:white">
           <div style="background-color:#f56954; border-radius:5px;">
            <div style="text-align:center; padding:25px; border-radius:5px; ">
              <span style="font-size:4em" class="glyphicon glyphicon-send" aria-hidden="true">
              </span>
            </div>
            <div style="text-align:center; background-color:rgba(0, 0, 0, 0.0980392); padding:12px; border-radius:5px;  ">
             5 Reserved cars
           </div>

         </div>
       </div>
    <div class="col-sm-3" style="padding:0px; padding-right:10px; color:white">
           <div style="background-color:#0073b7; border-radius:5px;">
            <div style="text-align:center; padding:25px; border-radius:5px; ">
              <span style="font-size:4em" class="glyphicon glyphicon-send" aria-hidden="true">
              </span>
            </div>
            <div style="text-align:center; background-color:rgba(0, 0, 0, 0.0980392); padding:12px; border-radius:5px;  ">
             5 Reserved cars
           </div>

         </div>
       </div>
     <div class="col-sm-3" style="padding:0px; padding-right:10px; color:white">
           <div style="background-color:#303641; border-radius:5px;">
            <div style="text-align:center; padding:25px; border-radius:5px; ">
              <span style="font-size:4em" class="glyphicon glyphicon-send" aria-hidden="true">
              </span>
            </div>
            <div style="text-align:center; background-color:rgba(0, 0, 0, 0.0980392); padding:12px; border-radius:5px;  ">
             5 Reserved cars
           </div>

         </div>
       </div>
   </div>
   <hr>
   <h2>Officially Blogging</h2>
   <h5><span class="glyphicon glyphicon-time"></span> Post by John Doe, Sep 24, 2015.</h5>
   <h5><span class="label label-success">Lorem</span></h5><br>
   <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
   <hr>

   <h4>Leave a Comment:</h4>
   <form role="form">
    <div class="form-group">
      <textarea class="form-control" rows="3" required></textarea>
    </div>
    <button type="submit" class="btn btn-success">Submit</button>
  </form>
  <br><br>

  <p><span class="badge">2</span> Comments:</p><br>

  <div class="row">
    <div class="col-sm-2 text-center">
      <img src="bandmember.jpg" class="img-circle" height="65" width="65" alt="Avatar">
    </div>
    <div class="col-sm-10">
      <h4>Anja <small>Sep 29, 2015, 9:12 PM</small></h4>
      <p>Keep up the GREAT work! I am cheering for you!! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
      <br>
    </div>
    <div class="col-sm-2 text-center">
      <img src="bird.jpg" class="img-circle" height="65" width="65" alt="Avatar">
    </div>
    <div class="col-sm-10">
      <h4>John Row <small>Sep 25, 2015, 8:25 PM</small></h4>
      <p>I am so happy for you man! Finally. I am looking forward to read about your trendy life. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
      <br>
      <p><span class="badge">1</span> Comment:</p><br>
      <div class="row">
        <div class="col-sm-2 text-center">
          <img src="bird.jpg" class="img-circle" height="65" width="65" alt="Avatar">
        </div>
        <div class="col-xs-10">
          <h4>Nested Bro <small>Sep 25, 2015, 8:28 PM</small></h4>
          <p>Me too! WOW!</p>
          <br>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
</div>

<footer class="container-fluid">
  <p>Footer Text</p>
</footer>

</body>
</html>