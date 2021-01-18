package com.ipn.mx.modelo.dao;

import com.ipn.mx.modelo.dto.AmistadDTO;
import com.ipn.mx.modelo.dto.UsuarioDTO;
import com.ipn.mx.modelo.entidades.usuario;
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
    static final String DB_URL = "jdbc:mysql://jhdjjtqo9w5bzq2t.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/kxu377ur947k5ne1?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";

    //  Database credenciales
    static final String USER = "sy9fbnddkd69lxtm";
    static final String PASS = "sdjelioiykq4rgr3";

    private final String SQL_INSERT = "INSERT INTO usuario(email, username, name, lastName, loginStatus, imgRuta, pass) VALUES (?,?,?,?,?,?,?)";
    private final String SQL_UPDATE = "";
    private final String SQL_DELETE = "";
    private final String SQL_READ = "SELECT * FROM usuario WHERE pass = ? AND ( email = ? OR username = ? )";
    private final String SQL_READ_FRIEND = "SELECT * FROM usuario WHERE email = ?";
    private final String SQL_READ_ALL = "";
    private final String SQL_READ_FRIENDS = "SELECT * FROM listaAmigos WHERE userId = ? or userId_friend = ?";
    private final String SQL_SEARCH = "SELECT * FROM usuario WHERE username like ?";
    private final String SQL_ADD_FRIEND = "INSERT INTO listaAmigos(userId, userId_friend, status) values (?,?,?)";

    private Connection conn = null;

    public void obtenerConexion() {
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List readUsuarios(UsuarioDTO dto) throws SQLException {
        obtenerConexion();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.prepareCall(SQL_SEARCH);
            cs.setString(1, "%" + dto.getEntidad().getUsername() + "%");
            rs = cs.executeQuery();
            List resultados = obtenerResultados(rs);
            if (resultados.size() > 0) {
                return resultados;
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
        } catch (SQLException ex) {
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
    
    public UsuarioDTO readFriend(UsuarioDTO dto) throws SQLException {
        obtenerConexion();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.prepareCall(SQL_READ_FRIEND);
            cs.setString(1, dto.getEntidad().getEmail());
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

    public List obtenerAmigos(UsuarioDTO dto) throws SQLException {
        obtenerConexion();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.prepareCall(SQL_READ_FRIENDS);
            cs.setString(1, dto.getEntidad().getEmail());
            cs.setString(2, dto.getEntidad().getEmail());
            rs = cs.executeQuery();
            List resultados = obtenerListaAmigos(rs, dto.getEntidad().getEmail());
            if (resultados.size() > 0) {
                return resultados;
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

    public String addFriend(AmistadDTO dto) {
        obtenerConexion();
        CallableStatement cs = null;
        String completado = null;
        try {
            cs = conn.prepareCall(SQL_ADD_FRIEND);
            cs.setString(1, dto.getEntidad().getEmail());
            cs.setString(2, dto.getEntidad().getAmigo());
            cs.setInt(3, dto.getEntidad().getStatus());
            cs.executeUpdate();
        } catch (SQLException ex) {
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

    private List obtenerListaAmigos(ResultSet rs, String logged) throws SQLException {
        List resultados = new ArrayList();
        while (rs.next()) {
            UsuarioDTO dto = new UsuarioDTO();
            usuario user = new usuario();
            
            if(rs.getString("userId_friend").equals(logged)){
                user.setEmail(rs.getString("userId"));
            } else {
                user.setEmail(rs.getString("userId_friend"));
            }

            dto.setEntidad(user);

            resultados.add(readFriend(dto));
        }
        return resultados;
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
