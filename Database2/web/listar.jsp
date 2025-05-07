<%@ page import="java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<Map<String, Object>> alunos = new ArrayList<>();
    String url = "jdbc:sqlite:" + application.getRealPath("/") + "\\dados.db";   
    
    try {
        Class.forName("org.sqlite.JDBC");
        Connection conn = DriverManager.getConnection(url);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT id, nome, curso FROM alunos ORDER BY nome ASC");

        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("id", rs.getInt("id"));
            row.put("nome", rs.getString("nome"));
            row.put("curso", rs.getString("curso"));
            alunos.add(row);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Erro: " + e.getMessage());
    }

    request.setAttribute("alunos", alunos);
%>

<html>
<head><title>Lista de Alunos</title></head>
<body>
    <h2>Lista de Alunos</h2>
    <table border="1">
        <tr>
            <th><label for="">RA:</label>
                <select id="ordenarRA">RA:
                    <<option value="value">1 5 3</option>
                    <option value="value">1-10</option>
                </select>
            </th>
            <th>Nome</th>
            <th>Curso</th>
        </tr>
        <c:forEach var="aluno" items="${alunos}">
            <tr>
                <td><c:out value="${aluno.id}"/></td>
                <td><c:out value="${aluno.nome}"/></td>
                <td><c:out value="${aluno.curso}"/></td>
            </tr>
        </c:forEach>
    </table>
    <br>
    <form name="cadastrar" action="novo.jsp" method="post">
        <label>Informe o ID</label><br>
        <input type="number" name="ra" /><br> 
        
         <label>Informe o Nome</label><br>
        <input type="text" name="nome" /><br> 
        
         <label>Informe o Curso</label><br>
        <input type="text" name="curso" /><br> 
        
        <input type="submit" value="cadastrar" />
    </form>
    <a href="index.jsp">Voltar</a>
</body>
</html>
