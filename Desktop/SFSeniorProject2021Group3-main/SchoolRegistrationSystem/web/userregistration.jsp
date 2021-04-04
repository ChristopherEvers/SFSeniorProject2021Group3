<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Registration</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
</head>
<body class="bg-warning">
 <div class="d-flex flex-row bd-highlight justify-content-end p-5">
       <a href="login.jsp"><label class="btn btn-outline-primary m-1" for="btncheck1">Login</label></a>
 	 </div>
<div class="container w-1/2">
<div class="card ">
	<div class="card-header bg-primary">
		User Registration
	</div>
	<div class="card-body mx-auto" style="width: 80%;">
	<h5 class="card-title">Please complete the registration form.</h5>	
	<p class="card-text">Once you have completed the form, staff will review and approve your registration</p>
	
	
<form action=registration method="post">
<div class="row">
    <div class="form-group col-md-3">
      <label for="email">Email</label>
      <input type="text" class="form-control" id="email" placeholder="email" name="email" required>
    </div>
    <div class="form-group col-md-3">
      <label for="password">Password</label>
      <input type="text" class="form-control" id="password" placeholder="password" name="password" required>
    </div>
  </div>
<div class="row">
  	<div class="form-group col-md-3">
      <label for="firstName">First Name</label>
      <input type="text" class="form-control" id="firstName" placeholder="First Name" name="firstName" required>
    </div>
    <div class="form-group col-md-3">
      <label for="lastName">Last Name</label>
      <input type="text" class="form-control" id="lastName" placeholder="Last Name" name="lastName" required>
    </div>
      <div class="form-group col-md-3">
      <label for="age">Age</label>
      <input type="text" class="form-control" id="age" placeholder="Age" name="age" required>
    </div>
  </div>
  <div class="form-group col-md-6">
    <label for="inputAddress">Address</label>
    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" name="address" required>
  </div>
  <div class="form-group col-md-6">
    <label for="inputAddress2">Address 2</label>
    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor" name="address2">
  </div>
  <div class="row">
    <div class="form-group col-md-2">
      <label for="inputCity">City</label>
      <input type="text" class="form-control" id="inputCity" name="city" required>
    </div>
    <div class="form-group col-md-2">
      <label for="inputState">State</label>
      <select id="inputState" class="form-control" name="state" required>
        <option selected>Choose...</option>
        <option>Florida</option>
      </select>
    </div>
    <div class="form-group col-md-2">
      <label for="inputZip">Zip</label>
      <input type="text" class="form-control" id="inputZip" name="zip" required>
    </div>
      <div class="form-group col-md-2">
      <label for="phone">Phone</label>
      <input type="text" class="form-control" id="phone" name="phone" required>
    </div>
  </div>
  <div class="form-col-2">
    <div class="flex flex-row">
    <input class="form-check-input" type="radio" name="userType" id="isStudentRadio" value="student" checked required>
  <label class="form-check-label" for="userType">
    I am a student.
  </label>
    
<div class="form-check">
  <input class="form-check-input" type="radio" name="userType" id="isTeacherRadio" value="teacher" required>
  <label class="form-check-label" for="userType">
    I am a teacher.
  </label>
</div>
<div class="form-check">
  <input class="form-check-input" type="radio" name="userType" id="isStaffRadios" value="staff" required>
  <label class="form-check-label" for="userType">
    I am a member.
  </label>
  </div>
<div class="form-check">
  <input class="form-check-input" type="radio" name="userType" id="isParentRadios" value="parent" required>
  <label class="form-check-label" for="userType">
    I am a parent.
  </label>
  </div>
  </div>
  </div>
  <div class="d-flex justify-content-evenly">
 
  <div class="card col-md-4">
  		<p class="card-text">
  		 If you are student
  		</p>
    	 <div class="form-group col-md-8">
     	 <label for="userType">Grade</label>
      	<input type="text" class="form-control mb-2" id="grade" name="grade" value="NA">
      </div>
  </div>
  
  <div class="card col-md-4">
  	<p class="card-text">
  	 If you are a parent
  	</p>
  	<div class="form-group col-md-10">
       <label for="dependents">Child's name</label>
      <input type="text" class="form-control mb-2" id="dependents" name="dependents">
    </div>
   </div>
</div>

  <button type="submit" class="btn btn-primary mt-1">Sign up</button>
  <p>Registration Message: ${message}</p>
 
</form>

</div>

</div>
</body>
</html>