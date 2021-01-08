<%-- 
    Document   : navbar
    Created on : 7 ene 2021, 18:48:41
    Author     : gerardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    boolean logged = false;
    String userLogged = "";

    if (session.getAttribute("userId") == null) {
        logged = false;
    } else {
        userLogged = (String) session.getAttribute("userId");
        logged = true;
    }
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand" href="#">ESCOM</a>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Productos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Usuarios</a>
                </li>
            </ul>

            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="far fa-user"></i>
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                    <%
                        if (logged) {
                    %>
                    <li><a class="dropdown-item" href="#">Perfil</a></li>
                    <li><a class="dropdown-item" href="#">Mis productos</a></li>
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
    </div>
</nav>
