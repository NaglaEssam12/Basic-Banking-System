package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import bankingSystem.DBConnection;

public final class transactions_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\n');
      out.write('\n');
      out.write(' ');
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title> Transactions Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <form method=\"POST\" action=\"validatetransaction\" >\n");
      out.write("            <h1 style=\"color:red\">Transaction Form</h1>\n");
      out.write("            <table border = \"1\">\n");
      out.write("                <tr>\n");
      out.write("                    <td>Transfer To</td>\n");
      out.write("                    <td><input type=\"text\" name=\"transferTo\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td>Amount</td>\n");
      out.write("                    <td><input type=\"text\" name=\"transferredAmount\"/></td>\n");
      out.write("                </tr>\n");
      out.write("            </table>\n");
      out.write("            <br> <input type=\"submit\" value=\"Send\" />\n");
      out.write("        </form>\n");
      out.write("        \n");
      out.write("        <br><br> <a href=\"customerhome.jsp\"><input type=\"submit\" value = \"Back To Customer Home\"/></a>\n");
      out.write("        \n");
      out.write("        <h3 style=\"color:red\">Your Transactions (To Cancel a transaction you can click the \"The number of your bank transaction\") : </h3>\n");
      out.write("        ");

            
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null, rs = null;
            
        DBConnection obj = new DBConnection();
            obj.DBConnect();
            Con = obj.getConnection();
            Stmt = obj.getStatement();

            try {
                  
                RS = Stmt.executeQuery("SELECT CustomerID,CustomerName,CustomerEmail,BACurrentAmount FROM customer ;");
            
                //String customerID = request.getSession().getAttribute("session_CID").toString();
                String CID = "", balanceAmount = "", customerName = "", customerEmail = "";
                //boolean isExisted = false;
                
      out.write("\n");
      out.write("                <table class = 'customer'>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>Customer ID</th>\n");
      out.write("                        <th>Customer Name</th>\n");
      out.write("                        <th>Customer Email</th>\n");
      out.write("                        <th>Current Amount </th>\n");
      out.write("                        <th>Transfer To </th>\n");
      out.write("                    </tr>\n");
      out.write("               \n");
      out.write("                ");
while (RS.next()) {
                    
                    CID = RS.getString("CustomerID");
                    customerName = RS.getString("CustomerName");
                    customerEmail = RS.getString("CustomerEmail");
                    balanceAmount = RS.getString("BACurrentAmount");
                    //To Display The account number and its balance 
                    /*if (CID.equals(customerID)) {
                        balanceAmount = RS.getString("BACurrentBalance");
                        BAID = RS.getString("BankAccountID");
                        isExisted = true;
                        break;
                    }*/
                    
      out.write("\n");
      out.write("                    <tr> \n");
      out.write("                        <td>");
      out.print(CID);
      out.write(" </td>\n");
      out.write("                        <td>");
      out.print(customerName);
      out.write(" </td>\n");
      out.write("                        <td>");
      out.print(customerEmail);
      out.write(" </td>\n");
      out.write("                        <td>");
      out.print(balanceAmount);
      out.write(" </td>\n");
      out.write("                       <!-- <td><input type='button' name='Transfer To' value=\"");
      out.print(customerEmail);
      out.write("\" onclick=\"location.href='customerhome.jsp'\"></td>-->\n");
      out.write("                    </tr>\n");
      out.write("                     \n");
      out.write("               ");
 }
      out.write("\n");
      out.write("               </table>\n");
      out.write("               ");

                Stmt.close();
                Con.close();

                
                } catch (Exception cnfe) {
                    System.err.println("Exception: " + cnfe);
                }
            
      out.write("\n");
      out.write("                \n");
      out.write("                \n");
      out.write("                \n");
      out.write("               \n");
      out.write("            \n");
      out.write("        \n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
