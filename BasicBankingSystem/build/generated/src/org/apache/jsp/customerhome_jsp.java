package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import bankingSystem.DBConnection;

public final class customerhome_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write(" ");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("         <link rel=\"stylesheet\"  type=\"text/css\" href=\"style.css\" >\n");
      out.write("        <title>Customer Home Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            
            
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
                   // session.setAttribute("session_CID", CID);
                String CID = "", balanceAmount = "", customerName = "", customerEmail = "",temp = "";
                int i = 1;
               // boolean isExisted = false;
                
      out.write("\n");
      out.write("                <form action=\"validate\">\n");
      out.write("                <table class = 'customer'>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>Customer ID</th>\n");
      out.write("                        <th>Customer Name</th>\n");
      out.write("                        <th>Customer Email</th>\n");
      out.write("                        <th>Current Amount </th>\n");
      out.write("                        <th> Show Profile</th>\n");
      out.write("                    </tr>\n");
      out.write("               \n");
      out.write("                ");
while (RS.next()) {
                    
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
                    
      out.write("\n");
      out.write("                    <tr> \n");
      out.write("                        <td>");
      out.print(i);
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
      out.write("                        <!--<td> <input id = \"D\" type=\"button\" value = \"\\\"session.setAttribute(\\\"session_CID\\\", customerEmail)\\\"\" onclick=\"location.href='showProfile.jsp'\">View</button></td>-->\n");
      out.write("                        <td><input id = \"");
      out.print(temp);
      out.write("\" name = \"btn\" value =\"View\" onclick =\"Click('");
      out.print(CID);
      out.write("','");
      out.print(customerEmail);
      out.write("')\" type=\"submit\"/> </td>\n");
      out.write("                    </tr>\n");
      out.write("                     \n");
      out.write("               ");
 i++;}
      out.write("\n");
      out.write("               </table>\n");
      out.write("                </form>\n");
      out.write("               ");

              
                Stmt.close();
                Con.close();

         
                } catch (Exception cnfe) {
                    System.err.println("Exception: " + cnfe);
                }
            
      out.write("\n");
      out.write("            <script>\n");
      out.write("                function Click(id,email)\n");
      out.write("                {\n");
      out.write("                    alert(id);\n");
      out.write("                    document.getElementById(\"D\"+id).value = email;\n");
      out.write("                    \n");
      out.write("                }\n");
      out.write("                  \n");
      out.write("            </script>\n");
      out.write("\n");
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
