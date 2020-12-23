package ru.vuan.graphql.model;

import liquibase.Contexts;
import liquibase.LabelExpression;
import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.exception.LiquibaseException;
import liquibase.resource.ClassLoaderResourceAccessor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.NoSuchElementException;
import java.util.jar.Attributes;
import java.util.jar.JarFile;
import java.util.jar.Manifest;

public class ApplicationModel {
    private static final Logger log = LoggerFactory.getLogger(ApplicationModel.class.getName());
    private static final String DEFAULT_CONTEXTS = "main";
    private static final String DEFAULT_VERSION = "Version";

    public static void main(String[] args) {

        Liquibase liquibase = null;
        Connection c = null;
        var changeLog = "db/changelog/changelog-master.yml";
        final var tag = getInfoFromManifest(DEFAULT_VERSION);
        final var contexts = new Contexts(DEFAULT_CONTEXTS);
        try {

            c = DriverManager.getConnection("jdbc:postgresql://" +
                            System.getenv("DB_HOST") + ":" +
                            System.getenv("DB_PORT") + "/" +
                            System.getenv("DB_DATABASE"),
                    System.getenv().get("DB_USER"),
                    System.getenv().get("DB_PASSWORD"));
            if (c != null) {
                c.setAutoCommit(false);
                if (args != null && args.length > 0) {
                    changeLog = String.format("db/changelog/%s-master.yml", args[0]);
                }
                var database = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(new JdbcConnection(c));
                System.out.println(changeLog);
                liquibase = new Liquibase(changeLog, new ClassLoaderResourceAccessor(), database);

                liquibase.tag(tag);
                liquibase.update(contexts);
                c.commit();
            }
        } catch (SQLException | LiquibaseException e) {
            if (liquibase != null) {
                try {
                    liquibase.rollback(String.valueOf(new LabelExpression(tag)), DEFAULT_CONTEXTS);
                } catch (LiquibaseException e1) {
                    e1.printStackTrace();
                    log.error("Error rollback liquibase", e1);
                }
            }
            try {
                if (c != null){
                    c.rollback();
                }
            } catch (Exception e1) {
//                e1.printStackTrace();
                log.error("Error rollback connection", e1);
            }
            log.error("Error migration", e);
//            e.printStackTrace();
            throw new NoSuchElementException(e.getMessage());
        } finally {
            if (c != null) {
                try {
                    c.close();
                } catch (SQLException e) {
//                    e.printStackTrace();
                    log.error("Error close connection",e);
                }
            }
        }
    }

    private static String getInfoFromManifest(String property) {
        try {
            File file = new File(ApplicationModel.class.getProtectionDomain().getCodeSource().getLocation().toURI());
            if (file.isFile()) {
                JarFile jarFile = new JarFile(file);
                Manifest manifest = jarFile.getManifest();
                Attributes attributes = manifest.getMainAttributes();
                return attributes.getValue(property);
            }
        } catch (URISyntaxException | IOException e) {
            e.printStackTrace();
        }
        return "none";
    }
}
