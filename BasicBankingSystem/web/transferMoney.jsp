<%-- 
    Document   : transferMoney.jsp
    Created on : Mar 19, 2022, 4:03:00 AM
    Author     : ME
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="bankingSystem.DBConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"  type="text/css" href="style.css" >
        <title>Transfer Money Page</title>
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
        <form method="POST" action="validatetransaction" class="centered " >
            <h1 style="color:red">Transfer Money</h1>
            <%
                Connection Con = null;
                Statement Stmt = null;
                ResultSet RS = null;

                DBConnection obj = new DBConnection();
                obj.DBConnect();
                Con = obj.getConnection();
                Stmt = obj.getStatement();
                String temp = "";

                String CEmail = request.getSession().getAttribute("session_CEmail").toString();
                System.out.println("Email" + CEmail);
                RS = Stmt.executeQuery("select CustomerEmail from customer");
                if (CEmail.equals("")) {
            %>
            <label>Transfer From</label>
            <select style="width: 200px; height: 40px" name = "transferFrom" id = "mySelect">
                <%
                    while (RS.next()) {

                        System.out.println("Emai: " + RS.getString("CustomerEmail"));
                        temp = RS.getString("CustomerEmail");
                %>

                <option value=<%=temp%>><%=temp%></option>
                <%
                    }
                %>
            </select>
            <% }
            %>
            <label>Transfer To:</label>

            <select style="width: 200px; height: 40px" name = "transferTo">
                <%
                    RS = Stmt.executeQuery("select CustomerEmail from customer");
                    while (RS.next()) {
                        if (!CEmail.equals("")) {

                            if (!CEmail.equals(RS.getString("CustomerEmail"))) {
                                System.out.println("Emai: " + RS.getString("CustomerEmail"));
                                temp = RS.getString("CustomerEmail");
                %>

                <option value=<%=temp%>><%=temp%></option>
                <%}
                } else {
                    temp = RS.getString("CustomerEmail");
                %>

                <option value=<%=temp%>><%=temp%></option>
                <% }
                    }
                %>
            </select>
            <br>
            <label>Amount</label>
            <input style="text-align: center;margin-top: 20px;color:black;" type="text" name="transferredAmount"/>

            <br> <input style="color:black;" type="submit" value="Send" />

        </form>
        <script>
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
                var x = document.getElementById("ID" + iDNum);
                if (x.className === "")
                    x.className = "active";
                if (x.className === "active")
                    x.className = "";

            }
        </script>            

    </body>
</html>
