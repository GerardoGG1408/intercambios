<%-- 
    Document   : index
    Created on : 7 ene 2021, 18:48:29
    Author     : gerardo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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


        <% if (logged) {%>
        <div class="container-fluid">
            <div class="row min-vh-100 flex-column flex-md-row">
                <aside class="col-12 col-md-3 col-xl-2 p-0 bg-dark flex-shrink-1">
                    <nav class="navbar navbar-expand-md navbar-dark bd-dark flex-md-column flex-row align-items-center py-2 text-center sticky-top" id="socialTab">
                        <div class="text-center p-3">
                            <img src='${img}' alt="profile picture" class="img-fluid rounded-circle my-4 p-1 d-none d-md-block shadow-lg">
                            <a href="#" class="navbar-brand mx-0 font-weight-bold text-nowrap">
                                <%= username%></a>
                        </div>
                        <button class="navbar-toggler border-0 order-1" type="button" data-toogler="collapse" data-target="#nav" aria-controls="nav" aria-expand="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse order-last" id="nav">
                            <ul class="navbar-nav flex-column w-100 justify-content-center">
                                <li class="nav-item">
                                    <a href="#" class="nav-link">Amigos</a>
                                </li>
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
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <a class="btn btn-secondary btn-lg" href="#">Crear un nuevo Intercambio</a>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <% } else { %>
        <!-- algo -->
        <% }%>


        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"></script>
        <!-- Font Awesome JS -->
        <script src="https://kit.fontawesome.com/ea8cc6a337.js"></script>
    </body>
</html>


