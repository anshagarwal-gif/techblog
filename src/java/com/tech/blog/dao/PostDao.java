/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.dao;

/**
 *
 * @author hp
 */
import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category>list=new ArrayList<>();
        try{
            String q="select * from categories";
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(q);
            while(set.next())
            {
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                Category c=new Category(cid,name,description);
                list.add(c);
             
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }
   public boolean savePost(Post p)
                {
                    boolean f=false;
                    try{
                        String q="insert into post(pTitle,pContent,pCode,pPic,catId,userId) value(?,?,?,?,?,?)";
                        PreparedStatement pstmt=con.prepareStatement(q);
                        pstmt.setString(1,p.getpTitle());
                        pstmt.setString(2,p.getpContent());
                        pstmt.setString(3,p.getpCode());
                        pstmt.setString(4,p.getpPic());
                        pstmt.setInt(5,p.getCatId());
                        pstmt.setInt(6,p.getUserId());
                        pstmt.executeUpdate();
                        f=true;
                    }catch(Exception e)
                        
                    {
                        e.printStackTrace();
                    }
        return f;
                }
   
//   get all post
   public List<Post> getAllPosts()
   {
       List<Post> list=new ArrayList<>();
       //       fetch all post
       try{
        PreparedStatement p=con.prepareStatement("Select * from post order by pid desc");
        ResultSet set=p.executeQuery();
        while(set.next())
        {  
            
            int pid=set.getInt("pid");
            String pTitle=set.getString("pTitle");
            String pContent=set.getString("pContent");
            String pCode=set.getString("pCode");
            String pPic=set.getString("pPic");
            Timestamp date=set.getTimestamp("pDate");
            int catId=set.getInt("catId");
            int userId=set.getInt("userId");
            Post post=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
        list.add(post);
        
        }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       return list;
   }
   
   public List<Post> getPostByCatid(int catId)
   {
       List<Post> list=new ArrayList<>();
//       fetch all post by id
 try{
        PreparedStatement p=con.prepareStatement("Select * from post where catId=?");
       p.setInt(1,catId);
        ResultSet set=p.executeQuery();
        while(set.next())
        {  
            
            int pid=set.getInt("pid");
            String pTitle=set.getString("pTitle");
            String pContent=set.getString("pContent");
            String pCode=set.getString("pCode");
            String pPic=set.getString("pPic");
            Timestamp date=set.getTimestamp("pDate");

            int userId=set.getInt("userId");
            Post post=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
        list.add(post);
        
        }
       }catch(Exception e)
       {
           e.printStackTrace();
       }

       return list;
   }
   public  Post getPostbyPostId(int postId)
   { 
       Post post=null;
       
       String q="select * from post where pId=?";
       try{
       PreparedStatement p=this.con.prepareStatement(q);
       p.setInt(1,postId);
       ResultSet  set=p.executeQuery();
       if(set.next())
       {
            
            int pid=set.getInt("pid");
            String pTitle=set.getString("pTitle");
            String pContent=set.getString("pContent");
            String pCode=set.getString("pCode");
            String pPic=set.getString("pPic");
            Timestamp date=set.getTimestamp("pDate");
 int catId=set.getInt("catId");
            int userId=set.getInt("userId");
             post=new Post(pid,pTitle,pContent,pCode,pPic,date,catId,userId);
       
       
       }
       
       
   }
   catch(Exception e)
   {
       e.printStackTrace();
   }
   return post;
   }
}
