package com.SchoolRegistrationSystem;

import java.io.IOException;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.*;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//db connection information
	String url = "jdbc:mysql://localhost:3306/schoolregistrationsystem";
	String dbUsername = "root";
	String dbPassword = "admin";
	
	public void init() {
		//load driver
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}	
	
	public boolean login(String name, String password) throws NoSuchAlgorithmException, InvalidKeySpecException {
		String generatedSecuredPasswordHash = null;
		String storedPassword = null;
		try {
			//Connection to db
			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
			//Make a statement
			Statement st = con.createStatement();
			
			String query = "select * from users where email='" + name + "'";
			//ResultSet
			ResultSet rs = st.executeQuery(query);
			while(rs.next()) {
				storedPassword = rs.getString("password");
			}
			boolean matched = validatePassword(password, storedPassword);
			System.out.print(matched);
			if(matched == true) {
				rs.close();
				st.close();
				con.close();
				return true;
			} else {
			//hashed password does not match entered password
			rs.close();
			st.close();
			con.close();
			return false;
			}
		}
		catch (SQLException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return false;
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		String email = req.getParameter("username");
		String password = req.getParameter("password");
		//if password or email is empty send to login page
	
		if (email.isEmpty() || password.isEmpty()) {
			res.sendRedirect("login.jsp");
		} else {
			//Check email and password exist in query
			try {
				if (login(email, password)) {
						res.sendRedirect("userwelcome.jsp?user="+email);
				} else {
					//else back to login
					res.sendRedirect("login.jsp");
				}
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (InvalidKeySpecException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
	}
	
	  private static String generateStorngPasswordHash(String password) throws NoSuchAlgorithmException, InvalidKeySpecException
	    {
		  
	        int iterations = 1000;
	        char[] chars = password.toCharArray();
	        byte[] salt = getSalt();
	         
	        PBEKeySpec spec = new PBEKeySpec(chars, salt, iterations, 64 * 8);
	        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	        byte[] hash = skf.generateSecret(spec).getEncoded();
	        return iterations + ":" + toHex(salt) + ":" + toHex(hash);
	    }
	  
		private static byte[] getSalt() throws NoSuchAlgorithmException {
			 SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
		     byte[] salt = new byte[16];
		     sr.nextBytes(salt);
		     return salt;
		}
		
		private static String toHex(byte[] array) {

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
		
		 private static boolean validatePassword(String originalPassword, String storedPassword) throws NoSuchAlgorithmException, InvalidKeySpecException
		    {
				
		        String[] parts = storedPassword.split(":");
		        int iterations = Integer.parseInt(parts[0]);
		        byte[] salt = fromHex(parts[1]);
		        byte[] hash = fromHex(parts[2]);
		         
		        PBEKeySpec spec = new PBEKeySpec(originalPassword.toCharArray(), salt, iterations, hash.length * 8);
		        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		        byte[] testHash = skf.generateSecret(spec).getEncoded();
		         
		        int diff = hash.length ^ testHash.length;
		        for(int i = 0; i < hash.length && i < testHash.length; i++)
		        {
		            diff |= hash[i] ^ testHash[i];
		        }
		        return diff == 0;
		    }
		 
		  private static byte[] fromHex(String hex) throws NoSuchAlgorithmException
		    {
		        byte[] bytes = new byte[hex.length() / 2];
		        for(int i = 0; i<bytes.length ;i++)
		        {
		            bytes[i] = (byte)Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		        }
		        return bytes;
		    }
	  
}


