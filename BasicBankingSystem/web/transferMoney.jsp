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
