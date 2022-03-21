<%-- 
    Document   : transactions
    Created on : Dec 15, 2020, 12:05:42 AM
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
        <title> Transactions Page</title>
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
        <h1 style="color:red; text-align: center;">Transactions History</h1>

        <%

            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null, rs = null;

            DBConnection obj = new DBConnection();
            obj.DBConnect();
            Con = obj.getConnection();
            Stmt = obj.getStatement();

            try {

                RS = Stmt.executeQuery("SELECT * FROM bank_transaction;");
                String fromC = "", balanceAmount = "", toC = "", date = "", transactionID;
        %>
        <table class = 'customer'>
            <tr>
                <th>Transaction No.</th>
                <th>Transfered From</th>
                <th>Transfered To</th>
                <th>Transfered Amount </th>
                <th>Transaction Date </th>
            </tr>

            <%while (RS.next()) {

                    transactionID = RS.getString("BankTransactionID");
                    fromC = RS.getString("BTFromAccount");
                    toC = RS.getString("BTToAccount");
                    balanceAmount = RS.getString("BTAmount");
                    date = RS.getString("BTCreationDate");
            %>
            <tr class="centerData"> 
                <td><%=transactionID%> </td>
                <td><%=fromC%> </td>
                <td><%=toC%> </td>
                <td><%=balanceAmount%> </td>
                <td><%=date%> </td>
            </tr>
            <% }
            %>
        </table>
        <%
                Stmt.close();
                Con.close();

            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }
        %>







    </body>
</html>
