package com.ipn.mx.modelo.dao;

import com.ipn.mx.modelo.dto.UsuarioDTO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gerardo
 */
public class UsuarioDAO {

    // JDBC driver
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/intercambios?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";

    //  Database credenciales
    static final String USER = "root";
    static final String PASS = "gERARDO1!";

    private final String SQL_INSERT = "INSERT INTO usuario(email, username, name, lastName, loginStatus, imgRuta, pass) VALUES (?,?,?,?,?,?,?)";
    private final String SQL_UPDATE = "";
    private final String SQL_DELETE = "";
    private final String SQL_READ = "SELECT * FROM usuario WHERE pass = ? AND ( email = ? OR username = ? )";
    private final String SQL_READ_ALL = "";

    private Connection conn = null;

    public void obtenerConexion() {
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL,USER,PASS);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String create(UsuarioDTO dto) {
        obtenerConexion();
        CallableStatement cs = null;
        String completado = null;
        try {
            cs = conn.prepareCall(SQL_INSERT);
            cs.setString(1, dto.getEntidad().getEmail());
            cs.setString(2, dto.getEntidad().getUsername());
            cs.setString(3, dto.getEntidad().getName());
            cs.setString(4, dto.getEntidad().getLastname());
            cs.setString(5, "0");
            cs.setString(6, dto.getEntidad().getRutaIMG());
            cs.setString(7, dto.getEntidad().getPassword());
            cs.executeUpdate();
        } catch (SQLException ex){
            completado = "error";
        } finally {
            if (cs != null) {
                try {
                    cs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (completado == null) {
                completado = "ok";
            }
            return completado;
        }
    }
    
    public UsuarioDTO read(UsuarioDTO dto) throws SQLException {
        obtenerConexion();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.prepareCall(SQL_READ);
            cs.setString(1, dto.getEntidad().getPassword());
            cs.setString(2, dto.getEntidad().getUsername());
            cs.setString(3, dto.getEntidad().getUsername());
            rs = cs.executeQuery();
            List resultados = obtenerResultados(rs);
            if (resultados.size() > 0) {
                return (UsuarioDTO) resultados.get(0);
            } else {
                return null;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (cs != null) {
                cs.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
    private List obtenerResultados(ResultSet rs) throws SQLException {
        List resultados = new ArrayList();
        while (rs.next()) {
            UsuarioDTO dto = new UsuarioDTO();
            dto.getEntidad().setEmail(rs.getString("email"));
            dto.getEntidad().setUsername(rs.getString("username"));
            dto.getEntidad().setName(rs.getString("name"));
            dto.getEntidad().setLastname(rs.getString("lastName"));
            dto.getEntidad().setLoginStatus(rs.getString("loginStatus"));
            dto.getEntidad().setRegisterDate(rs.getDate("registerdate"));
            dto.getEntidad().setPreferences(rs.getString("preferences"));
            dto.getEntidad().setRutaIMG(rs.getString("imgRuta"));
            dto.getEntidad().setPassword(rs.getString("pass"));
            resultados.add(dto);
        }
        return resultados;
    }
}
