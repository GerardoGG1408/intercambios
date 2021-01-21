<%-- 
    Document   : index
    Created on : 7 ene 2021, 18:48:29
    Author     : gerardo
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="com.ipn.mx.modelo.entidades.usuario"%>
<%@page import="com.ipn.mx.modelo.dao.UsuarioDAO"%>
<%@page import="com.ipn.mx.modelo.dto.UsuarioDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    @viewport{
        zoom: 1.0;
        width: extend-to-zoom;
    }
    @-ms-viewport{
        width: extend-to-zoom;
        zoom: 1.0;
    }
</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <title>Inicio</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .abs-center {
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 90vh;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp"%>


        <% if (logged) {
                List<UsuarioDTO> amigos = null;
                UsuarioDAO dao = new UsuarioDAO();
                UsuarioDTO dto = new UsuarioDTO();
                usuario user = new usuario();

                user.setEmail(userLogged);

                dto.setEntidad(user);

                try {
                    amigos = dao.obtenerAmigos(dto);
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
        %>
        <div class="container-fluid">
            <div class="row min-vh-100 flex-column flex-md-row">
                <aside class="col-12 col-md-3 col-xl-2 p-0 bg-dark flex-shrink-1">
                    <nav class="navbar navbar-expand-md navbar-dark bg-dark flex-md-column flex-row align-items-center py-2 text-center sticky-top">
                        <div class="text-center p-3">
                            <img src='<% out.println(img); %>' alt="profile picture" class="img-fluid rounded-circle my-4 p-1 d-none d-md-block shadow" height="300px" width="300px"> 
                            <a href="#" class="navbar-brand mx-0 font-weight-bold text-nowrap"><% out.println(username); %></a>
                        </div>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse order-last" id="navbarTogglerDemo02">
                            <ul class="navbar-nav flex-column w-100 justify-content-center">
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Amigos</a>
                                </li>
                                <% if (amigos != null) {
                                        if (amigos.size() > 0) {
                                            for (int i = 0; i < amigos.size(); i++) {%>
                                <li class="list-group-item bg-dark">
                                    <div class="container">
                                        <div class="row">
                                            <div class="col-lg-2 col">
                                                <img src="<% out.println(amigos.get(i).getEntidad().getRutaIMG()); %>" class="rounded-circle" height="20px" width="20px">
                                            </div>
                                            <div class="col-6">
                                                <p class="text-light bg-dark"><% out.println(amigos.get(i).getEntidad().getUsername()); %></p>
                                            </div>
                                            <div class="col-lg-2 col">
                                                <div class="btn-group" role="group" aria-label="Basic mixed styles example">
                                                    <button type="button" class="btn btn-secondary btn-sm"><i class="fas fa-user-minus"></i></button>
                                                    <button type="button" class="btn btn-secondary btn-sm"><i class="fas fa-eye"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <%}
                                        } else { %>
                                <li class="nav-item"><p class="text-light bg-dark">No tienes amigos</p></li>
                                    <% } %>
                                    <% } else { %>
                                <li class="nav-item"><p class="text-light bg-dark">No tienes amigos</p></li>
                                    <% } %>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Solicitudes de amistad</a>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Solicitudes de intercambio</a>
                                </li>
                            </ul>
                        </div>
                    </nav>

                </aside>
                <main class="col px-0 flex-grow-1">
                    <div class="container py-3">
                        <div class="abs-center">
                            <% if (request.getAttribute("usuarios") == null) { %>
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <a class="btn btn-secondary btn-lg" href="#">Crear un nuevo Intercambio</a>
                            </div>
                            <% } else {
                                List<UsuarioDTO> usuarios_buscados;
                                usuarios_buscados = (List) request.getAttribute("usuarios");
                                if (usuarios_buscados.size() == 1 && usuarios_buscados.get(0).getEntidad().getEmail().equals(userLogged)) {
                            %> <h3> <p>No se encontraron usuarios</p> </h3> <%
                            } else {
                            %>
                            <table class="table">
                                <% for (int i = 0; i < usuarios_buscados.size(); i++) {%>
                                <% if (!usuarios_buscados.get(i).getEntidad().getEmail().equals(userLogged)) { %>
                                <tr class="align-middle">
                                    <td><img src="<% out.println(usuarios_buscados.get(i).getEntidad().getRutaIMG()); %>" class="rounded-circle" height="100px" width="100px"></td>
                                    <th scope="row"><% out.println(usuarios_buscados.get(i).getEntidad().getUsername()); %></th>
                                    <td><a href="userServlet?accion=addFriend&friendId=<%out.println(usuarios_buscados.get(i).getEntidad().getEmail());%>" class="btn btn-secondary"><i class="fas fa-user-plus"></i></a></td>
                                </tr>  
                                <% } %>
                                <% } %>
                            </table>
                            <% }
                                } %>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <% } else { %>
        <div>algo</div>
        <% }%>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"></script>
        <!-- Font Awesome JS -->
        <script src="https://kit.fontawesome.com/ea8cc6a337.js"></script>
    </body>
</html>


