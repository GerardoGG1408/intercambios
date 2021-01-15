<%-- 
    Document   : navbar
    Created on : 7 ene 2021, 18:48:41
    Author     : gerardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    boolean logged = false;
    String userLogged = "";
    String img = "";
    String username = "";

    if (session.getAttribute("userId") == null) {
        logged = false;
    } else {
        userLogged = (String) session.getAttribute("userId");
        img = (String) session.getAttribute("img");
        username = (String) session.getAttribute("username");
        logged = true;
    }
%>


<nav class="navbar navbar-dark bg-dark sticky-top">
    <div class="container-fluid">
        <i class="fas fa-gifts navbar-brand fa-2x"></i>
        <a class="navbar-brand" href="#"><h3>ESCOM</h3></a>
        <div class="btn-group dropstart md-2">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                <%
                    if (logged) {
                %>
                <img src='${img}' class="rounded-circle" height="20px" width="20px">
                <%
                } else {
                %>
                <i class="far fa-user"></i>
                <%
                    }
                %>
            </button>
            <ul class="dropdown-menu">
                <%
                    if (logged) {
                %>
                <li><a class="dropdown-item" href="#">Perfil</a></li>
                <li><a class="dropdown-item" href="userServlet?accion=logout">Cerrar sesion</a></li>
                    <%
                    } else {
                    %>
                <li><a class="dropdown-item" href="login.jsp">Iniciar sesion</a></li>
                <li><a class="dropdown-item" href="register.jsp">Registrarse</a></li>
                    <%
                        }
                    %>
            </ul>
        </div>
    </div>
</nav>
