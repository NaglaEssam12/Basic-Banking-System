<%-- 
    Document   : customerhome
    Created on : Dec 13, 2020, 11:46:09 PM
    Author     : ME
--%>


<%@page import="java.sql.*"%> <%-- to run Connection , Statement, Result set --%>
<%@page import="bankingSystem.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"  type="text/css" href="style.css" >
        <title>View Customers Page</title>
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
        <h1 style="color:red; text-align: center;">Customers</h1>
        <%

            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;

            try {
                DBConnection obj = new DBConnection();
                obj.DBConnect();
                Con = obj.getConnection();
                Stmt = obj.getStatement();

                RS = Stmt.executeQuery("SELECT CustomerID,CustomerName,CustomerEmail,BACurrentAmount FROM customer ;");

                //  String customerID = request.getSession().getAttribute("session_CID").toString();
                session = request.getSession(true);
                session.setAttribute("session_CEmail", "");
                // session.setAttribute("session_CID", CID);
                String CID = "", balanceAmount = "", customerName = "", customerEmail = "", temp = "";
                int i = 1;
                // boolean isExisted = false;
        %>
        <form action="validate" class = 'home' style="margin-top:50px;">
            <table class ='customer'>
                <tr>
                    <th>Customer ID</th>
                    <th>Customer Name</th>
                    <th>Customer Email</th>
                    <th>Current Amount </th>
                    <th> Show Profile</th>
                </tr>

                <%while (RS.next()) {

                        CID = RS.getString("CustomerID");
                        customerName = RS.getString("CustomerName");
                        customerEmail = RS.getString("CustomerEmail");
                        balanceAmount = RS.getString("BACurrentAmount");
                        temp = "D" + CID;
                        // session = request.getSession(true);
                        //session.setAttribute("session_CID", customerEmail);
                        //To Display The account number and its balance 
                        /*if (CID.equals(customerID)) {
                        balanceAmount = RS.getString("BACurrentBalance");
                        BAID = RS.getString("BankAccountID");
                        isExisted = true;
                        break;
                    }*/
                %>
                <tr class="centerData"> 
                    <td><%=i%> </td>
                    <td><%=customerName%> </td>
                    <td><%=customerEmail%> </td>
                    <td><%=balanceAmount%> </td>
                    <!--<td> <input id = "D" type="button" value = "\"session.setAttribute(\"session_CID\", customerEmail)\"" onclick="location.href='showProfile.jsp'">View</button></td>-->
                    <td><input class = "btn" id = "<%=temp%>" name = "btn" value ="View" onclick ="Click1('<%=CID%>', '<%=customerEmail%>')" type="submit"/> </td>
                </tr>

                <% i++;
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
            function Click1(id, email)
            {
                document.getElementById("D" + id).value = email;

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
                var x = document.getElementById("ID" + iDNum);
                if (x.className === "")
                    x.className = "active";
                if (x.className === "active")
                    x.className = "";

            }


        </script>


    </body>
</html>
