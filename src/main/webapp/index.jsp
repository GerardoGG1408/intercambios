<%-- 
    Document   : index
    Created on : 7 ene 2021, 18:48:29
    Author     : gerardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="navbar.jsp"%>


        <% if (logged) { %>
            <div class="container" style="height: 100px;">
                <div class="row">
                    <div class="col-sm-3 vh-100 d-inline-block">
                        <h5>Amigos</h5>
                        <h5>Solicitudes de amistad</h5>
                        <h5>Solicitudes de intercambios</h5>
                    </div>
                    <div class="col-sm-9 vh-100 d-inline-block">
                        Crear un intercambio
                    </div>
                </div>
            </div>
        <% } else { %>
            <!-- algo -->
        <% } %>


        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"></script>
        <!-- Font Awesome JS -->
        <script src="https://kit.fontawesome.com/ea8cc6a337.js"></script>
    </body>
</html>


