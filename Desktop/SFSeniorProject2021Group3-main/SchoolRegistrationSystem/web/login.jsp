 <head>
    <title>School Registration System Application</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  </head>
  <body>
     <div class="d-flex flex-row bd-highlight justify-content-end p-5">
     <a href="userregistration.jsp">
  	   <label class="btn btn-outline-info m-1" for="btncheck2">Register</label>
  	   </a>
 	 </div>
 	 <div class="container">
 	 <div class="d-flex justify-content-center">
 	 <h1>
 	  	<span class="badge rounded-pill bg-primary">Welcome</span>
		<span class="badge rounded-pill bg-secondary">To</span>
		<span class="badge rounded-pill bg-success">School</span>
		<span class="badge rounded-pill bg-danger">Registration</span>
		<span class="badge rounded-pill bg-warning text-dark">System</span> 	
	</h1> 
	</div>
	<div class="container mx-auto" style="width: 60%;">
	<div class="card bg-info">
	<form action=login method="post">
  		<div class="form-group col-md-10 mx-auto" style="width: 60%;">
   		 	<label for="exampleInputEmail1">Email address</label>
   		 	<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="username">
  		</div>
  		<div class="form-group col-md-10 mx-auto" style="width: 60%;">
    		<label for="exampleInputPassword1">Password</label>
    		<input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" name="password">
    		<button type="submit" class="btn btn-primary mt-3">Sign in</button>
  		</div>
  		
	</form>
	</div>
 	</div>
  </div>
</body>
</html>
