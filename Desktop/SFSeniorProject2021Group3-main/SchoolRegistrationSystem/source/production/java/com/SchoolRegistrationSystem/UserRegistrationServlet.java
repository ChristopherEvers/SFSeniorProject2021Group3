package com.SchoolRegistrationSystem;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.sql.*;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;

/**
 * Servlet implementation class UserRegistrationServlet
 */
@WebServlet("/Registration")
public class UserRegistrationServlet extends HttpServlet {
	String ErrorMessages;
	private static final long serialVersionUID = 1L;
    
  //db connection information
  	String url = "jdbc:mysql://localhost:3306/schoolregistrationsystem";
  	String dbUsername = "root";
  	String dbPassword = "admin";
  	boolean successRegistration = false;
  	
  	public void init() {
  		//load driver
  		try {
  			Class.forName("com.mysql.jdbc.Driver");
  		} catch (ClassNotFoundException e) {
  			e.printStackTrace();
  		}
  	}
  	
  	private boolean getRegistrationID(String email, String password, String firstName, String lastName, String age, String address1,
			String address2, String city, String state, String zip, String phone, String userType, String grade,
			String dependents) {
  		
  		Integer registrationID = 0;
  				
  		try {
		//Connection to db
		Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
		//Make a statement
		Statement st = con.createStatement();
		String query = "select count(*) from registrationuser";
		//ResultSet
		ResultSet rs = st.executeQuery(query);
		rs.next();
		registrationID = rs.getInt("count(*)") + 1;
	
		rs.close();
		st.close();
		con.close();
  		}
  		
  		catch (SQLException e) {
  			System.out.println(e.toString());
  		} catch (Exception e) {
  			System.out.println(e.toString());
  		}
  		
  	    	Integer Age = Integer.parseInt(age);
		    String CityStateZip = city + " ," + state + " " + zip;
		    String Dependents;
		    String Address2;    
		 
		
		    if(dependents == null) {
		    	Dependents = null;
		    } else {
		    	Dependents = dependents;
		    }
		    
		    if(address2 == null) {
		    	Address2 = null;
		    } else {
		    	Address2 = address2;
		    }
  		
  		if(adduser(registrationID,
  				email, 
				password, 
				firstName, 
				lastName, 
			    Age, 
				address1, 
				Address2, 
				CityStateZip,
				phone, 
				userType, 
				grade, 
				Dependents)) {
  			return true;
  		} else {
  			return false;
  		}
	
	}
	
  	
	private boolean adduser(Integer id, String email, String password, String firstName, String lastName, Integer age, String address1,
			String address2, String CityStateZip, String phone, String userType, String grade,
			String dependents) {
		
			
			try {
	  			//Connection to db
	  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
	  				    		    
	  			//Make a statement
	  			Statement st = con.createStatement();
	  			String query = 
	  					"INSERT INTO schoolregistrationsystem.registrationuser "
	  					+ "(RegistrationId,Email, Password, FirstName, LastName, age, Address1, Address2, CityStateZip, Phone, UserType, Grade, dependents)"
	  					+ "VALUES('"+id+"','"
	  								+email+"','"
	  							    +password+"','"
	  					            +firstName+"','"
	  							    +lastName+"','"
	  					            +age+"','"
	  							    +address1+"','"
	  					            +address2+"','"
	  							    +CityStateZip+"','"
	  					            +phone+"','"
	  							    +userType+"','" 
	  							    +grade+"','"
	  							    +dependents+"'"+
	  							");";
	  			//ResultSet
	  			int rs = st.executeUpdate(query);
	  		
	  			st.close();
	  			con.close();
	  			return true;
	  		}
	  		catch (SQLException e) {
	  			ErrorMessages = e.toString();
	  			System.out.println(e.toString());
	  		} catch (Exception e) {
	  			ErrorMessages = e.toString();
	  			System.out.println(e.toString());
	  		}
			return false;
	  
	}
	

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String firstName = req.getParameter("firstName");
		String lastName = req.getParameter("lastName");
		String age = req.getParameter("age");
		String address1 = req.getParameter("address");
		String address2 = req.getParameter("address2");
		String city = req.getParameter("city");
		String state = req.getParameter("state");
		String zip = req.getParameter("zip");
		String phone = req.getParameter("phone");
		String userType = req.getParameter("userType");
	    String grade = req.getParameter("grade");
		String dependents = req.getParameter("dependents");
		String hashedPassword = null;
		try {
			hashedPassword = hashNormalPassword(password);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(getRegistrationID(email, 
				hashedPassword, 
				firstName, 
				lastName, 
				age, 
				address1, 
				address2, 
				city, 
				state, 
				zip, 
				phone, 
				userType, 
				grade, 
				dependents)) {
		;
		res.sendRedirect("thanks.jsp");
		} else {
			req.setAttribute("message",ErrorMessages);
			req.getRequestDispatcher("userregistration.jsp").forward(req, res);
		}

	}

	private String hashNormalPassword(String password) throws NoSuchAlgorithmException, InvalidKeySpecException {
		 int iterations = 1000;
	     char[] chars = password.toCharArray();
	     byte[] salt = getSalt();
	         
	     PBEKeySpec spec = new PBEKeySpec(chars, salt, iterations, 64 * 8);
	     SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	     byte[] hash = skf.generateSecret(spec).getEncoded();
	     return iterations + ":" + toHex(salt) + ":" + toHex(hash);
	}

	private byte[] getSalt() throws NoSuchAlgorithmException {
		 SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
	     byte[] salt = new byte[16];
	     sr.nextBytes(salt);
	     return salt;
	}
	
	private String toHex(byte[] array) {

        BigInteger bi = new BigInteger(1, array);
        String hex = bi.toString(16);
        int paddingLength = (array.length * 2) - hex.length();
        if(paddingLength > 0)
        {
            return String.format("%0"  +paddingLength + "d", 0) + hex;
        }else{
            return hex;
        }
	}
	
	

}
