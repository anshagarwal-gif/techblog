<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">

<% 
    User uuu=(User)session.getAttribute("currentUser");
Thread.sleep(100);
PostDao d=new PostDao(ConnectionProvider.getConnection());
int cid=Integer.parseInt(request.getParameter("cid"));
List<Post> posts=null;
if(cid==0){
 posts=d.getAllPosts();
    }
    else{
    posts=d.getPostByCatid(cid);
    }
    if(posts.size()==0)
    {
    out.println("<h3 class='display-3 text-center'>NO Post available</h3>");
    return;
    }
for(Post p:posts)
{
%>
<div class="col-md-6 mt-2">
    <div class="card">
        <img src="blog_pics/<%=p.getpPic()%>" class="card-img-top" alt="...">
        <div class="card-body">
            <b><%= p.getpTitle()%></b>
            <p><%=p.getpContent()%></p>
            
        </div>
             
        
            <div class="card-footer primary-background text-center">
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More</a>
               <% 
                        LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                        %>
                
                <a href="#!" onclick="doLike(<%=p.getPid()%>,<%=uuu.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>10</span></a>
               
            </div>
    </div>    
    
    
    
    
    </div>
<%}
    %>
</div>
