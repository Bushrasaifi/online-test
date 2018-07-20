package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedHashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;



public class AdminDAO {
	public static String login(String email,String password){
		String query="select * from "+DBDetails.ADMIN_TABLE+" where "+DBDetails.EMAIL_COL+"=? and "+DBDetails.PASSWORD_COL+"=?";
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,email);
			ps.setString(2,password);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				return "true";
			}
			
			ps.close();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "false";
	}
	
	public static String addQuestion(String question,String a,String b,String c,String d,String set,String answer){
		String query="insert into "+DBDetails.QUESTION_TABLE+" ("+DBDetails.TEXT_COL+","+DBDetails.SET_COL+","+DBDetails.ANSWER_COL+") values(?,?,?)";
		int id=0;
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1,question);
			ps.setString(2,set);
			ps.setString(3,answer);
			
			ps.executeUpdate();
			ResultSet rs=ps.getGeneratedKeys();
			
			if(rs.next()){
				id=rs.getInt(1);
			}
			
			query="insert into "+DBDetails.CHOICE_TABLE+" ("+DBDetails.TEXT_COL+","+DBDetails.QUESTION_ID_COL+") values(?,?)";
			ps=con.prepareStatement(query);
			ps.setString(1,a);
			ps.setInt(2,id);
			ps.executeUpdate();
			
			query="insert into "+DBDetails.CHOICE_TABLE+" ("+DBDetails.TEXT_COL+","+DBDetails.QUESTION_ID_COL+") values(?,?)";
			ps=con.prepareStatement(query);
			ps.setString(1,b);
			ps.setInt(2,id);
			ps.executeUpdate();

			query="insert into "+DBDetails.CHOICE_TABLE+" ("+DBDetails.TEXT_COL+","+DBDetails.QUESTION_ID_COL+") values(?,?)";
			ps=con.prepareStatement(query);
			ps.setString(1,c);
			ps.setInt(2,id);
			ps.executeUpdate();

			query="insert into "+DBDetails.CHOICE_TABLE+" ("+DBDetails.TEXT_COL+","+DBDetails.QUESTION_ID_COL+") values(?,?)";
			ps=con.prepareStatement(query);
			ps.setString(1,d);
			ps.setInt(2,id);
			ps.executeUpdate();

			return "true";
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "false";
	}
	
	public static JSONArray getQuestions(String set){
		String query="select * from "+DBDetails.QUESTION_TABLE+" where "+DBDetails.SET_COL+"=?";
		JSONArray array=new JSONArray();
		JSONObject obj;
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,set);
			
			ResultSet rs=ps.executeQuery();			
			ResultSet rs1=null;
			
			while(rs.next()){
				obj=new JSONObject();
				obj.put("id", rs.getString(DBDetails.ID_COL));
				obj.put("question", rs.getString(DBDetails.TEXT_COL));
				obj.put("answer", rs.getString(DBDetails.ANSWER_COL));
				
				query="select * from "+DBDetails.CHOICE_TABLE+" where "+DBDetails.QUESTION_ID_COL+"=?";
				ps=con.prepareStatement(query);
				ps.setString(1,rs.getString(DBDetails.ID_COL));
				rs1=ps.executeQuery();
				
				rs1.absolute(1);
				obj.put("a", rs1.getString(DBDetails.TEXT_COL));
				
				rs1.absolute(2);
				obj.put("b", rs1.getString(DBDetails.TEXT_COL));
				
				rs1.absolute(3);
				obj.put("c", rs1.getString(DBDetails.TEXT_COL));
				
				rs1.absolute(4);
				obj.put("d", rs1.getString(DBDetails.TEXT_COL));
				
				array.add(obj);
			}
			
			rs.close();
			rs1.close();
			ps.close();
			con.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return array;
	}
	
	public static JSONArray getResult(){
		String query="select * from "+DBDetails.USER_TABLE;
		JSONArray array= new JSONArray();
		JSONObject obj;
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			
			ResultSet rs=ps.executeQuery();
			ResultSet rs1=null;
			query="select * from "+DBDetails.RESULT_TABLE+" where "+DBDetails.USER_ID_COL+"=?";
			
			while(rs.next()){
				ps=con.prepareStatement(query);
				ps.setString(1,rs.getString(DBDetails.ID_COL));
				rs1=ps.executeQuery();
				int points=0;
				
				while(rs1.next()){
					if(checkAnswer(rs1.getString(DBDetails.QUESTION_ID_COL), rs1.getString(DBDetails.ANSWER_COL))){
						points++;
					}
				}
				
				obj=new JSONObject();
				obj.put("name", rs.getString(DBDetails.NAME_COL));
				obj.put("email", rs.getString(DBDetails.EMAIL_COL));
				obj.put("points", points);
				array.add(obj);
			}
			
			rs1.close();
			rs.close();
			ps.close();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
	    JSONArray sortedJsonArray = new JSONArray();

	    ArrayList<JSONObject> jsonValues = new ArrayList<JSONObject>();
	    
	    for (int i = 0; i < array.size(); i++) {
	        jsonValues.add((JSONObject)array.get(i));
	    }
	    
	    Collections.sort( jsonValues, new Comparator<JSONObject>() {
	        //You can change "Name" with "ID" if you want to sort by ID
	        private static final String KEY_NAME = "points";

	        @Override
	        public int compare(JSONObject a, JSONObject b) {
	        	Integer valA=null;
	        	Integer valB=null;
	        	
	            try {
	                valA = new Integer(String.valueOf(a.get(KEY_NAME)));
		            valB = new Integer(String.valueOf(b.get(KEY_NAME)));
	            } 
	            catch (Exception e) {
	                e.printStackTrace();
	            }

	            return valB > valA ? 1 : valB < valA ? -1 : 0;
	            //if you want to change the sort order, simply use the following:
	            //return -valA.compareTo(valB);
	        }
		});
		

	    for (int i = 0; i < array.size(); i++) {
	        sortedJsonArray.add(jsonValues.get(i));
	    }
		
		return sortedJsonArray;
	}
	
	public static boolean checkAnswer(String id,String answer){
		String query="select * from "+DBDetails.QUESTION_TABLE+" where "+DBDetails.ID_COL+"=?";
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,id);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()){
				if(rs.getString(DBDetails.ANSWER_COL).equals(answer)){
					return true;
				}
			}
			
			rs.close();
			ps.close();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
				
		return false;
	}
	
	public static JSONObject getQuestion(String id){
		String query="select * from "+DBDetails.QUESTION_TABLE+" where "+DBDetails.ID_COL+"=?";
		JSONObject obj=null;
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,id);
			
			ResultSet rs=ps.executeQuery();			
			ResultSet rs1=null;
			
			if(rs.next()){
				obj=new JSONObject();
				obj.put("id", rs.getString(DBDetails.ID_COL));
				obj.put("question", rs.getString(DBDetails.TEXT_COL));
				obj.put("answer", rs.getString(DBDetails.ANSWER_COL));
				obj.put("set", rs.getString(DBDetails.SET_COL));
				
				query="select * from "+DBDetails.CHOICE_TABLE+" where "+DBDetails.QUESTION_ID_COL+"=?";
				ps=con.prepareStatement(query);
				ps.setString(1,rs.getString(DBDetails.ID_COL));
				rs1=ps.executeQuery();
				
				rs1.absolute(1);
				obj.put("a", rs1.getString(DBDetails.TEXT_COL));
				
				rs1.absolute(2);
				obj.put("b", rs1.getString(DBDetails.TEXT_COL));
				
				rs1.absolute(3);
				obj.put("c", rs1.getString(DBDetails.TEXT_COL));
				
				rs1.absolute(4);
				obj.put("d", rs1.getString(DBDetails.TEXT_COL));
				
			}
			
			rs.close();
			rs1.close();
			ps.close();
			con.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return obj;
	}

	public static String deleteQuestion(String id){
		String query="delete from "+DBDetails.QUESTION_TABLE+" where "+DBDetails.ID_COL+"=?";
		int result1=0,result2=0;
		
		try{
			Connection con=DBConnect.getConnection();
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, id);
			
			result1=ps.executeUpdate();
			
			query="delete from "+DBDetails.CHOICE_TABLE+" where "+DBDetails.QUESTION_ID_COL+"=?";
			ps=con.prepareStatement(query);
			ps.setString(1,id);
			result2=ps.executeUpdate();
			
			if(result1>0&&result2>0){
				return "true";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "false";
	}
	
	public static boolean checkAnswerExists(String id,LinkedHashMap lhm){
		if(lhm.containsKey(id)){
			if(lhm.get(id)!=null){
				return true;
			}
		}
		
		return false;
	}
}