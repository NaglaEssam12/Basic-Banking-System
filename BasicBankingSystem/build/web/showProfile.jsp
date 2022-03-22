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
                String CID = "", balanceAmount = "", customerName = "", customerEmail = "", fromC = "", toC = "", date = "";
                int i = 1;
                while (RS.next()) {;
                    customerEmail = RS.getString("CustomerEmail");
                    //To Display The account number and its balance 
                    if (customerEmail.equals(CEmail)) {
                        balanceAmount = RS.getString("BACurrentAmount");
                        customerName = RS.getString("CustomerName");
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
            <input  type="button" value = "Tranfer Money"style= "width:150px; display:inline; margin: 0 auto; color: black; font-weight: bold;" onclick ="location.href = 'transferMoney.jsp'" />
        </form>
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
                            date = RS.getString("BTCreationDate");
                %>
                <tr class="centerData"> 
                    <td><%=i%> </td>
                    <td><%=fromC%> </td>
                    <td><%=toC%> </td>
                    <td><%=balanceAmount%> </td>
                    <td><%=date%> </td>
                </tr>
                <% i++;
                           }

                       }%>
            </table>
            <footer class="site-footer">
                <div class="container">
                    <div class="row" style="text-align: center;">
                        <div class="col-md-12 col-sm-12">
                            <br>
                            <h2 >Created By</h2>
                            <h3>Naglaa Essam </h3>
                            <a href="https://www.linkedin.com/in/naglaa-essam-627213171/"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAYFBMVEUAha////8AfKoAgKzf7fL7/f4dirGdxdcAg64AfqvJ3ObV5+4xk7cAga291+Nzscm21OFmqcR8tMxJm7zR5OyMvNHE3eesz93s9fhZo8BtqsWRv9M9l7mYv9JRn7/k8PSHVJuUAAAEn0lEQVR4nO2d63aiMBRGJRFJWhABUbxU3/8tB8Z2bBXIsUmUk/n2r66uBc1u7pcTZjMAAAAAAAAAAAAAAAAAAISIUlJKpV6dDE8oKfSxqD/qopJChmepRJq8R1/Mt5XIXp0kpyhxuup9Su5DcpSLdXTPudKvTpgrRNnj15GIMKqjWA0IRtFavjpxLhDLQcG2NgagOJKDHe/i1Qm0RdejglG0Yq6ojgbBKCp4dxribDSMWY/istwo2PYZnLtF0RAMI8aZqHYUwajm22Xosa7wypxvcypikmG0eHVCf4tKaYJRzrXDyIZG3LewbU11QjRcsjUcH5Je2XA1FG9EwzPXxlRTDdlOMOSWWkrZGn4QDVdc66EqiIYHrsM2NSMa7tgOvQmzw46YaxaSu3y23WHLIvBC2hbTDUGQbX/fQZpd7LnOLP6izZ3+mnMWtmjjSg3b6e8nxnJa8O0qPpHjq1El457ii1HFmnklvKCrwQWpIgjB2Syb9XeL8wX7OvgPsb9vUuMykB3gC5kofm7lz0sRTgZeUGJRbtdNHMfN+6pchHQQ40omxQUdpB4AAAAAAHgQpVR2of0ppBlMh2oHvzqt9nnZkudFlar2FzILw1NlWleHze1uSTxfHU6Z0H4kpTbS/6Dxsbv0Kp3ly+ETPOukEh6WveRhaWLbPxM2PbapfioqcVyZDig1ift5KWV/rdfQvKfz45iREqe+cIB7NifHaydibvyb/buHDxkqkdL8Ot5Tp45PMVTkIxEXti5jkp5hKCrSKdZvNEd3Tc4TDMXhQb8Od2vt/g1HwzmG2bpS9G4obyPGqCwdKfo21Ob3D+Eo0MOvoRK/zcGOgxNFv4akgxDD7FyMb7wa6t+0ot//sgNBr4a6shN0cybSpyEtXGUUBwddPBoW1FPkIzT2O3weDR0IugjX8WjoBPtjkVM3tM/EyRs2ts3p5A2jynKuOH1D21P00zfsXyYKyrCwK6YMDC2LKQNDy9aUgaHlEV4OhqXV8JuDoV1FfKJhs0ny/anbV0veiBHWF+yiIZ5leK7T7ric6nZEM6317pE1Rqs91OcYzne3l4cp0XtxUz/HyRvWfVstavDupjusguWfYBgPbUKQ13GsguX9G8aLwRyQxAhPqwUp/4bHkSImaLtuVoHW3g3r0RJGW46zGrf5NjT8+7M96S1TroemGTotE2cW3YVnQ2NknyQt/KfTNTTH15LeYxOm69eQ0EQQEmA3zfdruDU3EaRwcpv5k19DQuki3evwYbEa5deQMimgvCiZqiHpjjDKbVw2A1OvhqTJOWWrf+Dw4OsNSbsqlDvjbNYxvBqSujHKmbc3i4GpV0PSMiBlVDNZQ9JwknL95lQNG1LtYW1ISpciTKCmaki7MpNwz+9kDWmLD/+BIeGKHBjCEIYwhCEMYQhDGMIQhjCEIQxhCEMYwhCGMIQhDGEIQxjCEIYwhCEMYQhDGMIQhjCEIQxhCEMYwhCGMIQhDGEIQxg6NPT3bQSHhjafJM7yxETdGyqujM8l1ItzzG+yunYvM35rZCCd5o+bUIPozW8K4xs0AAAAAAAAAAAAAAAAAMB/zx+CcHACwrR3qQAAAABJRU5ErkJggg=="
                                                                                               alt="HTML tutorial" style="width:42px;height:42px;"></a>
                        </div>
                    </div>
                </div>
            </footer>  
        
        <%
                Stmt.close();
                Con.close();

            } catch (Exception cnfe) {
                System.err.println("Exception: " + cnfe);
            }
        %>
        <script>
            function toggleText() {
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
                var x = document.getElementById("ID" + iDNum);
                if (x.className === "")
                    x.className = "active";
                if (x.className === "active")
                    x.className = "";

            }

        </script>
    </body>
</html>
