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


<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <div class="container">
            <div class="row">
                <div class="col">
                    <a href="index.jsp"><i class="fas fa-gifts navbar-brand fa-2x"></i></a>
                </div>
                <div class="col">
                    <%
                        if (logged) {
                    %>
                    <form action="userServlet?accion=listarUsuarios" method="post">
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" placeholder="Buscar amigo" name="friendSearch" id="friendSearch">
                            <input class="btn btn-outline-secondary" type="submit" value="Buscar">
                        </div>
                    </form>
                    <%
                        }
                    %>
                </div>
                <div class="col order-5">
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
            </div>
        </div>
    </div>
</nav>
