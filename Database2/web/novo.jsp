<%@page import="java.sql., java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>




<% response.setContentType("text/html; charset=UTF-8");%>
<%
     String url = "jdbc:sqlite:" + application.getRealPath("/") + "\\dados.db"; 
     
     request.setCharacterEncoding("UTF-8");
     
     try (
        Connection conn = DriverManager.getConnection(url);
        PreparedStatement ps = conn.prepareStatement("INSERT INTO alunos (id, nome, curso) VALUES (?,?,?)")
    ){
        
        Class.forName("org.sqlite.JDBC");
        
        String ra = request.getParameter("ra");
        String nome = request.getParameter("nome");
        String curso = request.getParameter("curso");
        
        ps.setInt(1, Integer.parseInt(ra));
        ps.setString(2, nome);
        ps.setString(3, curso);
        ps.executeUpdate();
        
        
        
        //out.print(ra);
        //out.print(nome);
        //out.print(curso);
        
        //Vamos gravar no banco
        
  
    } catch (Exception e) {
        request.setAttribute("msgErro", "Falha na inserção: " + e.getMessage());
    }



%>