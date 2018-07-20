package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONObject;

public class UserDAO {
	public static String registerUser(String name,String email){
		String query="select * from "+DBDetails.USER_TABLE+" where "+DBDetails.EMAIL_COL+"=?";
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,email);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				return "registered";
			}
			
		/*	query="insert into "+DBDetails.USER_TABLE+" ("+DBDetails.NAME_COL+","+DBDetails.EMAIL_COL+") values(?,?)";
			ps=con.prepareStatement(query);
			ps.setString(1,name);
			ps.setString(2,email);
			
			int result=ps.executeUpdate();
			
			ps.close();
			con.close();*/
			
			//if(result>0){
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "false";
	}
	public static String putData(String name,String email)
	{   String query="select * from "+DBDetails.USER_TABLE+" where "+DBDetails.EMAIL_COL+"=?";
	
	
		Connection con=DBConnect.getConnection();
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(query);
		
		ps.setString(1,email);
		
		ResultSet rs=ps.executeQuery();
		
		if(rs.next()){
			return "registered";
		}
		
		
		query="insert into "+DBDetails.USER_TABLE+" ("+DBDetails.NAME_COL+","+DBDetails.EMAIL_COL+") values(?,?)";
		ps=con.prepareStatement(query);
		ps.setString(1,name);
		ps.setString(2,email);
		
		int result=ps.executeUpdate();
		
		ps.close();
		con.close();
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "true";
		
	}
	
	public static String getQuestion(String question_no,String set){
		String query="select * from "+DBDetails.QUESTION_TABLE+" where "+DBDetails.SET_COL+"=?";
		JSONObject obj=new JSONObject();

		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,set);
			ResultSet rs=ps.executeQuery();
			ResultSet rs1=null;
			
			if(rs.next()){
				rs.absolute(Integer.parseInt(question_no));
				obj.put("question", rs.getString(DBDetails.TEXT_COL));
				obj.put("id", rs.getString(DBDetails.ID_COL));
				
				query="select * from "+DBDetails.CHOICE_TABLE+" where "+DBDetails.QUESTION_ID_COL+"=?";
				ps=con.prepareStatement(query);
				ps.setString(1,rs.getString(DBDetails.ID_COL));
				rs1=ps.executeQuery();
				
				if(rs1.next()){
					rs1.absolute(1);
					obj.put("a", rs1.getString(DBDetails.TEXT_COL));
					
					rs1.absolute(2);
					obj.put("b", rs1.getString(DBDetails.TEXT_COL));
					
					rs1.absolute(3);
					obj.put("c", rs1.getString(DBDetails.TEXT_COL));
					
					rs1.absolute(4);
					obj.put("d", rs1.getString(DBDetails.TEXT_COL));
				}
			}
			
			ps.close();
			rs.close();
			rs1.close();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return obj.toString();
	}
	
	public static void setResult(String id,LinkedHashMap lhm){
		String query="insert into "+DBDetails.RESULT_TABLE+" ("+DBDetails.ANSWER_COL+","+DBDetails.QUESTION_ID_COL+","+DBDetails.USER_ID_COL+") values(?,?,?)";
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps;
			Set set=lhm.entrySet();
			Iterator it=set.iterator();
			
			while(it.hasNext()){
				Map.Entry m=(Map.Entry)it.next();
				
				ps=con.prepareStatement(query);
				ps.setString(1,m.getValue().toString());
				ps.setString(2,m.getKey().toString());
				ps.setString(3,id);
				
				ps.executeUpdate();
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static String getUserID(String email){
		String query="select * from "+DBDetails.USER_TABLE+" where "+DBDetails.EMAIL_COL+"=?";
		String id="";
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,email);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				id=rs.getString(DBDetails.ID_COL);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return id;
	}
}