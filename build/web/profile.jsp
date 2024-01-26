 <%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.message"%>
<%-- 
    Document   : profile
    Created on : Oct 7, 2023, 4:51:33 AM
    Author     : hp
--%>
<%@page import="com.tech.blog.entities.User" %>
<%@page errorPage="errorhandling.jsp" %>
<% 
    User user=(User)session.getAttribute("currentUser");
    if(user==null)
    {
    response.sendRedirect("login_page.jsp");
}%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/css.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
           body{
                background: url(images/back.jpg);
                background-size: cover;
                background-attachment: fixed;
                
            }
             
            .banner-background{
                
                
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 81%, 70% 100%, 28% 88%, 0 95%, 0 0);
            }
            
            
        </style>
    
    </head>
    <body>
     <nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>TECH BLOG</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
          <a class="nav-link" href="#"> <span class="fa fa-bell-o"></span>Learn Code with Ansh <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
          <a class="nav-link" href="#"> <span class="fa fa-mobile"></span>Contact</a>
          
      </li>
       <li class="nav-item">
          <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-mobile"></span>DO POST</a>
          
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expa nded="false">
            <span class="fa fa-check-square-o"></span> Categories
        </a>
          
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Programming Language</a>
          <a class="dropdown-item" href="#">Project Implimentation</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Data Structure</a>
        </div>
      </li>
       <li class="nav-item">
           <a class="nav-link" href="login_page.jsp"> <span class="fa fa-user-circle-o"></span> Logout</a>
       </li>
    </ul>
      
<!--      <li class="nav-item">
        <a class="nav-link">More.. </a>
      </li>-->
          <ul class="navbar-nav-mr-right ">
          <a class="nav-link text-white" href="#!" data-toggle="modal" data-target="#profile-modal"> <span class="fa fa-user-circle text-white"></span><%=user.getName()%></a>
      </ul>
          <ul class="navbar-nav-mr-right " >
          <a class="nav-link text-white" href="LogoutServlet"> <span class="fa fa-user-circle-o text-white"></span> Logout</a>
          
      </ul>
  </div>
</nav>
<!--end of navbar-->
<% 
//                                fetch message from login page
                            message m=(message)session.getAttribute("msg");
                            if(m!=null)
                            { 
                            %>
                             <div class="alert alert-danger" role="alert">
                                 <%=m.getContent() %>
                            </div>
                             <% session.removeAttribute("msg");}%>
                             
                <!--main body of the page-->
                <main>
                    <div class="container">
                        <div class="row mt-4">
                            <!--first col-->
                            <div class="col-md-4">
                                <!--categories-->
                                
                                <div class="list-group">
  <a href="#" onclick="getPosts(0,this)"class="c-link list-group-item list-group-item-action active" aria-current="true">
    All Post
  </a>
    <% 
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    ArrayList<Category> list1=d.getAllCategories();
    for(Category cc:list1)
    {
    %>
    <a href="#" onclick="getPosts(<%= cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%= cc.getName()%></a>
    
    <%
        }
    %>                                
  
  
</div>
                                
                            </div>
                            <!--second col-->
                            <div class="col-md-8" >
                                <!--post-->
                                <div class="container text-center" id="loader">
                                    <i class="fa fa-refresh fa-4x fa-spin">
                                        
                                        
                                    </i>
                                    <h3 class="mt-2">Loading...</h3>
                                    
                                    
                                </div>  
                                <div class="conatiner-fluid" id="post-container">
                                    
                                    
                                    
                                </div>
                                
                            </div>
                            
                            
                            
                        </div>
                        
                        
                        
                        
                    </div>
                    
                    
                    
                </main>
                
                <!--end main body of page-->

<!--start of modal-->


<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header primary-background text-white text-center">
        <h5 class="modal-title" id="exampleModalLabel">Tech Soft</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <div class="container text-center">
              
              <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius:50%;max-width:100px "
                   <br>
                   <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>
         <!--details-->
         <div id="profile-details">
         <table class="table">
  <tbody>
    <tr>
      <th scope="row">Id:</th>
      <td ><%= user.getId()%> </td>
    
     
    </tr>
    <tr>
      <th scope="row">Email :</th>
      <td ><%=user.getEmail()%></td>
    
     
    </tr>
    <tr>
      <th scope="row">Gender</th>
      <td> <%=user.getGender()%></td>
      
    </tr>
     <tr>
      <th scope="row">Status</th>
      <td ><%=user.getAbout()%></td>
    
    </tr>
  </tbody>
</table>
          
      
      </div>
          
      
      <!--profile edit-->
      
      <div id="profile-edit" style="display: none;">
          <h2>Edited</h2>
          <!--enctype is used when form contain image or vedio-->
          <form action="editServlet" method="post" enctype="multipart/form-data">
              <table class="table">
                  <tr>
                      <td>ID :</td>
                      <td><%=user.getId()%></td>
                  </tr>
                  <tr>
                      <td>Email :</td>
                      <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"</td>
                  </tr>
                  <tr>
                      <td>Name :</td>
                      <td><input type="text" class="form-control" name="user_name"value="<%=user.getName()%>"</td>
                  </tr>
                                    <tr>
                      <td>Password :</td>
                      <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"</td>
                  </tr>
                  <tr>
                      <td>Gender :</td>
                      <td><%=user.getGender()%></td>
                  </tr>
                   <tr>
                      <td>About :</td>
                      <td>
                          <textarea  rows="3"class="form-control" name="user_about"><%=user.getAbout()%></textarea></td>
                  </tr>
                   <tr>
                      <td>Profile Pic:</td>
                      <td>
                          <input type="file" name="image" class="form-control">
                          </td>
                  </tr>
                  
              </table>
                  <div class="container">
                      <button type="submit" class="btn btn-outline-primary">Save</button>
                  </div>
          </form>
          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
      </div>
    </div>
  </div>
</div>
  </div>
</div>
<!--end of modal-->

<!--add post modal-->

<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide the post </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         <form id="add-post-form" action="AddPostServlet" method="post">
             <div class="form-group">
                 <select class="form-control" name="cid">
                 <option selected disabled>---SELECT CATEGORY---</option>
                 <% 
                 PostDao postd=new PostDao(ConnectionProvider.getConnection());
                 ArrayList<Category> list=postd.getAllCategories();
                 for(Category c:list)
                 {
                 %>
                 <option value="<%= c.getCid()%>"><%=c.getName()%></option>
                 <%}
                     %>
             </select>
             </div>
              <div class="form-group">
                  <input type="text" name="pTitle" placeholder="Enter post Title" class="form-control"/>
                  
              </div>
              <div class="form-group">
                  <textarea class="form-control" name="pContent" placeholder="Enter your content" ></textarea>
              </div>
              <div class="form-group">
                  <textarea class="form-control" name="pCode" placeholder="Enter your program (IF ANY)" /></textarea>
              </div>
              <div class="form-group">
                  <label>Select your pic</label>
                  <br>
                  <input type="file" name="pic" placeholder="Enter your pic"/>
              </div>
             <div class="container text-center" >
                 <button type="submit" class="btn btn-outline-primary">Post</button>
             </div>
             
          </form> 
      </div>
     
    </div>
  </div>
</div>
<!--end post modal-->






   <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
       <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="js/js.js" type="text/javascript"></script>
<script>
    $(document).ready(function(){
      
//        toggle logic starts
        let editStatus=false;
        $('#edit-profile-button').click(function(){
            if(editStatus==false)
            {
            $("#profile-details").hide()
            $("#profile-edit").show();
            editStatus=true;
//            to change edit button
$(this).text("Back")
        }else
        {
            $("#profile-details").show()
            $("#profile-edit").hide();
            editStatus=false;
       $(this).text("Edit")
   }
//            toggle logic ends
        })
        
        
        
        
    });
    
    
    
    
    
</script>
<!--now add post js-->
<script>
    $(document).ready(function(e){
        //
        $("#add-post-form").on("submit",function(event){
            //this code get called when form is submitted...
            event.preventDefault();
            console.log("clicked")
            let form=new FormData(this);
                    //now requestin gto server
                    $.ajax({
                        url:"AddPostServlet",
                        type:'POST',
                        data:form,
                        success: function(data,textStatus,jqXHR){
                            console.log(data)
                            if(data.trim()=='done')
                            {
                                swal("Good job!", "You clicked the button!", "success");
                                
                            }else{
                                swal("Error!", "Something went wrong..", "error");
                            }
                        },
                        error: function(jqXHR,textStatus,errorThrown){
                            swal("Error!", "Something went wrong1..", "error");
                         },
                        processData:false,
                        contentType:false
                    })
        })
        
        
    })
    
    
    
</script>
<script>
//    loading post using ajax

function getPosts(catId,temp){
    $("#loader").show();
    $("#post-container").hide();
//    to remove blue color line on every catgory
    $(".c-link").removeClass('active')
     $.ajax({
        url:"laod_post.jsp",
        data:{cid:catId},
        success: function(data,textStatus,jqXHR){
            console.log(data);
            $("#loader").hide();
            $("#post-container").show();
            $("#post-container").html(data)
            $(temp).addClass('active')
        }
        
    })
}
$(document).ready(function (e){
//  intially blue line ona all Post
        let allPostRef=$('.c-link')[0]
        getPosts(0,allPostRef)
    
    
    
    
})
    
    
    
</script>
    </body>
</html>
