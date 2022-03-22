/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import bankingSystem.DBConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ME
 */

@WebServlet(urlPatterns = {"/validatetransaction"})
public class validatetransaction extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public ArrayList<String> updateBalance(Statement Stmt, ResultSet BRSet, String transferFrom, String transferTo) {
        ArrayList<String> amounts = new ArrayList<>();
        String BAID = "", accAmount = "", tToAmount = "";
        try {
            BRSet = Stmt.executeQuery("SELECT CustomerEmail ,BACurrentAmount FROM customer ;");
            boolean to_existed = false;
            boolean from_existed = false;
            while (BRSet.next()) {
                BAID = BRSet.getString("CustomerEmail");
                if (BAID.equals(transferFrom)) {
                    from_existed = true;
                    accAmount = BRSet.getString("BACurrentAmount");
                }
                if (BAID.equals(transferTo)) {
                    to_existed = true;
                    tToAmount = BRSet.getString("BACurrentAmount");
                }
                if (to_existed == true && from_existed == true) {
                    amounts.add(accAmount);
                    amounts.add(tToAmount);
                    break;
                }
            }
        } catch (Exception ex) {
                ex.printStackTrace();
            }
        return amounts;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                
                Connection Con = null;
                Statement Stmt = null;
                ResultSet rs = null, BRSet = null;
                
                DBConnection obj = new DBConnection();
                obj.DBConnect();
                Con = obj.getConnection();
                Stmt = obj.getStatement();
                
                 String transferFrom;
                String customerEmail = request.getSession().getAttribute("session_CEmail").toString();
                transferFrom = customerEmail;
                System.out.println("Email:" + customerEmail);
              if(customerEmail.equals(""))
              {
                  transferFrom = request.getParameter("transferFrom");
              }
                 
                String transferTo = request.getParameter("transferTo");
                System.out.println("Email:" + transferTo);
                String transferredAmount = request.getParameter("transferredAmount");
                BRSet = Stmt.executeQuery("SELECT CustomerEmail,BACurrentAmount FROM customer ;");

                String BAID = "", accAmount = "", toAmountt = "", tToAmount = "";
                ArrayList<String> accNumbers = new ArrayList<>();
                while (BRSet.next()) {
                    BAID = BRSet.getString("CustomerEmail");
                    accNumbers.add(BAID);
                }
                System.out.println("list" + accNumbers);
                if ((!(accNumbers.contains(transferTo))) || (transferFrom.equals(transferTo))) { //To make sure the account number is existed or not
                    String htmlRespone = "<html>";
                    htmlRespone += "<body>";
                    htmlRespone += "<script>";
                    htmlRespone += "alert(\"The Transaction process can't be done...\")";
                    htmlRespone += "</script>";
                    htmlRespone += "</body>";
                    htmlRespone += "</html>";
                    out.println(htmlRespone);
                }
               
                BAID = ""; 
                String fromID = "", toID = "";
                rs = Stmt.executeQuery("SELECT CustomerID,CustomerEmail FROM customer ;");
                while(rs.next())
                {
                    if(rs.getString("CustomerEmail").equals(transferFrom))
                        fromID = rs.getString("CustomerID");
                    if(rs.getString("CustomerEmail").equals(transferTo))
                        toID = rs.getString("CustomerID");
                }
                System.out.println("f" + fromID + "T" + toID);
                if ((accNumbers.contains(transferFrom) && accNumbers.contains(transferTo)) && !(transferFrom.equals(transferTo))) { //if account number existed
                    ArrayList<String> amounts = new ArrayList<>();
                    amounts = updateBalance(Stmt, BRSet, transferFrom, transferTo);
                    accAmount = amounts.get(0);
                    tToAmount = amounts.get(1);
                    System.out.println("accAmount" + accAmount);
                    System.out.println("toAmount" + tToAmount);
                    Float fAmount = (float) 0, toAmount = (float) 0;
                    if (Float.parseFloat(accAmount) >= Float.parseFloat(transferredAmount)) {
                        fAmount = Float.parseFloat(accAmount) - Float.parseFloat(transferredAmount);
                        toAmount = Float.parseFloat(transferredAmount) + Float.parseFloat(tToAmount);
                        accAmount = fAmount.toString();
                        toAmountt = toAmount.toString();
                        
                        //Update bank account with new balance .
                        int rows1 = Stmt.executeUpdate("UPDATE customer SET BACurrentAmount = " + accAmount + "WHERE CustomerID = " + fromID + ";");
                        int rows2 = Stmt.executeUpdate("UPDATE customer SET BACurrentAmount = " + toAmountt + "WHERE  CustomerID = " + toID + ";");

                        //Add these transactions in transaction table
                        rs = Stmt.executeQuery("SELECT BankTransactionID FROM bank_transaction ;");
                        String BTID = "";
                        ArrayList<String> BTIDs = new ArrayList<>();
                        while (rs.next()) {
                            BTID = rs.getString("BankTransactionID");
                            BTIDs.add(BTID);
                        }
                        String line = "INSERT INTO bank_transaction(BTCreationDate,BTAmount,BTFromAccount,BTToAccount) VALUES("
                                + "'" + (java.time.LocalDate.now()) + "',"
                                + "'" + transferredAmount + "',"
                                + "'" + transferFrom + "',"
                                + "'" + transferTo + "')";
                        int rows = Stmt.executeUpdate(line);
                        //Confirmatiom message
                        String htmlRespone = "<html>";
                        htmlRespone += "<body>";
                        htmlRespone += "<script>";
                        htmlRespone += "alert(\"The Transaction process is completed successfully\")";
                        htmlRespone += "</script>";
                        htmlRespone += "</body>";
                        htmlRespone += "</html>";

                        out.println(htmlRespone);
                    } else {
                        //show error message
                        String htmlRespone = "<html>";
                        htmlRespone += "<body>";
                        
                        htmlRespone += "<script>";
                        htmlRespone += "alert(\"The Transaction process can't be done...\")";
                        htmlRespone += "</script>";
                        htmlRespone += "</body>";
                        htmlRespone += "</html>";
                        out.println(htmlRespone);
                        //
                    }
                }
                        
                
                Stmt.close();
                Con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
