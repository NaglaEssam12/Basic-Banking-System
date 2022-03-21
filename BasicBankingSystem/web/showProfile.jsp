<%-- 
    Document   : showProfile.jsp
    Created on : Mar 19, 2022, 4:18:05 AM
    Author     : ME
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="bankingSystem.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"  type="text/css" href="style.css" >
        <title>Profile Page</title>
    </head>
    <body>
        <div class="topnav" id="myTopnav">
        <a href="" class = "" style=" color:blue; float: left"> The </a>
        <a href="" style="color:red;float: left; margin-left: -25px;"> Sparks </a>
        <a href="" style="color:green;float: left;margin-left: -25px;"> Bank </a>
        <a href="transactions.jsp" class = "" id = "ID" onclick="Click('4')">Transactions History</a>
        <a href="transferMoney.jsp" class = "" id = "ID" onclick="Click('2')">Transfer Money</a>
        <a href="customerhome.jsp" style="color:black;" class="" id="ID" onclick="Click('1')">View Customers</a>
        <a href="login.html" class = "" id = "ID" onclick="Click('3')">Home</a>
        <a href="javascript:void(0);" class="icon" onclick="myFunction()">
          <i class="fa fa-bars"></i>
        </a>
      </div>
        
        
        
        <%
            
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null, rs = null;
            
        DBConnection obj = new DBConnection();
            obj.DBConnect();
            Con = obj.getConnection();
            Stmt = obj.getStatement();

            try {
                  
                RS = Stmt.executeQuery("SELECT CustomerID,CustomerName,CustomerEmail,BACurrentAmount FROM customer ;");
            
                String CEmail = request.getSession().getAttribute("session_CEmail").toString();
                System.out.println(CEmail);
                String CID = "", balanceAmount = "", customerName = "", customerEmail = "",fromC = "",toC = "", date = "";
                int i = 1;
                while (RS.next()) {;
                    customerEmail = RS.getString("CustomerEmail");
                    //To Display The account number and its balance 
                    if (customerEmail.equals(CEmail)) {
                        balanceAmount = RS.getString("BACurrentAmount");
                        customerName  = RS.getString("CustomerName");
                        break;
                    }
                }
                RS = Stmt.executeQuery("SELECT BTCreationDate,BTAmount,BTFromAccount,BTToAccount FROM bank_transaction ;");
                    %>
                <form class = "centered">
            <label for="fname">Name</label><br>
            <input style="color:black;" type="text" id="fname"  value="<%= customerName%>"><br>
            <label for="lname">Email</label><br>
            <input style="color:black;" type="text" id="lname"  value="<%= customerEmail%>"><br>
            <label for="fname">Current Balance</label><br>
            <input style="color:black;" type="text" id="fname"  value="<%= balanceAmount%>"><br>
            <input  onclick="toggleText()" style="width:150px; display:inline; margin: 0 auto; color: black;font-weight: bold; "value="Transaction History" type="button">
            <input  type="button" value = "Tranfer Money"style= "width:150px; display:inline; margin: 0 auto; color: black; font-weight: bold;" onclick ="location.href='transferMoney.jsp'" />
                <table class = 'customer ' id = 'Myid'style="margin-top: 50px;">
                    <tr>
                        <th>Transaction No.</th>
                        <th>Transfered From</th>
                        <th>Transfered To</th>
                        <th>Transfered Amount </th>
                        <th>Transaction Date </th>
                    </tr>
               
                <%while (RS.next()) {
                    
                    //CID = RS.getString("CustomerID");
                    fromC = RS.getString("BTFromAccount");
                    toC = RS.getString("BTToAccount");
                    System.out.println("DD" + customerEmail);
                    //To Display The account number and its balance 
                    if (customerEmail.equals(fromC) || customerEmail.equals(toC)) {
                        balanceAmount = RS.getString("BTAmount");
                        date  = RS.getString("BTCreationDate");
                        %>
                        <tr class="centerData"> 
                        <td><%=i%> </td>
                        <td><%=fromC%> </td>
                        <td><%=toC%> </td>
                        <td><%=balanceAmount%> </td>
                        <td><%=date%> </td>
                    </tr>
                   <% i++;}
                    
                    
                }%>
               </table>
                </form>
               <%
                Stmt.close();
                Con.close();

                
                } catch (Exception cnfe) {
                    System.err.println("Exception: " + cnfe);
                }
            %>
        <script>
        function toggleText(){
          var x = document.getElementById("Myid");
          if (x.style.display === "none") {
            x.style.display = "block";
          } else {
            x.style.display = "none";
          }
        }
        function myFunction() {
                var x = document.getElementById("myTopnav");
                if (x.className === "topnav") {
                  x.className += " responsive";
                  
                } else {
                  x.className = "topnav";
            }
            }
            function Click(iDNum)
            {
                var x = document.getElementById("ID"+iDNum);
                if(x.className === "")
                    x.className = "active";
                if(x.className === "active")
                    x.className = "";
                
            }
        
        </script>
    </body>
</html>
